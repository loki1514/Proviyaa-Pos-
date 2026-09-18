import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'online_orders_store.dart';

class SupabaseOnlineOrdersStore implements OnlineOrdersStore {
  SupabaseOnlineOrdersStore({
    SupabaseClient? client,
    bool autoInit = true,
  }) : _client = client {
    if (autoInit) {
      init();
    }
  }

  SupabaseClient? _client;
  StreamSubscription<List<Map<String, dynamic>>>? _realtimeSub;

  final _stateController = StreamController<OnlineOrdersState>.broadcast();

  // Stable keyed map to strictly prevent duplicate orders
  final Map<String, OnlineOrderRow> _ordersById = {};

  OnlineOrdersState _state = const OnlineOrdersState.loading();
  OnlineOrdersState get state => _state;

  SupabaseClient? get client {
    if (_client != null) return _client;
    try {
      _client = Supabase.instance.client;
    } catch (_) {
      _client = null;
    }
    return _client;
  }

  List<OnlineOrderRow> _sortedOrders() {
    return _ordersById.values.toList();
  }

  void _emitState(OnlineOrdersState newState) {
    _state = newState;
    if (!_stateController.isClosed) {
      _stateController.add(_state);
    }
  }

  Future<void> init() async {
    _emitState(const OnlineOrdersState.loading());

    final sbClient = client;
    if (sbClient == null) {
      _ordersById.clear();
      _emitState(const OnlineOrdersState.error(
        'Supabase is not configured. Please verify SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY in .env.local.',
      ));
      return;
    }

    try {
      // 1. Fetch only actual orders from Supabase (ordered newest first)
      final response = await sbClient
          .from('online_orders')
          .select()
          .order('created_at', ascending: false);

      _ordersById.clear();
      for (final raw in (response as List)) {
        final row = OnlineOrderRow.fromJson(raw as Map<String, dynamic>);
        _ordersById[row.orderId] = row; // Keyed deduplication
      }

      _emitState(OnlineOrdersState.success(_sortedOrders()));

      // 2. Subscribe to Supabase Realtime changes
      _subscribeRealtime(sbClient);
    } catch (e) {
      debugPrint('Error fetching orders from Supabase: $e');
      _ordersById.clear();
      _emitState(OnlineOrdersState.error(
        'Failed to connect to Supabase: ${e.toString()}',
      ));
    }
  }

  void _subscribeRealtime(SupabaseClient sbClient) {
    _realtimeSub?.cancel();
    try {
      _realtimeSub = sbClient
          .from('online_orders')
          .stream(primaryKey: ['order_id']).listen((data) {
        _ordersById.clear();
        for (final item in data) {
          final row = OnlineOrderRow.fromJson(item);
          _ordersById[row.orderId] = row; // Keyed deduplication
        }
        _emitState(OnlineOrdersState.success(_sortedOrders()));
      }, onError: (err) {
        debugPrint('Supabase realtime stream error: $err');
      });
    } catch (e) {
      debugPrint('Supabase realtime setup failed: $e');
    }
  }

  @override
  Stream<OnlineOrdersState> watchState() async* {
    yield _state;
    yield* _stateController.stream;
  }

  @override
  Stream<List<OnlineOrderRow>> watchOrders() async* {
    yield _sortedOrders();
    yield* _stateController.stream.map((s) => s.orders);
  }

  @override
  Future<List<OnlineOrderRow>> getOrders() async {
    return _sortedOrders();
  }

  @override
  Future<void> insertOrder(OnlineOrderRow order) async {
    final sbClient = client;
    if (sbClient == null) {
      throw StateError('Supabase is not connected');
    }

    final payload = order.toJson();
    payload['created_at'] = DateTime.now().toIso8601String();
    payload['updated_at'] = DateTime.now().toIso8601String();

    await sbClient.from('online_orders').insert(payload);

    _ordersById[order.orderId] = order;
    _emitState(OnlineOrdersState.success(_sortedOrders()));
  }

  @override
  Future<void> updateStatus(
      String orderId, String newStatus, String newActionLabel) async {
    final sbClient = client;
    if (sbClient == null) {
      throw StateError('Supabase is not connected');
    }

    await sbClient.from('online_orders').update({
      'status': newStatus,
      'action_label': newActionLabel,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('order_id', orderId);

    final existing = _ordersById[orderId];
    if (existing != null) {
      _ordersById[orderId] = existing.copyWith(
        status: newStatus,
        actionLabel: newActionLabel,
      );
      _emitState(OnlineOrdersState.success(_sortedOrders()));
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    final sbClient = client;
    if (sbClient == null) {
      throw StateError('Supabase is not connected');
    }

    await sbClient.from('online_orders').delete().eq('order_id', orderId);

    _ordersById.remove(orderId);
    _emitState(OnlineOrdersState.success(_sortedOrders()));
  }

  @override
  Future<void> refresh() async {
    await init();
  }

  void dispose() {
    _realtimeSub?.cancel();
    _stateController.close();
  }
}

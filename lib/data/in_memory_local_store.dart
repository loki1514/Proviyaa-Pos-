import '../application/order_service.dart';
import '../domain/order.dart';

class InMemoryLocalStore implements PosLocalStore {
  final Map<String, LocalOrder> _orders = {};
  @override
  Future<void> saveOrderWithPendingIntent(LocalOrder order) async {
    _orders.putIfAbsent(order.clientOrderId, () => order);
  }

  @override
  Future<LocalOrder?> findOrder(String id) async => _orders[id];
}

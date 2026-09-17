import 'package:flutter/material.dart';

import 'application/kitchen_service.dart';
import 'application/order_service.dart';
import 'application/payment_service.dart';
import 'config/app_config.dart';
import 'data/app_database.dart';
import 'data/drift_all_orders_store.dart';
import 'data/drift_kitchen_store.dart';
import 'data/drift_local_store.dart';
import 'data/drift_menu_store.dart';
import 'data/drift_payment_store.dart';
import 'data/drift_table_store.dart';
import 'data/local_dine_in_catalog.dart';
import 'domain/restaurant_table.dart';
import 'presentation/all_orders_screen.dart';
import 'presentation/delivery_screen.dart';
import 'presentation/dine_in_screen.dart';
import 'presentation/kitchen_display_screen.dart';
import 'presentation/menu_management_screen.dart';
import 'presentation/online_orders_screen.dart';
import 'presentation/pos_order_screen.dart';
import 'presentation/pos_shell.dart';
import 'presentation/pos_sidebar.dart';
import 'presentation/tables_screen.dart';
import 'presentation/takeaway_screen.dart';
import 'presentation/vinii_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviyaaPosApp(config: AppConfig.fromDartDefines()));
}

/// One enrolled device serves one location for V1 (D02: one primary POS
/// per location; multi-terminal offline coordination is deferred). This
/// placeholder id stands in for the real value device bootstrap (Phase
/// B) will supply.
const _demoLocationId = 'location-demo';

/// Stand-in for the signed-in staff session shown in the sidebar footer
/// until real auth (lib/application/auth_service.dart) is wired into the
/// UI — see the "ideal first screen" discussion: no login screen exists
/// in any of the 36 v1/ references, so nothing here is skipping a
/// designed screen.
const _demoStaffName = 'Rahul Sharma';
const _demoBranchName = 'Latur Main Branch';

class ProviyaaPosApp extends StatefulWidget {
  const ProviyaaPosApp({super.key, required this.config, this.database});
  final AppConfig config;

  /// Overrides the real on-device database — for tests only. Constructing
  /// the real `AppDatabase.defaults()` (native file-backed, via
  /// drift_flutter) inside a `flutter test` widget test leaves a
  /// background timer pending past the pumped frame, which the test
  /// binding treats as a leak. Pass an in-memory `AppDatabase` instead.
  final AppDatabase? database;

  @override
  State<ProviyaaPosApp> createState() => _ProviyaaPosAppState();
}

class _ProviyaaPosAppState extends State<ProviyaaPosApp> {
  // Lazily created on first build, once per app process — this is the
  // real on-device Drift/SQLite database (R17), not a mock, unless a
  // test supplied its own via widget.database. It auto-creates its file
  // on first launch; see lib/data/app_database.dart.
  late final AppDatabase _db = widget.database ?? AppDatabase.defaults();
  late final _localStore = DriftLocalStore(_db);
  late final _orderService = OrderService(_localStore);
  late final _kitchenService = KitchenService(DriftKitchenStore(_db));
  late final _paymentService = PaymentService(DriftPaymentStore(_db));
  late final _tableStore = DriftTableStore(_db);
  late final _allOrdersStore = DriftAllOrdersStore(_db);
  late final _menuStore = DriftMenuStore(_db);

  PosModule _selected = PosModule.dineIn;

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Proviyaa POS',
      theme: viniiLightTheme(),
      // v1/POS-DINE-IN-V3.png (this shell's source of truth) is a light
      // design; forcing light regardless of the OS setting is what fixes
      // the "app launches black" report — that was ThemeMode.system
      // picking viniiDarkTheme() because the host OS is in dark mode,
      // not a deliberate dark-theme choice for this screen.
      themeMode: ThemeMode.light,
      home: Builder(
          // Builder gives a context that is a *descendant* of the
          // Navigator MaterialApp just created — the outer `build`
          // context above is not (it's the context that builds
          // MaterialApp itself), so Navigator.of(context) in _openOrder
          // would throw "context does not include a Navigator" if we
          // passed that one instead.
          builder: (innerContext) => PosShell(
              selected: _selected,
              onSelect: (m) => _onSelect(innerContext, m),
              onNewOrder: () => _openOrder(innerContext, null),
              onOpenKitchen: () => _openKitchen(innerContext),
              staffName: _demoStaffName,
              branchName: _demoBranchName,
              content: _content(innerContext))));

  /// POS is an action (open the order-capture flow), not a board to sit
  /// on — v1/POS-MAIN-V3.png shows it as the full item-grid + cart
  /// screen, which already exists as PosOrderScreen (tested, working)
  /// and owns its own full-route push to Payment. Every other nav item
  /// is a board that replaces the shell's content area in place.
  void _onSelect(BuildContext context, PosModule module) {
    if (module == PosModule.pos) {
      _openOrder(context, null);
    } else {
      setState(() => _selected = module);
    }
  }

  Widget _content(BuildContext context) => switch (_selected) {
        PosModule.tables => TablesScreen(
            tableStore: _tableStore,
            onOpenTable: (t) => _openOrder(context, t),
            onStartOrder: (t) => _openOrder(context, t)),
        PosModule.dineIn => DineInScreen(
            onOpenOrder: (t) => _openOrder(context, _asRestaurantTable(t)),
            onStartOrder: (t) => _openOrder(context, _asRestaurantTable(t))),
        PosModule.allOrders => AllOrdersScreen(ordersStore: _allOrdersStore),
        PosModule.takeaway => const TakeawayScreen(),
        PosModule.delivery => const DeliveryScreen(),
        PosModule.online => const OnlineOrdersScreen(),
        PosModule.menu => MenuManagementScreen(menuStore: _menuStore),
        // Selecting POS immediately pushes a route (see _onSelect) and
        // never actually renders this; kept only so the switch is
        // exhaustive over PosModule.
        PosModule.pos => const PosModulePlaceholder(title: 'POS'),
      };

  /// PosOrderScreen (an existing, tested, full-route flow with its own
  /// AppBar and its own push to PaymentScreen) only ever reads
  /// `table.label` — see the call sites in pos_order_screen.dart. Rather
  /// than reshaping DineInTable into the Tables page's different
  /// 4-status RestaurantTable model, a minimal bridge value carries just
  /// the label across.
  RestaurantTable _asRestaurantTable(DineInTable t) => RestaurantTable(
      id: t.label,
      label: t.label,
      seats: t.seats ?? t.guestCount ?? 0,
      zone: TableZone.indoor,
      status: TableStatus.occupied);

  void _openOrder(BuildContext context, RestaurantTable? table) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PosOrderScreen(
            orderService: _orderService,
            kitchenService: _kitchenService,
            paymentService: _paymentService,
            allOrdersStore: _allOrdersStore,
            tableStore: _tableStore,
            menuStore: _menuStore,
            locationId: _demoLocationId,
            table: table)));
  }

  void _openKitchen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Kitchen Display')),
            body: KitchenDisplayScreen(
                kitchenService: _kitchenService, localStore: _localStore))));
  }
}

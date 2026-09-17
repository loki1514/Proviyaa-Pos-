import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_all_orders_store.dart';
import 'package:proviyaa_pos/data/local_all_orders_catalog.dart';

void main() {
  group('DriftAllOrdersStore CRUD', () {
    late AppDatabase db;
    late DriftAllOrdersStore store;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      store = DriftAllOrdersStore(db);
    });

    tearDown(() => db.close());

    test('starts with empty database without static seed', () async {
      final orders = await store.getAllOrders();
      expect(orders, isEmpty);
    });

    test('insertOrder saves a new order into SQLite', () async {
      const order = AllOrdersRow(
        orderId: '#1088',
        type: 'Takeaway',
        source: 'Walk-in',
        tableOrCustomer: 'Karan Mehra',
        itemsLabel: '2 items',
        amountMinor: 45000,
        status: 'New',
        time: 'Just now',
      );

      await store.insertOrder(order);

      final orders = await store.getAllOrders();
      expect(orders.length, 1);
      expect(orders.first.orderId, '#1088');
      expect(orders.first.tableOrCustomer, 'Karan Mehra');
      expect(orders.first.amountMinor, 45000);
      expect(orders.first.status, 'New');
    });

    test('updateOrder modifies order details', () async {
      const initial = AllOrdersRow(
        orderId: '#1088',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 4',
        itemsLabel: '1 item',
        amountMinor: 20000,
        status: 'New',
        time: 'Just now',
      );
      await store.insertOrder(initial);

      const updated = AllOrdersRow(
        orderId: '#1088',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 4 (VIP)',
        itemsLabel: '3 items',
        amountMinor: 65000,
        status: 'Preparing',
        time: 'Just now',
      );
      await store.updateOrder(updated);

      final orders = await store.getAllOrders();
      expect(orders.length, 1);
      expect(orders.first.tableOrCustomer, 'Table 4 (VIP)');
      expect(orders.first.itemsLabel, '3 items');
      expect(orders.first.amountMinor, 65000);
      expect(orders.first.status, 'Preparing');
    });

    test('updateStatus changes only status field', () async {
      const order = AllOrdersRow(
        orderId: '#1088',
        type: 'Takeaway',
        source: 'Zomato',
        tableOrCustomer: 'Neha Roy',
        itemsLabel: '2 items',
        amountMinor: 52000,
        status: 'New',
        time: 'Just now',
      );
      await store.insertOrder(order);

      await store.updateStatus('#1088', 'Completed');

      final orders = await store.getAllOrders();
      expect(orders.first.status, 'Completed');
    });

    test('deleteOrder removes order from SQLite', () async {
      const order = AllOrdersRow(
        orderId: '#1088',
        type: 'Delivery',
        source: 'Swiggy',
        tableOrCustomer: 'Vikram Seth',
        itemsLabel: '1 item',
        amountMinor: 31000,
        status: 'Ready',
        time: 'Just now',
      );
      await store.insertOrder(order);
      expect((await store.getAllOrders()).length, 1);

      await store.deleteOrder('#1088');
      expect((await store.getAllOrders()).length, 0);
    });

    test('watchAllOrders emits reactive stream updates', () async {
      await store.insertOrder(const AllOrdersRow(
        orderId: '#1001',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 1',
        itemsLabel: '1 item',
        amountMinor: 10000,
        status: 'New',
        time: 'Just now',
      ));

      final first = await store.watchAllOrders().first;
      expect(first.length, 1);

      await store.insertOrder(const AllOrdersRow(
        orderId: '#1002',
        type: 'Takeaway',
        source: 'Walk-in',
        tableOrCustomer: 'Anita',
        itemsLabel: '2 items',
        amountMinor: 25000,
        status: 'Ready',
        time: 'Just now',
      ));

      final second = await store.watchAllOrders().first;
      expect(second.length, 2);
    });
  });
}

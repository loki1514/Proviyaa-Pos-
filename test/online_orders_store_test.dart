import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/data/online_orders_store.dart';
import 'package:proviyaa_pos/data/supabase_online_orders_store.dart';
import 'package:proviyaa_pos/presentation/online_orders_screen.dart';

void main() {
  group('OnlineOrdersStore (No Dummy Data & Stable Deduplication)', () {
    late InMemoryOnlineOrdersStore store;

    setUp(() {
      store = InMemoryOnlineOrdersStore();
    });

    tearDown(() {
      store.dispose();
    });

    test('Initializes strictly empty without dummy orders', () async {
      final orders = await store.getOrders();
      expect(orders, isEmpty);
    });

    test('CRUD - Insert (Create) single order', () async {
      const newOrder = OnlineOrderRow(
        orderId: '#TEST-1001',
        platform: 'Z',
        customer: 'John Doe',
        itemsLabel: '1x Biryani',
        amountMinor: 25000,
        status: 'Pending',
        time: '7:00 PM',
        actionLabel: 'Accept',
      );

      await store.insertOrder(newOrder);

      final orders = await store.getOrders();
      expect(orders.length, equals(1));
      expect(orders.first.orderId, equals('#TEST-1001'));
      expect(orders.first.customer, equals('John Doe'));
    });

    test('Deduplication - inserting same order ID does not create duplicates',
        () async {
      const order = OnlineOrderRow(
        orderId: '#STABLE-1',
        platform: 'S',
        customer: 'Rahul',
        itemsLabel: '1x Pizza',
        amountMinor: 35000,
        status: 'Pending',
        time: '6:00 PM',
        actionLabel: 'Accept',
      );

      await store.insertOrder(order);
      await store.insertOrder(order); // duplicate insert

      final orders = await store.getOrders();
      expect(orders.length, equals(1));
    });

    test('CRUD - Update / Accept order status', () async {
      const order = OnlineOrderRow(
        orderId: '#TEST-1001',
        platform: 'Z',
        customer: 'John Doe',
        itemsLabel: '1x Biryani',
        amountMinor: 25000,
        status: 'Pending',
        time: '7:00 PM',
        actionLabel: 'Accept',
      );
      await store.insertOrder(order);

      await store.updateStatus('#TEST-1001', 'Accepted', 'Prepare');

      final orders = await store.getOrders();
      final updated = orders.firstWhere((o) => o.orderId == '#TEST-1001');
      expect(updated.status, equals('Accepted'));
      expect(updated.actionLabel, equals('Prepare'));
    });

    test('CRUD - Delete / Reject order', () async {
      const order = OnlineOrderRow(
        orderId: '#TEST-1001',
        platform: 'Z',
        customer: 'John Doe',
        itemsLabel: '1x Biryani',
        amountMinor: 25000,
        status: 'Pending',
        time: '7:00 PM',
        actionLabel: 'Accept',
      );
      await store.insertOrder(order);

      await store.deleteOrder('#TEST-1001');

      final orders = await store.getOrders();
      expect(orders, isEmpty);
    });
  });

  group('SupabaseOnlineOrdersStore Error State', () {
    test(
        'Unconfigured client sets error state without falling back to dummy data',
        () async {
      final sbStore = SupabaseOnlineOrdersStore(client: null, autoInit: false);
      addTearDown(sbStore.dispose);

      await sbStore.init();

      expect(sbStore.state.isError, isTrue);
      expect(sbStore.state.orders, isEmpty);
      expect(
          sbStore.state.errorMessage, contains('Supabase is not configured'));
    });
  });

  group('OnlineOrdersScreen Widget Tests (Empty, Loading, Success, CRUD)', () {
    late InMemoryOnlineOrdersStore store;

    setUp(() {
      store = InMemoryOnlineOrdersStore();
    });

    tearDown(() {
      store.dispose();
    });

    testWidgets('Empty database shows "No orders found" and zero dummy rows',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnlineOrdersScreen(ordersStore: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Online Orders'), findsOneWidget);
      expect(find.text('0 orders today'), findsOneWidget);
      expect(find.text('No orders found'), findsOneWidget);
      expect(find.text('There are currently no online orders in Supabase.'),
          findsOneWidget);
      // Verify no dummy rows exist
      expect(find.text('#ZOM-4821'), findsNothing);
      expect(find.text('Priya Verma'), findsNothing);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('Full CRUD flow: Create -> Accept -> Reject (Delete)',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnlineOrdersScreen(ordersStore: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Initially Empty
      expect(find.text('No orders found'), findsOneWidget);

      // 2. Click '+ New Order'
      await tester.tap(find.text('New Order'));
      await tester.pumpAndSettle();

      expect(find.text('New Online Order'), findsOneWidget);

      // Enter customer name
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Customer Name'), 'Anita Sharma');

      // Select 'Paneer Butter Masala' (price ₹320)
      await tester.tap(find.text('Paneer Butter Masala'));
      await tester.pumpAndSettle();

      // Tap '+' to make it 2x: Subtotal ₹640, GST ₹32, Total ₹672
      final dialogAddIcon = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byIcon(Icons.add),
      );
      await tester.tap(dialogAddIcon);
      await tester.pumpAndSettle();

      expect(find.text('₹672.00'), findsOneWidget);

      // Click 'Create Order'
      await tester.tap(find.text('Create Order'));
      await tester.pumpAndSettle();

      // 3. Order is created and displayed in the table
      expect(find.text('No orders found'), findsNothing);
      expect(find.text('Anita Sharma'), findsOneWidget);
      expect(find.text('2x Paneer Butter Masala'), findsOneWidget);
      expect(find.text('₹672'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);

      // 4. Accept the order
      final acceptBtn = find.widgetWithText(FilledButton, 'Accept');
      expect(acceptBtn, findsOneWidget);

      await tester.tap(acceptBtn);
      await tester.pumpAndSettle();

      // Switch to 'Accepted' tab
      final acceptedTab = find.byWidgetPredicate(
        (widget) =>
            widget is ChoiceChip &&
            widget.label is Text &&
            ((widget.label as Text).data ?? '').startsWith('Accepted'),
      );
      await tester.tap(acceptedTab);
      await tester.pumpAndSettle();

      expect(find.text('Anita Sharma'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Prepare'), findsOneWidget);

      // 5. Delete the order (Reject/Delete functionality)
      final deleteBtn = find.widgetWithText(TextButton, 'Delete');
      expect(deleteBtn, findsOneWidget);

      await tester.tap(deleteBtn);
      await tester.pumpAndSettle();

      // Confirm deletion in dialog
      expect(find.text('Reject & Delete'), findsOneWidget);
      await tester.tap(find.text('Reject & Delete'));
      await tester.pumpAndSettle();

      // 6. Verify table returns to empty state
      // Switch back to 'All' status tab to check all orders
      final allTab = find.byWidgetPredicate(
        (widget) =>
            widget is ChoiceChip &&
            widget.label is Text &&
            RegExp(r'^All\s+\d+$').hasMatch((widget.label as Text).data ?? ''),
      );
      await tester.tap(allTab);
      await tester.pumpAndSettle();

      expect(find.text('No orders found'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  });
}

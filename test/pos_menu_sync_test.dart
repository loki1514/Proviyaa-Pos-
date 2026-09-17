import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/kitchen_service.dart';
import 'package:proviyaa_pos/application/order_service.dart';
import 'package:proviyaa_pos/application/payment_service.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_kitchen_store.dart';
import 'package:proviyaa_pos/data/drift_local_store.dart';
import 'package:proviyaa_pos/data/drift_menu_store.dart';
import 'package:proviyaa_pos/data/drift_payment_store.dart';
import 'package:proviyaa_pos/data/drift_table_store.dart';
import 'package:proviyaa_pos/domain/menu.dart';
import 'package:proviyaa_pos/presentation/pos_order_screen.dart';

void main() {
  group('POS Menu & Category DB Sync', () {
    late AppDatabase db;
    late DriftMenuStore menuStore;
    late DriftTableStore tableStore;
    late DriftLocalStore localStore;
    late OrderService orderService;
    late KitchenService kitchenService;
    late PaymentService paymentService;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      menuStore = DriftMenuStore(db);
      tableStore = DriftTableStore(db);
      localStore = DriftLocalStore(db);
      orderService = OrderService(localStore);
      kitchenService = KitchenService(DriftKitchenStore(db));
      paymentService = PaymentService(DriftPaymentStore(db));
    });

    tearDown(() => db.close());

    testWidgets(
        'renders clean empty state when database is empty (no static mock items)',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: PosOrderScreen(
            orderService: orderService,
            kitchenService: kitchenService,
            paymentService: paymentService,
            tableStore: tableStore,
            menuStore: menuStore,
            locationId: 'demo-loc',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify category sidebar empty state
      expect(find.text('No categories in database'), findsOneWidget);

      // Verify item grid empty state
      expect(
          find.text('No categories or items in database yet'), findsOneWidget);
      expect(
          find.text(
              'Add categories and items in Menu Management to start taking orders.'),
          findsOneWidget);

      // Ensure NO static items like 'Paneer Butter Masala' exist without being in DB
      expect(find.text('Paneer Butter Masala'), findsNothing);
      expect(find.text('Chicken Tikka'), findsNothing);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets(
        'renders live categories with count badges and filters items on selection',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Seed categories in SQLite
      await menuStore.insertCategory(
          const MenuCategory(id: 'beverages', name: 'Beverages'));
      await menuStore
          .insertCategory(const MenuCategory(id: 'desserts', name: 'Desserts'));

      // Seed items in SQLite
      await menuStore.insertItem(const MenuItem(
        id: 'masala-chai',
        categoryId: 'beverages',
        name: 'Masala Chai',
        priceMinor: 4000,
        isVeg: true,
      ));
      await menuStore.insertItem(const MenuItem(
        id: 'cold-coffee',
        categoryId: 'beverages',
        name: 'Cold Coffee',
        priceMinor: 12000,
        isVeg: true,
      ));
      await menuStore.insertItem(const MenuItem(
        id: 'gulab-jamun',
        categoryId: 'desserts',
        name: 'Gulab Jamun',
        priceMinor: 9000,
        isVeg: true,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: PosOrderScreen(
            orderService: orderService,
            kitchenService: kitchenService,
            paymentService: paymentService,
            tableStore: tableStore,
            menuStore: menuStore,
            locationId: 'demo-loc',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check category tiles and item counts
      expect(find.text('All Items'), findsWidgets);
      expect(find.text('Beverages'), findsWidgets);
      expect(find.text('Desserts'), findsWidgets);

      // Total items count = 3, Beverages = 2, Desserts = 1
      expect(find.text('3'), findsWidgets); // All items count
      expect(find.text('2'), findsWidgets); // Beverages count
      expect(find.text('1'), findsWidgets); // Desserts count

      // All 3 items should appear on "All Items"
      expect(find.text('Masala Chai'), findsOneWidget);
      expect(find.text('Cold Coffee'), findsOneWidget);
      expect(find.text('Gulab Jamun'), findsOneWidget);

      // Tap on "Beverages" category tile
      final beveragesTile = find.text('Beverages').first;
      await tester.tap(beveragesTile);
      await tester.pumpAndSettle();

      // Only Beverages should be displayed in grid
      expect(find.text('Masala Chai'), findsOneWidget);
      expect(find.text('Cold Coffee'), findsOneWidget);
      expect(find.text('Gulab Jamun'), findsNothing);

      // Tap on "Desserts" category tile
      final dessertsTile = find.text('Desserts').first;
      await tester.tap(dessertsTile);
      await tester.pumpAndSettle();

      // Only Desserts should be displayed in grid
      expect(find.text('Gulab Jamun'), findsOneWidget);
      expect(find.text('Masala Chai'), findsNothing);
      expect(find.text('Cold Coffee'), findsNothing);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('unavailable items in DB cannot be added to cart',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await menuStore
          .insertCategory(const MenuCategory(id: 'specials', name: 'Specials'));
      await menuStore.insertItem(const MenuItem(
        id: 'special-thali',
        categoryId: 'specials',
        name: 'Special Thali',
        priceMinor: 25000,
        isVeg: true,
        available: false,
        unavailableReason: 'Sold Out',
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: PosOrderScreen(
            orderService: orderService,
            kitchenService: kitchenService,
            paymentService: paymentService,
            tableStore: tableStore,
            menuStore: menuStore,
            locationId: 'demo-loc',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Special Thali'), findsOneWidget);
      expect(find.text('Sold Out'), findsOneWidget);

      // Tap unavailable item
      await tester.tap(find.text('Special Thali'));
      await tester.pumpAndSettle();

      // Cart should remain empty
      expect(find.text('No items yet — tap a menu item to add it.'),
          findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets(
        'adds items to cart and computes accurate subtotal, tax and total from DB',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await menuStore
          .insertCategory(const MenuCategory(id: 'snacks', name: 'Snacks'));
      await menuStore.insertItem(const MenuItem(
        id: 'samosa',
        categoryId: 'snacks',
        name: 'Samosa',
        priceMinor: 2000, // ₹20.00
        isVeg: true,
        available: true,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: PosOrderScreen(
            orderService: orderService,
            kitchenService: kitchenService,
            paymentService: paymentService,
            tableStore: tableStore,
            menuStore: menuStore,
            locationId: 'demo-loc',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Samosa to add to cart
      final samosaCard = find.text('Samosa');
      await tester.tap(samosaCard);
      await tester.pumpAndSettle();

      // Cart line item
      expect(find.text('1'), findsWidgets); // quantity
      // Subtotal: ₹20.00, Tax (5%): ₹1.00, Total: ₹21.00
      expect(find.text('₹20.00'), findsOneWidget);
      expect(find.text('₹1.00'), findsOneWidget);
      expect(find.text('₹21.00'), findsOneWidget);

      // Increase quantity to 2
      final addBtn = find.byIcon(Icons.add_circle_outline);
      await tester.tap(addBtn);
      await tester.pumpAndSettle();

      // Subtotal: ₹40.00, Tax (5%): ₹2.00, Total: ₹42.00
      expect(find.text('₹40.00'), findsOneWidget);
      expect(find.text('₹2.00'), findsOneWidget);
      expect(find.text('₹42.00'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('search query filters items in real time',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await menuStore
          .insertCategory(const MenuCategory(id: 'rice', name: 'Rice'));
      await menuStore.insertItem(const MenuItem(
        id: 'jeera-rice',
        categoryId: 'rice',
        name: 'Jeera Rice',
        priceMinor: 15000,
        isVeg: true,
        available: true,
      ));
      await menuStore.insertItem(const MenuItem(
        id: 'curd-rice',
        categoryId: 'rice',
        name: 'Curd Rice',
        priceMinor: 12000,
        isVeg: true,
        available: true,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: PosOrderScreen(
            orderService: orderService,
            kitchenService: kitchenService,
            paymentService: paymentService,
            tableStore: tableStore,
            menuStore: menuStore,
            locationId: 'demo-loc',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Jeera Rice'), findsOneWidget);
      expect(find.text('Curd Rice'), findsOneWidget);

      // Search "jeera"
      final searchField = find.widgetWithText(TextField, 'Search items...');
      expect(searchField, findsOneWidget);
      await tester.enterText(searchField, 'jeera');
      await tester.pumpAndSettle();

      expect(find.text('Jeera Rice'), findsOneWidget);
      expect(find.text('Curd Rice'), findsNothing);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  });
}

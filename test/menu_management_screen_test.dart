import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_menu_store.dart';
import 'package:proviyaa_pos/presentation/menu_management_screen.dart';

void main() {
  group('MenuManagementScreen CRUD & Validation', () {
    late AppDatabase db;
    late DriftMenuStore store;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      store = DriftMenuStore(db);
    });

    testWidgets('renders empty state when no categories exist',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuManagementScreen(menuStore: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No categories in menu yet'), findsOneWidget);
      expect(
          find.text(
              'Click "+ Add Category" above to create your first menu category.'),
          findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await db.close();
    });

    testWidgets(
        'Add Category validates empty name and duplicate name with warning messages',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuManagementScreen(menuStore: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "+ Add Category"
      final addCatBtn = find.widgetWithText(OutlinedButton, 'Add Category');
      expect(addCatBtn, findsOneWidget);
      await tester.tap(addCatBtn);
      await tester.pumpAndSettle();

      // Submit empty category name
      final createCatBtn = find.widgetWithText(FilledButton, 'Create Category');
      await tester.tap(createCatBtn);
      await tester.pumpAndSettle();

      // Verify warning message
      expect(
          find.text('Warning: Category name is required and cannot be empty.'),
          findsOneWidget);

      // Now enter valid name: "Starters"
      final nameField = find.widgetWithText(TextField, 'Category Name *');
      await tester.enterText(nameField, 'Starters');
      await tester.tap(createCatBtn);
      await tester.pumpAndSettle();

      // Category should appear in sidebar (and header)
      expect(find.text('Starters'), findsWidgets);

      // Now try adding duplicate category "starters" (case-insensitive)
      await tester.tap(addCatBtn);
      await tester.pumpAndSettle();

      final dupNameField = find.widgetWithText(TextField, 'Category Name *');
      await tester.enterText(dupNameField, 'starters');
      final dupCreateBtn = find.widgetWithText(FilledButton, 'Create Category');
      await tester.tap(dupCreateBtn);
      await tester.pumpAndSettle();

      // Duplicate warning message
      expect(find.text('Warning: A category named "starters" already exists.'),
          findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await db.close();
    });

    testWidgets(
        'Add Item validates edge cases (empty name, empty/invalid price) and creates item',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MenuManagementScreen(menuStore: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Try tapping "Add Item" when no categories exist
      final addItemBtn = find.widgetWithText(FilledButton, 'Add Item');
      await tester.tap(addItemBtn);
      await tester.pump();

      // Should show snackbar warning to create category first
      expect(
          find.text(
              'Warning: Please create at least one category before adding items.'),
          findsOneWidget);
      await tester.pumpAndSettle();

      // Create a category "Beverages"
      final addCatBtn = find.widgetWithText(OutlinedButton, 'Add Category');
      await tester.tap(addCatBtn);
      await tester.pumpAndSettle();

      final catNameField = find.widgetWithText(TextField, 'Category Name *');
      await tester.enterText(catNameField, 'Beverages');
      await tester.tap(find.widgetWithText(FilledButton, 'Create Category'));
      await tester.pumpAndSettle();

      // Now tap "Add Item"
      await tester.tap(addItemBtn);
      await tester.pumpAndSettle();

      final createItemBtn = find.widgetWithText(FilledButton, 'Create Item');

      // 1. Submit empty item name
      await tester.tap(createItemBtn);
      await tester.pumpAndSettle();
      expect(find.text('Warning: Item name is required and cannot be empty.'),
          findsOneWidget);

      // Enter name
      final itemNameField = find.widgetWithText(TextField, 'Item Name *');
      await tester.enterText(itemNameField, 'Cold Coffee');

      // 2. Submit empty price
      await tester.tap(createItemBtn);
      await tester.pumpAndSettle();
      expect(find.text('Warning: Price is required.'), findsOneWidget);

      // 3. Submit invalid/non-numeric price
      final priceField = find.widgetWithText(TextField, 'Price (₹) *');
      await tester.enterText(priceField, 'abc');
      await tester.tap(createItemBtn);
      await tester.pumpAndSettle();
      expect(
          find.text(
              'Warning: Please enter a valid numeric price (e.g. 250 or 99.50).'),
          findsOneWidget);

      // 4. Submit zero/negative price
      await tester.enterText(priceField, '0');
      await tester.tap(createItemBtn);
      await tester.pumpAndSettle();
      expect(find.text('Warning: Price must be greater than zero.'),
          findsOneWidget);

      // 5. Enter valid price 150.00 and save
      await tester.enterText(priceField, '150');
      await tester.tap(createItemBtn);
      await tester.pumpAndSettle();

      // Item card should appear in the grid
      expect(find.text('Cold Coffee'), findsOneWidget);
      expect(find.text('₹150'), findsOneWidget);
      expect(find.text('Veg'), findsOneWidget);
      expect(find.text('Available'), findsWidgets);

      // Verify category item count in sidebar updated to 1
      expect(find.text('1'), findsWidgets);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await db.close();
    });
  });
}

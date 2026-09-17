import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_menu_store.dart';
import 'package:proviyaa_pos/domain/menu.dart';

void main() {
  group('DriftMenuStore CRUD', () {
    late AppDatabase db;
    late DriftMenuStore store;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      store = DriftMenuStore(db);
    });

    tearDown(() => db.close());

    test('starts with empty categories and items', () async {
      final categories = await store.getAllCategories();
      final items = await store.getAllItems();
      expect(categories, isEmpty);
      expect(items, isEmpty);
    });

    test('insertCategory and getAllCategories', () async {
      await store.insertCategory(const MenuCategory(id: 'starters', name: 'Starters'));
      await store.insertCategory(const MenuCategory(id: 'beverages', name: 'Beverages'));

      final categories = await store.getAllCategories();
      expect(categories.length, 2);
      expect(categories.any((c) => c.id == 'starters' && c.name == 'Starters'), isTrue);
      expect(categories.any((c) => c.id == 'beverages' && c.name == 'Beverages'), isTrue);
    });

    test('updateCategory changes name', () async {
      await store.insertCategory(const MenuCategory(id: 'cat-1', name: 'Old Name'));
      await store.updateCategory(const MenuCategory(id: 'cat-1', name: 'New Name'));

      final categories = await store.getAllCategories();
      expect(categories.length, 1);
      expect(categories.first.name, 'New Name');
    });

    test('insertItem and getAllItems with category filter', () async {
      await store.insertCategory(const MenuCategory(id: 'starters', name: 'Starters'));
      await store.insertCategory(const MenuCategory(id: 'beverages', name: 'Beverages'));

      await store.insertItem(const MenuItem(
        id: 'paneer-tikka',
        categoryId: 'starters',
        name: 'Paneer Tikka',
        priceMinor: 32000,
        isVeg: true,
        isBestseller: true,
      ));
      await store.insertItem(const MenuItem(
        id: 'masala-chai',
        categoryId: 'beverages',
        name: 'Masala Chai',
        priceMinor: 4000,
        isVeg: true,
      ));

      final allItems = await store.getAllItems();
      expect(allItems.length, 2);

      final starterItems = await store.getAllItems(categoryId: 'starters');
      expect(starterItems.length, 1);
      expect(starterItems.first.name, 'Paneer Tikka');
      expect(starterItems.first.priceMinor, 32000);
      expect(starterItems.first.isBestseller, isTrue);

      final beverageItems = await store.getAllItems(categoryId: 'beverages');
      expect(beverageItems.length, 1);
      expect(beverageItems.first.name, 'Masala Chai');

      // Check item count on categories
      final categoriesWithCounts = await store.getAllCategories();
      final starters = categoriesWithCounts.firstWhere((c) => c.id == 'starters');
      final beverages = categoriesWithCounts.firstWhere((c) => c.id == 'beverages');
      expect(starters.itemCount, 1);
      expect(beverages.itemCount, 1);
    });

    test('updateItem modifies attributes', () async {
      await store.insertCategory(const MenuCategory(id: 'starters', name: 'Starters'));
      await store.insertItem(const MenuItem(
        id: 'item-1',
        categoryId: 'starters',
        name: 'Tikka',
        priceMinor: 20000,
        isVeg: true,
      ));

      await store.updateItem(const MenuItem(
        id: 'item-1',
        categoryId: 'starters',
        name: 'Paneer Tikka Special',
        priceMinor: 25000,
        isVeg: true,
        isBestseller: true,
        available: false,
        unavailableReason: 'Out of stock',
      ));

      final items = await store.getAllItems();
      expect(items.length, 1);
      final item = items.first;
      expect(item.name, 'Paneer Tikka Special');
      expect(item.priceMinor, 25000);
      expect(item.isBestseller, isTrue);
      expect(item.available, isFalse);
      expect(item.unavailableReason, 'Out of stock');
    });

    test('toggleItemAvailability updates status', () async {
      await store.insertCategory(const MenuCategory(id: 'c1', name: 'Cat'));
      await store.insertItem(const MenuItem(
        id: 'item-1',
        categoryId: 'c1',
        name: 'Item',
        priceMinor: 10000,
        isVeg: true,
        available: true,
      ));

      await store.toggleItemAvailability('item-1', false, 'Kitchen closed');
      var item = (await store.getAllItems()).first;
      expect(item.available, isFalse);
      expect(item.unavailableReason, 'Kitchen closed');

      await store.toggleItemAvailability('item-1', true);
      item = (await store.getAllItems()).first;
      expect(item.available, isTrue);
    });

    test('deleteItem removes item', () async {
      await store.insertCategory(const MenuCategory(id: 'c1', name: 'Cat'));
      await store.insertItem(const MenuItem(
        id: 'i1',
        categoryId: 'c1',
        name: 'Item 1',
        priceMinor: 10000,
        isVeg: true,
      ));
      expect((await store.getAllItems()).length, 1);

      await store.deleteItem('i1');
      expect((await store.getAllItems()).length, 0);
    });

    test('deleteCategory cascades and deletes items belonging to category', () async {
      await store.insertCategory(const MenuCategory(id: 'c1', name: 'Cat 1'));
      await store.insertCategory(const MenuCategory(id: 'c2', name: 'Cat 2'));
      await store.insertItem(const MenuItem(
        id: 'i1',
        categoryId: 'c1',
        name: 'Item 1',
        priceMinor: 10000,
        isVeg: true,
      ));
      await store.insertItem(const MenuItem(
        id: 'i2',
        categoryId: 'c2',
        name: 'Item 2',
        priceMinor: 15000,
        isVeg: false,
      ));

      expect((await store.getAllCategories()).length, 2);
      expect((await store.getAllItems()).length, 2);

      await store.deleteCategory('c1');

      final remainingCategories = await store.getAllCategories();
      expect(remainingCategories.length, 1);
      expect(remainingCategories.first.id, 'c2');

      final remainingItems = await store.getAllItems();
      expect(remainingItems.length, 1);
      expect(remainingItems.first.id, 'i2');
    });
  });
}

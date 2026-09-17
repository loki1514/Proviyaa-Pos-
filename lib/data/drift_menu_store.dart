import 'package:drift/drift.dart';

import '../domain/menu.dart';
import 'app_database.dart';

class DriftMenuStore {
  DriftMenuStore(this.db);
  final AppDatabase db;

  MenuItem _itemToDomain(MenuItemEntity r) => MenuItem(
        id: r.id,
        categoryId: r.categoryId,
        name: r.name,
        priceMinor: r.priceMinor,
        isVeg: r.isVeg,
        isBestseller: r.isBestseller,
        available: r.available,
        unavailableReason: r.unavailableReason,
      );

  // -------------------------------------------------------------
  // CATEGORIES
  // -------------------------------------------------------------

  /// Real-time stream of all categories.
  Stream<List<MenuCategory>> watchCategories() {
    return (db.select(db.menuCategoriesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch()
        .map((rows) =>
            rows.map((r) => MenuCategory(id: r.id, name: r.name)).toList());
  }

  /// Fetch all categories once with computed item counts.
  Future<List<MenuCategory>> getAllCategories() async {
    final categories = await (db.select(db.menuCategoriesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    final items = await db.select(db.menuItemsTable).get();
    final counts = <String, int>{};
    for (final item in items) {
      counts[item.categoryId] = (counts[item.categoryId] ?? 0) + 1;
    }
    return categories
        .map((c) => MenuCategory(
              id: c.id,
              name: c.name,
              itemCount: counts[c.id] ?? 0,
            ))
        .toList();
  }

  /// CREATE: Insert a new category.
  Future<void> insertCategory(MenuCategory category) async {
    await db.into(db.menuCategoriesTable).insertOnConflictUpdate(
          MenuCategoriesTableCompanion.insert(
            id: category.id,
            name: category.name,
          ),
        );
  }

  /// UPDATE: Update an existing category name.
  Future<void> updateCategory(MenuCategory category) async {
    await (db.update(db.menuCategoriesTable)
          ..where((t) => t.id.equals(category.id)))
        .write(
      MenuCategoriesTableCompanion(
        name: Value(category.name),
      ),
    );
  }

  /// DELETE: Remove a category and all items under it (cascade delete).
  Future<void> deleteCategory(String categoryId) async {
    await (db.delete(db.menuItemsTable)
          ..where((t) => t.categoryId.equals(categoryId)))
        .go();
    await (db.delete(db.menuCategoriesTable)
          ..where((t) => t.id.equals(categoryId)))
        .go();
  }

  // -------------------------------------------------------------
  // ITEMS
  // -------------------------------------------------------------

  /// Real-time stream of items, optionally filtered by category.
  Stream<List<MenuItem>> watchItems({String? categoryId}) {
    final query = db.select(db.menuItemsTable)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    if (categoryId != null && categoryId != 'all') {
      query.where((t) => t.categoryId.equals(categoryId));
    }
    return query.watch().map((rows) => rows.map(_itemToDomain).toList());
  }

  /// Fetch all items once, optionally filtered by category.
  Future<List<MenuItem>> getAllItems({String? categoryId}) async {
    final query = db.select(db.menuItemsTable)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    if (categoryId != null && categoryId != 'all') {
      query.where((t) => t.categoryId.equals(categoryId));
    }
    final rows = await query.get();
    return rows.map(_itemToDomain).toList();
  }

  /// CREATE: Insert a new menu item.
  Future<void> insertItem(MenuItem item) async {
    await db.into(db.menuItemsTable).insertOnConflictUpdate(
          MenuItemsTableCompanion.insert(
            id: item.id,
            categoryId: item.categoryId,
            name: item.name,
            priceMinor: item.priceMinor,
            isVeg: Value(item.isVeg),
            isBestseller: Value(item.isBestseller),
            available: Value(item.available),
            unavailableReason: Value(item.unavailableReason),
          ),
        );
  }

  /// UPDATE: Update an existing menu item.
  Future<void> updateItem(MenuItem item) async {
    await (db.update(db.menuItemsTable)..where((t) => t.id.equals(item.id)))
        .write(
      MenuItemsTableCompanion(
        categoryId: Value(item.categoryId),
        name: Value(item.name),
        priceMinor: Value(item.priceMinor),
        isVeg: Value(item.isVeg),
        isBestseller: Value(item.isBestseller),
        available: Value(item.available),
        unavailableReason: Value(item.unavailableReason),
      ),
    );
  }

  /// DELETE: Remove a menu item from SQLite.
  Future<void> deleteItem(String itemId) async {
    await (db.delete(db.menuItemsTable)..where((t) => t.id.equals(itemId)))
        .go();
  }

  /// Fast toggle of availability status.
  Future<void> toggleItemAvailability(String itemId, bool available,
      [String? reason]) async {
    await (db.update(db.menuItemsTable)..where((t) => t.id.equals(itemId)))
        .write(
      MenuItemsTableCompanion(
        available: Value(available),
        unavailableReason: Value(reason),
      ),
    );
  }
}

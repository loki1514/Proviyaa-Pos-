import 'package:drift/drift.dart';

import '../domain/restaurant_table.dart';
import 'app_database.dart';

class DriftTableStore {
  DriftTableStore(this.db);
  final AppDatabase db;

  RestaurantTable _toDomain(RestaurantTableRow r) {
    final zone = TableZone.values.firstWhere(
      (z) => z.name == r.zone,
      orElse: () => TableZone.indoor,
    );
    final status = TableStatus.values.firstWhere(
      (s) => s.name == r.status,
      orElse: () => TableStatus.available,
    );
    return RestaurantTable(
      id: r.id,
      label: r.label,
      seats: r.seats,
      zone: zone,
      status: status,
      guestCount: r.guestCount,
      elapsedMinutes: r.elapsedMinutes,
      orderTotalMinor: r.orderTotalMinor,
      reservedByName: r.reservedByName,
      reservedAt: r.reservedAt,
    );
  }

  /// Real-time stream of all tables from SQLite.
  Stream<List<RestaurantTable>> watchTables() {
    return db.select(db.restaurantTables).watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  /// Fetch all tables once.
  Future<List<RestaurantTable>> getAllTables() async {
    final rows = await db.select(db.restaurantTables).get();
    return rows.map(_toDomain).toList();
  }

  /// CREATE: Insert a new table.
  Future<void> insertTable(RestaurantTable table) async {
    await db.into(db.restaurantTables).insertOnConflictUpdate(
          RestaurantTablesCompanion.insert(
            id: table.id,
            label: table.label,
            seats: table.seats,
            zone: table.zone.name,
            status: table.status.name,
            guestCount: Value(table.guestCount),
            elapsedMinutes: Value(table.elapsedMinutes),
            orderTotalMinor: Value(table.orderTotalMinor),
            reservedByName: Value(table.reservedByName),
            reservedAt: Value(table.reservedAt),
          ),
        );
  }

  /// UPDATE: Update an existing table.
  Future<void> updateTable(RestaurantTable table) async {
    await (db.update(db.restaurantTables)..where((t) => t.id.equals(table.id)))
        .write(
      RestaurantTablesCompanion(
        label: Value(table.label),
        seats: Value(table.seats),
        zone: Value(table.zone.name),
        status: Value(table.status.name),
        guestCount: Value(table.guestCount),
        elapsedMinutes: Value(table.elapsedMinutes),
        orderTotalMinor: Value(table.orderTotalMinor),
        reservedByName: Value(table.reservedByName),
        reservedAt: Value(table.reservedAt),
      ),
    );
  }

  /// UPDATE: Quick status update (e.g. Cleaning -> Available).
  Future<void> updateStatus(String tableId, TableStatus status) async {
    await (db.update(db.restaurantTables)..where((t) => t.id.equals(tableId)))
        .write(
      RestaurantTablesCompanion(
        status: Value(status.name),
      ),
    );
  }

  /// DELETE: Remove a table from SQLite.
  Future<void> deleteTable(String tableId) async {
    await (db.delete(db.restaurantTables)..where((t) => t.id.equals(tableId)))
        .go();
  }
}

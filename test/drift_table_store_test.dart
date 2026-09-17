import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_table_store.dart';
import 'package:proviyaa_pos/domain/restaurant_table.dart';

void main() {
  group('DriftTableStore CRUD', () {
    late AppDatabase db;
    late DriftTableStore store;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      store = DriftTableStore(db);
    });

    tearDown(() => db.close());

    test('starts with empty database without static seed', () async {
      final before = await store.getAllTables();
      expect(before, isEmpty);
    });

    test('insertTable creates a new table', () async {
      const newTable = RestaurantTable(
        id: 'T99',
        label: 'T99',
        seats: 6,
        zone: TableZone.outdoor,
        status: TableStatus.available,
      );

      await store.insertTable(newTable);

      final tables = await store.getAllTables();
      expect(tables.length, 1);
      expect(tables.first.id, 'T99');
      expect(tables.first.seats, 6);
      expect(tables.first.zone, TableZone.outdoor);
    });

    test('updateTable modifies table attributes', () async {
      const table = RestaurantTable(
        id: 'T1',
        label: 'T1',
        seats: 2,
        zone: TableZone.indoor,
        status: TableStatus.available,
      );
      await store.insertTable(table);

      const updated = RestaurantTable(
        id: 'T1',
        label: 'T1 VIP',
        seats: 4,
        zone: TableZone.privateDining,
        status: TableStatus.reserved,
        reservedByName: 'Gupta',
      );
      await store.updateTable(updated);

      final tables = await store.getAllTables();
      expect(tables.length, 1);
      expect(tables.first.label, 'T1 VIP');
      expect(tables.first.seats, 4);
      expect(tables.first.zone, TableZone.privateDining);
      expect(tables.first.status, TableStatus.reserved);
      expect(tables.first.reservedByName, 'Gupta');
    });

    test('updateStatus changes table status', () async {
      const table = RestaurantTable(
        id: 'T1',
        label: 'T1',
        seats: 4,
        zone: TableZone.indoor,
        status: TableStatus.cleaning,
      );
      await store.insertTable(table);

      await store.updateStatus('T1', TableStatus.available);

      final tables = await store.getAllTables();
      expect(tables.first.status, TableStatus.available);
    });

    test('deleteTable removes table from database', () async {
      const table = RestaurantTable(
        id: 'T1',
        label: 'T1',
        seats: 4,
        zone: TableZone.indoor,
        status: TableStatus.available,
      );
      await store.insertTable(table);
      expect((await store.getAllTables()).length, 1);

      await store.deleteTable('T1');
      expect((await store.getAllTables()).length, 0);
    });

    test('watchTables emits updates reactively', () async {
      await store.insertTable(const RestaurantTable(
        id: 'T1',
        label: 'T1',
        seats: 2,
        zone: TableZone.indoor,
        status: TableStatus.available,
      ));

      final firstEmit = await store.watchTables().first;
      expect(firstEmit.length, 1);

      await store.insertTable(const RestaurantTable(
        id: 'T2',
        label: 'T2',
        seats: 4,
        zone: TableZone.outdoor,
        status: TableStatus.available,
      ));

      final secondEmit = await store.watchTables().first;
      expect(secondEmit.length, 2);
    });
  });
}

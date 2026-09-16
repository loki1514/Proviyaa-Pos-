import 'package:drift/drift.dart';

import '../application/shift_service.dart';
import '../domain/shift.dart';
import 'app_database.dart';

class DriftShiftStore implements ShiftLocalStore {
  DriftShiftStore(this._db);
  final AppDatabase _db;

  @override
  Future<void> openShift(Shift shift) async {
    await _db.into(_db.shifts).insert(ShiftsCompanion.insert(
        shiftId: shift.shiftId,
        locationId: shift.locationId,
        openingFloatMinor: shift.openingFloatMinor,
        openedAt: shift.openedAt));
  }

  @override
  Future<Shift?> findOpenShift(String locationId) async {
    final row = await (_db.select(_db.shifts)
          ..where((t) => t.locationId.equals(locationId) & t.closedAt.isNull()))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<void> closeShift(String shiftId, int countedCashMinor) async {
    await (_db.update(_db.shifts)..where((t) => t.shiftId.equals(shiftId)))
        .write(ShiftsCompanion(
            closedAt: Value(DateTime.now()),
            countedCashMinor: Value(countedCashMinor)));
  }

  Shift _toDomain(ShiftRow row) => Shift(
      shiftId: row.shiftId,
      locationId: row.locationId,
      openingFloatMinor: row.openingFloatMinor,
      openedAt: row.openedAt,
      closedAt: row.closedAt,
      countedCashMinor: row.countedCashMinor);
}

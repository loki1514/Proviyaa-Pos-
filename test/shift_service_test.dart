import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/shift_service.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_shift_store.dart';
import 'package:proviyaa_pos/domain/shift.dart';

void main() {
  group('ShiftService', () {
    late AppDatabase db;
    late ShiftService shifts;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      shifts = ShiftService(DriftShiftStore(db));
    });
    tearDown(() => db.close());

    test('opening a shift records the float and leaves it open', () async {
      final shift = await shifts.openShift(
          shiftId: 'shift-1', locationId: 'loc-1', openingFloatMinor: 500000);
      expect(shift.status, ShiftStatus.open);
      expect((await shifts.currentOpenShift('loc-1'))?.shiftId, 'shift-1');
    });

    test('a second shift cannot open while one is already open', () async {
      await shifts.openShift(
          shiftId: 'shift-1', locationId: 'loc-1', openingFloatMinor: 500000);
      expect(
          () => shifts.openShift(
              shiftId: 'shift-2',
              locationId: 'loc-1',
              openingFloatMinor: 500000),
          throwsStateError);
    });

    test('closing a shift records counted cash and computes variance',
        () async {
      final shift = await shifts.openShift(
          shiftId: 'shift-1', locationId: 'loc-1', openingFloatMinor: 500000);
      // Cash receipts during the shift are summed by the caller (they
      // live in the orders table, not the shift), then handed to the
      // domain model for the variance calculation.
      const cashReceiptsMinor = 220000;
      expect(shift.expectedCashMinor(cashReceiptsMinor), 720000);

      await shifts.closeShift('shift-1', 715000);
      expect(await shifts.currentOpenShift('loc-1'), isNull,
          reason: 'a closed shift is no longer the open shift for a new one');
    });

    test('variance is negative when counted cash is short', () {
      final shift = Shift(
          shiftId: 's',
          locationId: 'loc-1',
          openingFloatMinor: 500000,
          openedAt: DateTime(2026, 9, 15, 9),
          countedCashMinor: 715000);
      expect(shift.varianceMinor(220000), -5000);
    });
  });
}

import '../domain/shift.dart';

abstract interface class ShiftLocalStore {
  Future<void> openShift(Shift shift);
  Future<Shift?> findOpenShift(String locationId);
  Future<void> closeShift(String shiftId, int countedCashMinor);
}

class ShiftService {
  const ShiftService(this.store);
  final ShiftLocalStore store;

  /// Throws if a shift is already open for this location — PRD §9: one
  /// shift's cash math must not overlap another's.
  Future<Shift> openShift(
      {required String shiftId,
      required String locationId,
      required int openingFloatMinor}) async {
    final existing = await store.findOpenShift(locationId);
    if (existing != null) {
      throw StateError('A shift is already open for $locationId.');
    }
    final shift = Shift(
        shiftId: shiftId,
        locationId: locationId,
        openingFloatMinor: openingFloatMinor,
        openedAt: DateTime.now());
    await store.openShift(shift);
    return shift;
  }

  Future<Shift?> currentOpenShift(String locationId) =>
      store.findOpenShift(locationId);

  /// Records counted cash and closes the shift. Expected-cash and
  /// variance are computed by the caller (they need the cash receipts
  /// total, which the shift store doesn't own) via [Shift.varianceMinor].
  Future<void> closeShift(String shiftId, int countedCashMinor) =>
      store.closeShift(shiftId, countedCashMinor);
}

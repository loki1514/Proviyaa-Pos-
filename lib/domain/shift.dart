// Shift domain — PRD §9 "Walk-in cash example" and §4 R08 first slice
// (cash/shift active; provider/payout integrations later). Expected
// cash is opening float plus cash receipts recorded during the shift;
// V1 has no refunds/paid-outs yet, so that term is omitted rather than
// invented (PRD §9: "no invented fee percentages" extends to omitting
// unimplemented deductions, not guessing them).

enum ShiftStatus { open, closed }

class Shift {
  const Shift(
      {required this.shiftId,
      required this.locationId,
      required this.openingFloatMinor,
      required this.openedAt,
      this.closedAt,
      this.countedCashMinor});
  final String shiftId, locationId;
  final int openingFloatMinor;
  final DateTime openedAt;
  final DateTime? closedAt;
  final int? countedCashMinor;

  ShiftStatus get status =>
      closedAt == null ? ShiftStatus.open : ShiftStatus.closed;

  /// opening float + cash sale receipts during this shift. Cash receipts
  /// are supplied by the caller (summed from orders saved while this
  /// shift was open) rather than stored redundantly here.
  int expectedCashMinor(int cashReceiptsMinor) =>
      openingFloatMinor + cashReceiptsMinor;

  /// Positive: more cash counted than expected. Negative: short. Null
  /// until the shift is closed and counted cash is recorded.
  int? varianceMinor(int cashReceiptsMinor) => countedCashMinor == null
      ? null
      : countedCashMinor! - expectedCashMinor(cashReceiptsMinor);
}

// Payment/finance domain — PRD §9 finance requirements: "Separate order,
// kitchen, delivery, payment and settlement states; do not overload one
// status." Payment is therefore its own record, not a field bolted onto
// LocalOrderStatus. Only cash is modeled as ever reaching `recorded`
// (confirmed) — D03/D09: cash-first pilot, digital payments remain
// pending verification until a real provider integration exists. See
// docs/DECISIONS-AND-QUESTIONS.txt.

enum PaymentMethod { cash }

class CashPayment {
  const CashPayment(
      {required this.paymentId,
      required this.clientOrderId,
      required this.amountMinor,
      required this.receivedMinor,
      required this.recordedAt});
  final String paymentId, clientOrderId;

  /// What was owed (order total at the time of payment).
  final int amountMinor;

  /// What the cashier actually collected.
  final int receivedMinor;
  final DateTime recordedAt;

  int get changeMinor => receivedMinor - amountMinor;
}

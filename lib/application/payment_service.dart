import '../domain/payment.dart';

abstract interface class PaymentLocalStore {
  Future<void> recordCashPayment(CashPayment payment);
  Future<CashPayment?> findPaymentForOrder(String clientOrderId);
}

class PaymentService {
  const PaymentService(this.store);
  final PaymentLocalStore store;

  /// Records a cash tender against an order. Idempotent like order save:
  /// the payment id is derived from the order id, so a retried call
  /// (e.g. a double-tap on Complete Payment) is a no-op past the first
  /// write, not a second recorded payment for the same order.
  Future<CashPayment> recordCashPayment(
      {required String clientOrderId,
      required int amountMinor,
      required int receivedMinor}) async {
    if (receivedMinor < amountMinor) {
      throw ArgumentError(
          'Amount received (₹${receivedMinor / 100}) is less than the amount owed (₹${amountMinor / 100}).');
    }
    final existing = await store.findPaymentForOrder(clientOrderId);
    if (existing != null) return existing;

    final payment = CashPayment(
        paymentId: '$clientOrderId:payment',
        clientOrderId: clientOrderId,
        amountMinor: amountMinor,
        receivedMinor: receivedMinor,
        recordedAt: DateTime.now());
    await store.recordCashPayment(payment);
    return (await store.findPaymentForOrder(clientOrderId)) ?? payment;
  }
}

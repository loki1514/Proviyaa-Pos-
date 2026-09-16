import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/payment_service.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_payment_store.dart';

void main() {
  group('PaymentService', () {
    late AppDatabase db;
    late PaymentService payments;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      payments = PaymentService(DriftPaymentStore(db));
    });
    tearDown(() => db.close());

    test('records a cash payment and computes change', () async {
      final payment = await payments.recordCashPayment(
          clientOrderId: 'order-1', amountMinor: 46200, receivedMinor: 50000);
      expect(payment.changeMinor, 3800);
      expect(
          (await DriftPaymentStore(db).findPaymentForOrder('order-1'))
              ?.receivedMinor,
          50000);
    });

    test('exact tender leaves zero change', () async {
      final payment = await payments.recordCashPayment(
          clientOrderId: 'order-2', amountMinor: 46200, receivedMinor: 46200);
      expect(payment.changeMinor, 0);
    });

    test('refuses a tender less than the amount owed', () {
      expect(
          () => payments.recordCashPayment(
              clientOrderId: 'order-3',
              amountMinor: 46200,
              receivedMinor: 40000),
          throwsArgumentError);
    });

    test(
        'recording twice for the same order is a no-op replay, not a second payment',
        () async {
      final first = await payments.recordCashPayment(
          clientOrderId: 'order-4', amountMinor: 10000, receivedMinor: 10000);
      final second = await payments.recordCashPayment(
          clientOrderId: 'order-4', amountMinor: 10000, receivedMinor: 20000);
      // The second call's different amount is ignored — the first
      // recorded payment stands, matching the idempotent-save pattern
      // used for orders and kitchen tickets.
      expect(second.paymentId, first.paymentId);
      expect(second.receivedMinor, 10000);
      final rows = await db.select(db.payments).get();
      expect(rows, hasLength(1));
    });
  });
}

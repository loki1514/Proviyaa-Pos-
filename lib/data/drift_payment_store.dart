import 'package:drift/drift.dart';

import '../application/payment_service.dart';
import '../domain/payment.dart';
import 'app_database.dart';

class DriftPaymentStore implements PaymentLocalStore {
  DriftPaymentStore(this._db);
  final AppDatabase _db;

  @override
  Future<void> recordCashPayment(CashPayment payment) async {
    await _db.into(_db.payments).insert(
        PaymentsCompanion.insert(
            paymentId: payment.paymentId,
            clientOrderId: payment.clientOrderId,
            method: PaymentMethod.cash.name,
            amountMinor: payment.amountMinor,
            receivedMinor: payment.receivedMinor,
            recordedAt: Value(payment.recordedAt)),
        mode: InsertMode.insertOrIgnore);
  }

  @override
  Future<CashPayment?> findPaymentForOrder(String clientOrderId) async {
    final row = await (_db.select(_db.payments)
          ..where((t) => t.clientOrderId.equals(clientOrderId)))
        .getSingleOrNull();
    if (row == null) return null;
    return CashPayment(
        paymentId: row.paymentId,
        clientOrderId: row.clientOrderId,
        amountMinor: row.amountMinor,
        receivedMinor: row.receivedMinor,
        recordedAt: row.recordedAt);
  }
}

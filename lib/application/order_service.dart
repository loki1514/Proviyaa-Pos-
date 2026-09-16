import '../domain/order.dart';

abstract interface class PosLocalStore {
  Future<void> saveOrderWithPendingIntent(LocalOrder order);
  Future<LocalOrder?> findOrder(String clientOrderId);
}

class OrderService {
  const OrderService(this.store);
  final PosLocalStore store;
  Future<LocalOrder> saveCashOrder(
      {required String clientOrderId,
      required String locationId,
      required List<OrderLine> lines,
      required OrderType orderType,
      String? tableLabel}) async {
    if (lines.isEmpty) {
      throw ArgumentError('An order needs at least one line item.');
    }
    if (orderType == OrderType.dineIn &&
        (tableLabel == null || tableLabel.isEmpty)) {
      throw ArgumentError('A dine-in order needs a table.');
    }
    final order = LocalOrder(
        clientOrderId: clientOrderId,
        locationId: locationId,
        currencyCode: 'INR',
        lines: List.unmodifiable(lines),
        status: LocalOrderStatus.pendingUpload,
        orderType: orderType,
        tableLabel: orderType == OrderType.dineIn ? tableLabel : null);
    await store.saveOrderWithPendingIntent(order);
    return order;
  }
}

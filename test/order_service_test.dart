import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/order_service.dart';
import 'package:proviyaa_pos/data/in_memory_local_store.dart';
import 'package:proviyaa_pos/domain/order.dart';

void main() {
  test('saves local order with pending status and totals', () async {
    final s = InMemoryLocalStore();
    final o = await OrderService(s).saveCashOrder(
        clientOrderId: 'order-1',
        locationId: 'location-demo',
        orderType: OrderType.takeaway,
        lines: const [
          OrderLine(
              itemId: 'chai', name: 'Masala Chai', unitMinor: 1200, quantity: 2)
        ]);
    expect(o.status, LocalOrderStatus.pendingUpload);
    expect(o.subtotalMinor, 2400);
    expect((await s.findOrder('order-1'))?.clientOrderId, 'order-1');
  });
  test('local replay is idempotent', () async {
    final s = InMemoryLocalStore();
    final svc = OrderService(s);
    const lines = [
      OrderLine(itemId: 'dal', name: 'Dal', unitMinor: 1800, quantity: 1)
    ];
    await svc.saveCashOrder(
        clientOrderId: 'order-2',
        locationId: 'location-demo',
        orderType: OrderType.dineIn,
        tableLabel: 'T4',
        lines: lines);
    await svc.saveCashOrder(
        clientOrderId: 'order-2',
        locationId: 'location-demo',
        orderType: OrderType.dineIn,
        tableLabel: 'T4',
        lines: lines);
    expect((await s.findOrder('order-2'))?.subtotalMinor, 1800);
  });

  test('a dine-in order without a table is rejected', () {
    final svc = OrderService(InMemoryLocalStore());
    expect(
        () => svc.saveCashOrder(
                clientOrderId: 'order-3',
                locationId: 'location-demo',
                orderType: OrderType.dineIn,
                lines: const [
                  OrderLine(
                      itemId: 'dal', name: 'Dal', unitMinor: 1800, quantity: 1)
                ]),
        throwsArgumentError);
  });
}

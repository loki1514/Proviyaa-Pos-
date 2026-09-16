import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/kitchen_service.dart';
import 'package:proviyaa_pos/application/order_service.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_kitchen_store.dart';
import 'package:proviyaa_pos/data/drift_local_store.dart';
import 'package:proviyaa_pos/domain/kitchen_ticket.dart';
import 'package:proviyaa_pos/domain/order.dart';

void main() {
  group('KitchenService', () {
    late AppDatabase db;
    late KitchenService kitchen;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      kitchen = KitchenService(DriftKitchenStore(db));
    });
    tearDown(() => db.close());

    Future<LocalOrder> aSavedOrder(String id) =>
        OrderService(DriftLocalStore(db)).saveCashOrder(
            clientOrderId: id,
            locationId: 'loc-1',
            orderType: OrderType.takeaway,
            lines: const [
              OrderLine(
                  itemId: 'chai', name: 'Chai', unitMinor: 1200, quantity: 1)
            ]);

    test('creating a ticket for an order starts it new', () async {
      final order = await aSavedOrder('order-1');
      final ticket = await kitchen.createTicketForOrder(order);
      expect(ticket.status, KitchenTicketStatus.newTicket);
      expect(ticket.clientOrderId, 'order-1');
    });

    test('creating a ticket twice for the same order is a no-op replay',
        () async {
      final order = await aSavedOrder('order-2');
      await kitchen.createTicketForOrder(order);
      await kitchen.createTicketForOrder(order);
      final open = await kitchen.openTickets();
      expect(open.where((t) => t.clientOrderId == 'order-2'), hasLength(1));
    });

    test('advance walks queued -> preparing -> ready -> served in order',
        () async {
      final order = await aSavedOrder('order-3');
      final ticket = await kitchen.createTicketForOrder(order);

      final preparing = await kitchen.advance(ticket.ticketId);
      expect(preparing.status, KitchenTicketStatus.preparing);
      final ready = await kitchen.advance(ticket.ticketId);
      expect(ready.status, KitchenTicketStatus.ready);
      final served = await kitchen.advance(ticket.ticketId);
      expect(served.status, KitchenTicketStatus.completed);
    });

    test('advance past completed is rejected, not silently ignored', () async {
      final order = await aSavedOrder('order-4');
      final ticket = await kitchen.createTicketForOrder(order);
      await kitchen.advance(ticket.ticketId); // preparing
      await kitchen.advance(ticket.ticketId); // ready
      await kitchen.advance(ticket.ticketId); // served
      expect(() => kitchen.advance(ticket.ticketId), throwsStateError);
    });

    test('completed tickets drop out of the open queue', () async {
      final order = await aSavedOrder('order-5');
      final ticket = await kitchen.createTicketForOrder(order);
      await kitchen.advance(ticket.ticketId);
      await kitchen.advance(ticket.ticketId);
      await kitchen.advance(ticket.ticketId);
      final open = await kitchen.openTickets();
      expect(open.where((t) => t.clientOrderId == 'order-5'), isEmpty);
    });
  });
}

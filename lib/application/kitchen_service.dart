import '../domain/kitchen_ticket.dart';
import '../domain/order.dart';

abstract interface class KitchenLocalStore {
  Future<void> createTicket(KitchenTicket ticket);
  Future<KitchenTicket?> findTicket(String ticketId);
  Future<void> advanceStatus(String ticketId, KitchenTicketStatus to);
  Future<List<KitchenTicket>> listOpen();
}

class KitchenService {
  const KitchenService(this.store);
  final KitchenLocalStore store;

  /// One ticket per order, PRD §9: "sends KOT locally" right after the
  /// order is saved. The ticket id is derived from the order id so a
  /// retried call is a safe no-op, matching the idempotent-save pattern
  /// already used for pending_upload_intents.
  Future<KitchenTicket> createTicketForOrder(LocalOrder order) async {
    final ticket = KitchenTicket(
        ticketId: '${order.clientOrderId}:kot',
        clientOrderId: order.clientOrderId,
        status: KitchenTicketStatus.newTicket,
        createdAt: DateTime.now());
    await store.createTicket(ticket);
    return (await store.findTicket(ticket.ticketId)) ?? ticket;
  }

  /// Advances one step forward only (queued -> preparing -> ready ->
  /// served). Throws if the ticket is already at its final status or
  /// doesn't exist — the kitchen screen should not offer the action in
  /// that case, but the service enforces it either way.
  Future<KitchenTicket> advance(String ticketId) async {
    final ticket = await store.findTicket(ticketId);
    if (ticket == null) {
      throw ArgumentError('No kitchen ticket $ticketId.');
    }
    final next = kitchenTicketForwardTransitions[ticket.status];
    if (next == null) {
      throw StateError('Ticket $ticketId is already ${ticket.status.name}.');
    }
    await store.advanceStatus(ticketId, next);
    return ticket.copyWith(status: next);
  }

  Future<List<KitchenTicket>> openTickets() => store.listOpen();
}

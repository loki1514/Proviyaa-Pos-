// Kitchen ticket (KOT) domain — PRD §4 R06, PAGE-RES-005 in
// docs/sources/Product Architecture .converted.txt. First local slice:
// one ticket per order, no station routing yet. "Local output" only — a
// physical printer adapter is hardware-gated (see Q03 in
// docs/DECISIONS-AND-QUESTIONS.txt) and not implemented here.
//
// PAGE-RES-005 names the full lifecycle as New -> Accepted -> Preparing
// -> Ready -> Picked Up -> Completed. The actual v1/POS-KOT-KITCHEN
// reference screens only expose four columns/transitions (New,
// Preparing, Ready, and a "Serve" action reaching a terminal state) —
// no separate Accepted or Picked Up step is shown. Rather than build UI
// for two states the reference never shows, this uses the four states
// that are visible, but named against the architecture doc's terminal
// vocabulary (`completed`, not an invented `served`) so the model stays
// consistent with the source instead of drifting further from it.

enum KitchenTicketStatus { newTicket, preparing, ready, completed }

class KitchenTicket {
  const KitchenTicket(
      {required this.ticketId,
      required this.clientOrderId,
      required this.status,
      required this.createdAt});
  final String ticketId, clientOrderId;
  final KitchenTicketStatus status;
  final DateTime createdAt;

  KitchenTicket copyWith({KitchenTicketStatus? status}) => KitchenTicket(
      ticketId: ticketId,
      clientOrderId: clientOrderId,
      status: status ?? this.status,
      createdAt: createdAt);
}

/// The only forward transitions a ticket may make. Kitchen state does not
/// go backwards from a queue screen — a mistaken advance is corrected by
/// an explicit, audited action, not silently reversed (PRD §10 reprint
/// rule extends the same "explicit correction" spirit to ticket status).
const kitchenTicketForwardTransitions =
    <KitchenTicketStatus, KitchenTicketStatus?>{
  KitchenTicketStatus.newTicket: KitchenTicketStatus.preparing,
  KitchenTicketStatus.preparing: KitchenTicketStatus.ready,
  KitchenTicketStatus.ready: KitchenTicketStatus.completed,
  KitchenTicketStatus.completed: null,
};

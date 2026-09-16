// Rebuilt 1:1 from v1/POS-KOT-KITCHEN-DEFAULT.png and
// v1/POS-KOT-KITCHEN-V3.png (light/dark pair) — see Q02 in
// docs/DECISIONS-AND-QUESTIONS.txt.
//
// The reference shows a per-line checklist with a progress bar, a
// station label ("Main Kitchen"/"Tandoor"/"Oven Station"), and a
// colored kitchen note on some cards. None of that has real backing
// data yet — KitchenTicket doesn't track per-line completion, station
// routing, or notes (PRD §4 R06 lists station routing as a later
// activation, not V1). Faking a progress bar that never moves or a
// station label that's always the same string would misrepresent
// functionality that doesn't exist, so those elements are left out
// rather than invented — same principle as Payment screen leaving out
// Service Charge/Discount it has no real figures for. What IS real:
// the four-column layout, ticket/order identity, order type and table,
// elapsed time, the actual order lines, and the forward-only status
// transitions (Start Cooking / Mark Ready / Serve), all backed by
// KitchenService exactly as tested in test/kitchen_service_test.dart.
//
// "Delayed" is not a stored status — PAGE-RES-005 doesn't give an SLA
// number, and the PRD explicitly defers timeout/heartbeat values to
// owner review (§11: "Define heartbeat interval and timeout during
// review"). 20 minutes here is a clearly-placeholder threshold for New/
// Preparing tickets, not a sourced value.

import 'package:flutter/material.dart';

import '../application/kitchen_service.dart';
import '../data/drift_local_store.dart';
import '../domain/kitchen_ticket.dart';
import '../domain/order.dart';
import 'vinii_theme.dart';

const _delayThreshold = Duration(minutes: 20);

class KitchenDisplayScreen extends StatefulWidget {
  const KitchenDisplayScreen(
      {super.key, required this.kitchenService, required this.localStore});
  final KitchenService kitchenService;
  final DriftLocalStore localStore;

  @override
  State<KitchenDisplayScreen> createState() => _KitchenDisplayScreenState();
}

class _TicketWithOrder {
  const _TicketWithOrder(this.ticket, this.order);
  final KitchenTicket ticket;
  final LocalOrder? order;
}

class _KitchenDisplayScreenState extends State<KitchenDisplayScreen> {
  List<_TicketWithOrder> _tickets = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final open = await widget.kitchenService.openTickets();
    final withOrders = <_TicketWithOrder>[];
    for (final t in open) {
      withOrders.add(_TicketWithOrder(
          t, await widget.localStore.findOrder(t.clientOrderId)));
    }
    if (!mounted) return;
    setState(() {
      _tickets = withOrders;
      _loading = false;
    });
  }

  Future<void> _advance(String ticketId) async {
    await widget.kitchenService.advance(ticketId);
    await _refresh();
  }

  bool _isDelayed(_TicketWithOrder t) =>
      (t.ticket.status == KitchenTicketStatus.newTicket ||
          t.ticket.status == KitchenTicketStatus.preparing) &&
      DateTime.now().difference(t.ticket.createdAt) >= _delayThreshold;

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    final delayed = _tickets.where(_isDelayed).toList();
    final newT = _tickets
        .where((t) =>
            t.ticket.status == KitchenTicketStatus.newTicket && !_isDelayed(t))
        .toList();
    final preparing = _tickets
        .where((t) =>
            t.ticket.status == KitchenTicketStatus.preparing && !_isDelayed(t))
        .toList();
    final ready = _tickets
        .where((t) => t.ticket.status == KitchenTicketStatus.ready)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Kitchen Display System (KDS)',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          _pill('LIVE', ViniiColors.greenSolid, filled: true),
          const Spacer(),
          Text(
              'New ${newT.length + (delayed.where((t) => t.ticket.status == KitchenTicketStatus.newTicket).length)}'
              '  ·  Preparing ${preparing.length + (delayed.where((t) => t.ticket.status == KitchenTicketStatus.preparing).length)}'
              '  ·  Ready ${ready.length}  ·  Delayed ${delayed.length}',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 12),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ]),
        const SizedBox(height: 16),
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: _KotColumn(
                    title: 'NEW',
                    color: ViniiColors.blueSolid,
                    tickets: newT,
                    actionLabel: 'Start Cooking',
                    onAdvance: _advance)),
            const SizedBox(width: 16),
            Expanded(
                child: _KotColumn(
                    title: 'PREPARING',
                    color: ViniiColors.amberSolid,
                    tickets: preparing,
                    actionLabel: 'Mark Ready',
                    onAdvance: _advance)),
            const SizedBox(width: 16),
            Expanded(
                child: _KotColumn(
                    title: 'READY',
                    color: ViniiColors.greenSolid,
                    tickets: ready,
                    actionLabel: 'Serve',
                    onAdvance: _advance)),
            const SizedBox(width: 16),
            Expanded(
                child: _KotColumn(
                    title: 'DELAYED',
                    color: ViniiColors.redSolid,
                    tickets: delayed,
                    actionLabel:
                        null, // matches whichever status it was delayed from
                    onAdvance: _advance)),
          ]),
        ),
      ]),
    );
  }
}

Widget _pill(String label, Color color, {bool filled = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
        color: filled ? color.withValues(alpha: 0.15) : null,
        borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    ]));

class _KotColumn extends StatelessWidget {
  const _KotColumn(
      {required this.title,
      required this.color,
      required this.tickets,
      required this.actionLabel,
      required this.onAdvance});
  final String title;
  final Color color;
  final List<_TicketWithOrder> tickets;

  /// Null for the Delayed column — each card there keeps the action
  /// label matching whatever status it was delayed from.
  final String? actionLabel;
  final void Function(String ticketId) onAdvance;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: color, width: 3))),
        child: Row(children: [
          Text(title,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(width: 6),
          CircleAvatar(
              radius: 10,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Text('${tickets.length}',
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold))),
        ]),
      ),
      const SizedBox(height: 8),
      Expanded(
        child: ListView(children: [
          for (final t in tickets)
            _KotCard(
                item: t,
                actionLabel: actionLabel ?? _labelFor(t.ticket.status),
                onAdvance: () => onAdvance(t.ticket.ticketId)),
        ]),
      ),
    ]);
  }

  static String _labelFor(KitchenTicketStatus s) => switch (s) {
        KitchenTicketStatus.newTicket => 'Start Cooking',
        KitchenTicketStatus.preparing => 'Mark Ready',
        KitchenTicketStatus.ready => 'Serve',
        KitchenTicketStatus.completed => '',
      };
}

class _KotCard extends StatelessWidget {
  const _KotCard(
      {required this.item, required this.actionLabel, required this.onAdvance});
  final _TicketWithOrder item;
  final String actionLabel;
  final VoidCallback onAdvance;

  @override
  Widget build(BuildContext context) {
    final order = item.order;
    final elapsed = DateTime.now().difference(item.ticket.createdAt);
    final delayed = elapsed >= _delayThreshold &&
        (item.ticket.status == KitchenTicketStatus.newTicket ||
            item.ticket.status == KitchenTicketStatus.preparing);
    final shortId = item.ticket.clientOrderId.substring(
        0,
        item.ticket.clientOrderId.length < 6
            ? item.ticket.clientOrderId.length
            : 6);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('KOT-#$shortId',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(children: [
            if (delayed) ...[
              const Text('URGENT',
                  style: TextStyle(
                      color: ViniiColors.redSolid,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
              const SizedBox(width: 6),
            ],
            Icon(Icons.access_time,
                size: 13, color: delayed ? ViniiColors.redSolid : Colors.grey),
            Text(' ${elapsed.inMinutes} min',
                style: TextStyle(
                    fontSize: 12,
                    color: delayed ? ViniiColors.redSolid : Colors.grey)),
          ]),
        ]),
        const SizedBox(height: 6),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4)),
            child: Text(
                order == null
                    ? '—'
                    : (order.orderType == OrderType.dineIn
                        ? 'Dine In · ${order.tableLabel}'
                        : 'Takeaway'),
                style: const TextStyle(fontSize: 11))),
        const SizedBox(height: 8),
        if (order != null)
          for (final line in order.lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text('${line.name} ×${line.quantity}',
                  style: const TextStyle(fontSize: 13)),
            ),
        const SizedBox(height: 10),
        if (actionLabel.isNotEmpty)
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: onAdvance,
                  style: OutlinedButton.styleFrom(
                      foregroundColor: ViniiColors.greenSolid,
                      side: const BorderSide(color: ViniiColors.greenSolid)),
                  child: Text(actionLabel))),
      ]),
    );
  }
}

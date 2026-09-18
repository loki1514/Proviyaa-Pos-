// Rebuilt 1:1 from v1/POS-DINE-IN-V3.png. "Order List" is the segmented
// control's other option but has no reference screen of its own (only
// "Table View" is shown populated) — it's rendered as a disabled/inert
// toggle target rather than invented content, same rule already applied
// to unreferenced buttons elsewhere (see pos_order_screen.dart's "Save &
// Hold" note).

import 'package:flutter/material.dart';

import '../data/drift_table_store.dart';
import '../data/local_dine_in_catalog.dart';
import '../domain/dine_in_status.dart';
import '../domain/restaurant_table.dart';
import 'vinii_theme.dart';

class DineInScreen extends StatefulWidget {
  const DineInScreen(
      {super.key,
      this.tableStore,
      required this.onOpenOrder,
      required this.onStartOrder});

  final DriftTableStore? tableStore;
  final void Function(DineInTable table) onOpenOrder;
  final void Function(DineInTable table) onStartOrder;

  @override
  State<DineInScreen> createState() => _DineInScreenState();
}

enum _BoardView { tableView, orderList }

class _DineInScreenState extends State<DineInScreen> {
  _BoardView _view = _BoardView.tableView;
  Stream<List<RestaurantTable>>? _tablesStream;

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  @override
  void didUpdateWidget(covariant DineInScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tableStore != widget.tableStore) {
      _initStream();
    }
  }

  void _initStream() {
    _tablesStream = widget.tableStore?.watchTables();
  }

  DineInTable _toDineInTable(RestaurantTable t) {
    final DineInTableStatus status = switch (t.status) {
      TableStatus.available => DineInTableStatus.available,
      TableStatus.reserved => DineInTableStatus.ready,
      TableStatus.cleaning => DineInTableStatus.available,
      TableStatus.occupied =>
        (t.orderTotalMinor != null && t.orderTotalMinor! > 0)
            ? DineInTableStatus.preparing
            : DineInTableStatus.waitingKot,
    };
    return DineInTable(
      label: t.label,
      status: status,
      seats: t.seats,
      guestCount: t.guestCount ?? t.seats,
      elapsedMinutes: t.elapsedMinutes ?? 0,
      orderTotalMinor: t.orderTotalMinor ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_tablesStream != null) {
      return StreamBuilder<List<RestaurantTable>>(
        stream: _tablesStream,
        builder: (context, snapshot) {
          final tables = (snapshot.data ?? const <RestaurantTable>[])
              .map(_toDineInTable)
              .toList();
          return _buildContent(context, tables);
        },
      );
    }
    return _buildContent(context, const []);
  }

  Widget _buildContent(BuildContext context, List<DineInTable> tables) {
    final active =
        tables.where((t) => t.status != DineInTableStatus.available).length;
    final waitingKot =
        tables.where((t) => t.status == DineInTableStatus.waitingKot).length;
    final preparing =
        tables.where((t) => t.status == DineInTableStatus.preparing).length;
    final ready =
        tables.where((t) => t.status == DineInTableStatus.ready).length;
    final paymentPending = tables
        .where((t) => t.status == DineInTableStatus.paymentPending)
        .length;

    return Container(
        color: ViniiColors.lightPageBg,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dine In Orders',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Wrap(spacing: 10, runSpacing: 8, children: [
                        _SummaryChip(
                            label: 'Active $active',
                            color: ViniiColors.graySolid),
                        _SummaryChip(
                            label: 'Waiting KOT $waitingKot',
                            color: ViniiColors.amberSolid),
                        _SummaryChip(
                            label: 'Preparing $preparing',
                            color: ViniiColors.amberSolid),
                        _SummaryChip(
                            label: 'Ready $ready',
                            color: ViniiColors.greenSolid),
                        _SummaryChip(
                            label: 'Payment Pending $paymentPending',
                            color: ViniiColors.purpleSolid),
                      ]),
                    ]),
              ),
              _ViewToggle(
                  value: _view, onChanged: (v) => setState(() => _view = v)),
            ]),
            const SizedBox(height: 24),
            Expanded(
              child: _view == _BoardView.tableView
                  ? (tables.isEmpty
                      ? const Center(
                          child: Text(
                              'No tables found. Add tables in the Tables module.',
                              style:
                                  TextStyle(color: ViniiColors.textMutedLight)))
                      : LayoutBuilder(
                          builder: (context, gridConstraints) {
                            if (gridConstraints.maxWidth <= 0 ||
                                gridConstraints.maxHeight <= 0) {
                              return const SizedBox.shrink();
                            }
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 320,
                                      mainAxisExtent: 190,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 24),
                              itemCount: tables.length,
                              itemBuilder: (context, i) => TableOrderCard(
                                  table: tables[i],
                                  onOpen: widget.onOpenOrder,
                                  onStart: widget.onStartOrder),
                            );
                          },
                        ))
                  : const Center(
                      child: Text(
                          'Order List view is not part of the approved reference yet.',
                          style: TextStyle(color: ViniiColors.textMutedLight))),
            ),
          ]),
        ));
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(label,
      style:
          TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600));
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.value, required this.onChanged});
  final _BoardView value;
  final ValueChanged<_BoardView> onChanged;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: ViniiColors.grayTint,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ViniiColors.lightBorder)),
      child: Row(children: [
        _ToggleSegment(
            label: 'Table View',
            selected: value == _BoardView.tableView,
            onTap: () => onChanged(_BoardView.tableView)),
        _ToggleSegment(
            label: 'Order List',
            selected: value == _BoardView.orderList,
            onTap: () => onChanged(_BoardView.orderList)),
      ]));
}

class _ToggleSegment extends StatelessWidget {
  const _ToggleSegment(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
              color: selected ? ViniiColors.lightBg : null,
              borderRadius: BorderRadius.circular(6),
              boxShadow: selected
                  ? [const BoxShadow(color: Color(0x14000000), blurRadius: 3)]
                  : null),
          child: Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? ViniiColors.textPrimaryLight
                      : ViniiColors.textMutedLight)),
        ),
      ));
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});
  final DineInTableStatus status;

  static const _labels = <DineInTableStatus, String>{
    DineInTableStatus.available: 'Available',
    DineInTableStatus.ready: 'Ready',
    DineInTableStatus.waitingKot: 'Waiting KOT',
    DineInTableStatus.preparing: 'Preparing',
    DineInTableStatus.paymentPending: 'Payment Pending',
  };

  static const _colors = <DineInTableStatus, Color>{
    DineInTableStatus.available: ViniiColors.greenSolid,
    DineInTableStatus.ready: ViniiColors.greenSolid,
    DineInTableStatus.waitingKot: ViniiColors.amberSolid,
    DineInTableStatus.preparing: ViniiColors.amberSolid,
    DineInTableStatus.paymentPending: ViniiColors.purpleSolid,
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[status]!;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Text(_labels[status]!,
          style: TextStyle(
              color: color, fontSize: 12.5, fontWeight: FontWeight.w600)),
    ]);
  }
}

class TableOrderCard extends StatelessWidget {
  const TableOrderCard(
      {super.key,
      required this.table,
      required this.onOpen,
      required this.onStart});
  final DineInTable table;
  final void Function(DineInTable) onOpen;
  final void Function(DineInTable) onStart;

  Color? get _borderColor => switch (table.status) {
        DineInTableStatus.waitingKot ||
        DineInTableStatus.preparing =>
          ViniiColors.amberSolid,
        DineInTableStatus.paymentPending => ViniiColors.purpleSolid,
        DineInTableStatus.available || DineInTableStatus.ready => null,
      };

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: ViniiColors.lightBg,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
              color: _borderColor ?? ViniiColors.lightBorder,
              width: _borderColor != null ? 1.4 : 1),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))
          ]),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text(table.label,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.person_outline,
                size: 14, color: ViniiColors.textMutedLight),
            Text(
                table.status == DineInTableStatus.available
                    ? ' ${table.seats} seats'
                    : ' ${table.guestCount} Guests',
                style: const TextStyle(
                    fontSize: 12, color: ViniiColors.textMutedLight)),
          ]),
        ]),
        const SizedBox(height: 8),
        StatusChip(status: table.status),
        const SizedBox(height: 10),
        Expanded(
          child: table.status == DineInTableStatus.available
              ? const SizedBox.shrink()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Elapsed',
                            style: TextStyle(
                                fontSize: 12,
                                color: ViniiColors.textMutedLight)),
                        Text('${table.elapsedMinutes} min',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ]),
                  const SizedBox(height: 4),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Total',
                            style: TextStyle(
                                fontSize: 12,
                                color: ViniiColors.textMutedLight)),
                        Text(
                            '₹${(table.orderTotalMinor! / 100).toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ]),
                ]),
        ),
        SizedBox(width: double.infinity, child: _actionButton()),
      ]));

  Widget _actionButton() => switch (table.status) {
        DineInTableStatus.available => FilledButton(
            onPressed: () => onStart(table),
            style: FilledButton.styleFrom(
                backgroundColor: ViniiColors.brandGreen,
                foregroundColor: Colors.black),
            child: const Text('Start Order',
                style: TextStyle(fontWeight: FontWeight.w700))),
        DineInTableStatus.ready => OutlinedButton(
            onPressed: () => onOpen(table),
            style: OutlinedButton.styleFrom(
                foregroundColor: ViniiColors.greenSolid,
                side: const BorderSide(color: ViniiColors.greenSolid)),
            child: const Text('Open Order',
                style: TextStyle(fontWeight: FontWeight.w700))),
        DineInTableStatus.waitingKot ||
        DineInTableStatus.preparing =>
          OutlinedButton(
              onPressed: () => onOpen(table),
              style: OutlinedButton.styleFrom(
                  foregroundColor: ViniiColors.amberSolid,
                  side: const BorderSide(color: ViniiColors.amberSolid)),
              child: const Text('Open Order',
                  style: TextStyle(fontWeight: FontWeight.w700))),
        DineInTableStatus.paymentPending => FilledButton(
            onPressed: () => onOpen(table),
            style: FilledButton.styleFrom(
                backgroundColor: ViniiColors.brandGreen,
                foregroundColor: Colors.black),
            child: const Text('Collect Payment',
                style: TextStyle(fontWeight: FontWeight.w700))),
      };
}

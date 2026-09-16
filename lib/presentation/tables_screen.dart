// Rebuilt 1:1 from v1/POS-TABLES-DEFAULT.png and v1/POS-TABLES-V3.png
// (light/dark pair) — see Q02 in docs/DECISIONS-AND-QUESTIONS.txt.
// PAGE-RES-003 in the architecture source additionally lists
// merge/split/transfer for this page; none of that is visible in either
// reference screen, so it is not built here.

import 'package:flutter/material.dart';

import '../data/local_table_catalog.dart';
import '../domain/restaurant_table.dart';
import 'vinii_theme.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen(
      {super.key, required this.onOpenTable, required this.onStartOrder});

  /// Table has an active order — go to it (occupied cards).
  final void Function(RestaurantTable table) onOpenTable;

  /// No order yet — start one (available cards, and reserved "Seat Now").
  final void Function(RestaurantTable table) onStartOrder;

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

enum _ZoneFilter { all, indoor, outdoor, privateDining }

class _TablesScreenState extends State<TablesScreen> {
  _ZoneFilter _filter = _ZoneFilter.all;

  List<RestaurantTable> get _visible {
    final zone = switch (_filter) {
      _ZoneFilter.all => null,
      _ZoneFilter.indoor => TableZone.indoor,
      _ZoneFilter.outdoor => TableZone.outdoor,
      _ZoneFilter.privateDining => TableZone.privateDining,
    };
    if (zone == null) return LocalTableCatalog.tables;
    return LocalTableCatalog.tables.where((t) => t.zone == zone).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tables = LocalTableCatalog.tables;
    final occupied =
        tables.where((t) => t.status == TableStatus.occupied).length;
    final available =
        tables.where((t) => t.status == TableStatus.available).length;
    final reserved =
        tables.where((t) => t.status == TableStatus.reserved).length;
    final cleaning =
        tables.where((t) => t.status == TableStatus.cleaning).length;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Tables',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Wrap(children: [
                Text('${tables.length} Total  •  '),
                Text('$occupied Occupied  •  ',
                    style: const TextStyle(
                        color: ViniiColors.blueSolid,
                        fontWeight: FontWeight.w600)),
                Text('$available Available  •  ',
                    style: const TextStyle(
                        color: ViniiColors.greenSolid,
                        fontWeight: FontWeight.w600)),
                Text('$reserved Reserved  •  ',
                    style: const TextStyle(
                        color: ViniiColors.amberSolid,
                        fontWeight: FontWeight.w600)),
                Text('$cleaning Cleaning'),
              ]),
            ]),
          ),
          _ZoneFilterBar(
              value: _filter, onChanged: (v) => setState(() => _filter = v)),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 235,
                mainAxisExtent: 178,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemCount: _visible.length,
            itemBuilder: (context, i) => _TableCard(
                table: _visible[i],
                onOpen: widget.onOpenTable,
                onStart: widget.onStartOrder),
          ),
        ),
      ]),
    );
  }
}

class _ZoneFilterBar extends StatelessWidget {
  const _ZoneFilterBar({required this.value, required this.onChanged});
  final _ZoneFilter value;
  final ValueChanged<_ZoneFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    const options = [
      (_ZoneFilter.all, 'All'),
      (_ZoneFilter.indoor, 'Indoor'),
      (_ZoneFilter.outdoor, 'Outdoor'),
      (_ZoneFilter.privateDining, 'Private Dining'),
    ];
    return Wrap(
      spacing: 8,
      children: [
        for (final (zone, label) in options)
          ChoiceChip(
            label: Text(label),
            selected: value == zone,
            selectedColor: ViniiColors.brandGreen,
            labelStyle: TextStyle(
                color: value == zone ? Colors.black : null,
                fontWeight: FontWeight.w600),
            onSelected: (_) => onChanged(zone),
          ),
      ],
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard(
      {required this.table, required this.onOpen, required this.onStart});
  final RestaurantTable table;
  final void Function(RestaurantTable) onOpen;
  final void Function(RestaurantTable) onStart;

  @override
  Widget build(BuildContext context) {
    final (borderColor, accent) = switch (table.status) {
      TableStatus.occupied => (ViniiColors.blueSolid, ViniiColors.blueSolid),
      TableStatus.available => (ViniiColors.greenSolid, ViniiColors.greenSolid),
      TableStatus.reserved => (ViniiColors.amberSolid, ViniiColors.amberSolid),
      TableStatus.cleaning => (Colors.grey.shade300, ViniiColors.graySolid),
    };

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(table.label,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          if (table.status != TableStatus.cleaning)
            Row(children: [
              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
              Text(
                  table.status == TableStatus.occupied
                      ? ' ${table.guestCount} Guests'
                      : ' ${table.seats} seats',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ])
          else
            const Icon(Icons.access_time, size: 16, color: Colors.grey),
        ]),
        const SizedBox(height: 10),
        Expanded(child: _CardBody(table: table, accent: accent)),
        SizedBox(
          width: double.infinity,
          child: switch (table.status) {
            TableStatus.occupied => OutlinedButton(
                onPressed: () => onOpen(table),
                style: OutlinedButton.styleFrom(foregroundColor: accent),
                child: const Text('Open Order')),
            TableStatus.available => OutlinedButton(
                onPressed: () => onStart(table),
                style: OutlinedButton.styleFrom(
                    foregroundColor: accent,
                    backgroundColor: ViniiColors.greenTint),
                child: const Text('Start Order')),
            TableStatus.reserved => FilledButton(
                onPressed: () => onStart(table),
                style: FilledButton.styleFrom(backgroundColor: accent),
                child: const Text('Seat Now')),
            TableStatus.cleaning =>
              OutlinedButton(onPressed: null, child: const Text('Mark Ready')),
          },
        ),
      ]),
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.table, required this.accent});
  final RestaurantTable table;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    switch (table.status) {
      case TableStatus.occupied:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Elapsed',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('${table.elapsedMinutes} min',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Order Total',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('₹${(table.orderTotalMinor! / 100).toStringAsFixed(0)}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ]),
        ]);
      case TableStatus.available:
        return Row(children: [
          Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('Available',
              style: TextStyle(
                  color: accent, fontWeight: FontWeight.w600, fontSize: 13)),
        ]);
      case TableStatus.reserved:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${table.reservedByName} · 7:30 PM',
              style: TextStyle(
                  color: accent, fontWeight: FontWeight.w600, fontSize: 13)),
          const Text('Reserved',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ]);
      case TableStatus.cleaning:
        return const Text('Cleaning', style: TextStyle(color: Colors.grey));
    }
  }
}

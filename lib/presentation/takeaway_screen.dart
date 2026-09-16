// Rebuilt 1:1 from v1/POS-TAKEAWAY-V3.png. Only the "New" tab has real
// reference cards (the other three tabs are counts only in the
// screenshot, no populated content) — switching tabs shows an honest
// empty state rather than inventing card content for them.

import 'package:flutter/material.dart';

import '../data/local_takeaway_catalog.dart';
import 'vinii_theme.dart';

class TakeawayScreen extends StatefulWidget {
  const TakeawayScreen({super.key});

  @override
  State<TakeawayScreen> createState() => _TakeawayScreenState();
}

class _TakeawayScreenState extends State<TakeawayScreen> {
  String _tab = 'New';

  @override
  Widget build(BuildContext context) => Container(
      color: ViniiColors.lightPageBg,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Takeaway Orders',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${LocalTakeawayCatalog.totalToday} today',
                        style: const TextStyle(
                            color: ViniiColors.textMutedLight, fontSize: 13)),
                  ]),
            ),
            FilledButton.icon(
                onPressed: null,
                style: FilledButton.styleFrom(
                    backgroundColor: ViniiColors.brandGreen,
                    foregroundColor: Colors.black),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Takeaway',
                    style: TextStyle(fontWeight: FontWeight.w700))),
          ]),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in LocalTakeawayCatalog.tabCounts.entries)
                ChoiceChip(
                    label: Text('${entry.key}  ${entry.value}'),
                    selected: _tab == entry.key,
                    selectedColor: ViniiColors.brandGreen,
                    labelStyle: TextStyle(
                        color: _tab == entry.key ? Colors.black : null,
                        fontWeight: FontWeight.w600),
                    onSelected: (_) => setState(() => _tab = entry.key)),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _tab == 'New'
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 340,
                            mainAxisExtent: 200,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 24),
                    itemCount: LocalTakeawayCatalog.orders.length,
                    itemBuilder: (context, i) =>
                        _TakeawayCard(order: LocalTakeawayCatalog.orders[i]))
                : const Center(
                    child: Text('No populated reference for this tab yet.',
                        style: TextStyle(color: ViniiColors.textMutedLight))),
          ),
        ]),
      ));
}

class _TakeawayCard extends StatelessWidget {
  const _TakeawayCard({required this.order});
  final TakeawayOrder order;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: ViniiColors.lightBg,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: ViniiColors.lightBorder),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))
          ]),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(order.orderId,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Text(order.time,
              style: const TextStyle(
                  fontSize: 12, color: ViniiColors.textMutedLight)),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: ViniiColors.blueTint,
                  borderRadius: BorderRadius.circular(4)),
              child: const Text('NEW',
                  style: TextStyle(
                      color: ViniiColors.blueSolid,
                      fontSize: 10,
                      fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: 8),
        Text(order.customer,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 2),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: order.itemsSummary),
            if (order.moreCount > 0)
              TextSpan(
                  text: '  + ${order.moreCount} more',
                  style: const TextStyle(color: ViniiColors.textMutedLight)),
          ]),
          style: const TextStyle(
              fontSize: 12.5, color: ViniiColors.textSecondaryLight),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('TOTAL',
                  style: TextStyle(
                      fontSize: 10, color: ViniiColors.textMutedLight)),
              Text('₹${(order.totalMinor / 100).toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ViniiColors.greenSolid)),
            ]),
          ),
          Text(order.agoLabel,
              style: const TextStyle(
                  fontSize: 11, color: ViniiColors.textMutedLight)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child:
                  OutlinedButton(onPressed: null, child: const Text('View'))),
          const SizedBox(width: 10),
          Expanded(
              child: FilledButton(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                      backgroundColor: ViniiColors.brandGreen,
                      foregroundColor: Colors.black),
                  child: const Text('Send KOT',
                      style: TextStyle(fontWeight: FontWeight.w700)))),
        ]),
      ]));
}

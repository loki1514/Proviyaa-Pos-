// Rebuilt 1:1 from v1/POS-DELIVERY-V3.png. Only "Out for Delivery" has
// populated reference cards (the reference screenshot has that tab
// selected); the other tabs show an honest empty state.

import 'package:flutter/material.dart';

import '../data/local_delivery_catalog.dart';
import 'vinii_theme.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String _tab = 'Out for Delivery';

  static const _stageOrder = [
    DeliveryStage.confirmed,
    DeliveryStage.preparing,
    DeliveryStage.pickedUp,
    DeliveryStage.delivered,
  ];
  static const _stageLabels = {
    DeliveryStage.confirmed: 'Confirmed',
    DeliveryStage.preparing: 'Preparing',
    DeliveryStage.pickedUp: 'Picked Up',
    DeliveryStage.delivered: 'Delivered',
  };

  static const _platformColors = <String, Color>{
    'Zomato': ViniiColors.redSolid,
    'Swiggy': ViniiColors.amberSolid,
    'Direct': ViniiColors.greenSolid,
  };

  @override
  Widget build(BuildContext context) => Container(
      color: ViniiColors.lightPageBg,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Delivery Orders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('${LocalDeliveryCatalog.totalToday} orders today',
              style: const TextStyle(
                  color: ViniiColors.textMutedLight, fontSize: 13)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in LocalDeliveryCatalog.tabCounts.entries)
                ChoiceChip(
                    label: Text('${entry.key} (${entry.value})'),
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
            child: _tab == 'Out for Delivery'
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 420,
                            mainAxisExtent: 252,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: LocalDeliveryCatalog.orders.length,
                    itemBuilder: (context, i) => _DeliveryCard(
                        order: LocalDeliveryCatalog.orders[i],
                        platformColor: _platformColors[
                                LocalDeliveryCatalog.orders[i].platform] ??
                            ViniiColors.graySolid))
                : const Center(
                    child: Text('No populated reference for this tab yet.',
                        style: TextStyle(color: ViniiColors.textMutedLight))),
          ),
        ]),
      ));

  static Widget _progress(DeliveryStage stage) => Row(children: [
        for (final s in _stageOrder) ...[
          Expanded(
            child: Column(children: [
              Text(_stageLabels[s]!,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          s == stage ? FontWeight.w700 : FontWeight.w500,
                      color: s == stage
                          ? ViniiColors.greenSolid
                          : ViniiColors.textMutedLight)),
              const SizedBox(height: 4),
              Container(
                  height: 4,
                  decoration: BoxDecoration(
                      color:
                          _stageOrder.indexOf(s) <= _stageOrder.indexOf(stage)
                              ? ViniiColors.greenSolid
                              : ViniiColors.grayTint,
                      borderRadius: BorderRadius.circular(2))),
            ]),
          ),
          if (s != _stageOrder.last) const SizedBox(width: 4),
        ],
      ]);
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.order, required this.platformColor});
  final DeliveryOrder order;
  final Color platformColor;

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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: platformColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(order.platform,
                  style: TextStyle(
                      color: platformColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: 8),
        Text(order.customer,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        Text(order.address,
            style: const TextStyle(
                fontSize: 12, color: ViniiColors.textMutedLight),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 10),
        Row(children: [
          Flexible(
            child: Text(
                '${order.itemsLabel} · ₹${(order.amountMinor / 100).toStringAsFixed(0)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text('Assigned: ${order.riderName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 11, color: ViniiColors.textMutedLight)),
          ),
        ]),
        const SizedBox(height: 10),
        _DeliveryScreenState._progress(order.stage),
        const Spacer(),
        // A Row with a trailing ETA pill + two full-size buttons only
        // fits at the reference's desktop card width — this grid can
        // fall back to narrower cards (see the "prevent overflow on
        // narrower windows" rule), where that combination doesn't fit
        // on one line. Stacking the ETA pill above two equal, compact
        // buttons stays within any card width instead of overflowing.
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: ViniiColors.redTint,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('ETA: ${order.etaMinutes} min',
                    style: const TextStyle(
                        color: ViniiColors.redSolid,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)))),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text('Call Rider',
                      style: TextStyle(fontSize: 12.5)))),
          const SizedBox(width: 8),
          Expanded(
              child: FilledButton(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                      backgroundColor: ViniiColors.brandGreen,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text('Track',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 12.5)))),
        ]),
      ]));
}

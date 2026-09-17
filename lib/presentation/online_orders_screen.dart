// Rebuilt 1:1 from v1/POS-ONLINE-ORDERS-V3.png.

import 'package:flutter/material.dart';

import '../data/local_online_orders_catalog.dart';
import 'vinii_theme.dart';

// Fixed-width columns inside a horizontal scroller — same fix, and same
// reason, as all_orders_screen.dart: flexible columns wrapped cell text
// mid-word on a window narrower than the reference's desktop width.
const _colBadge = 24.0;
const _colOrder = 100.0;
const _colCustomer = 120.0;
const _colItems = 220.0;
const _colAmount = 70.0;
const _colStatus = 110.0;
const _colTime = 70.0;
const _colActions = 180.0;
const _tableWidth = _colBadge +
    12 +
    _colOrder +
    _colCustomer +
    _colItems +
    _colAmount +
    _colStatus +
    _colTime +
    _colActions +
    32;

class OnlineOrdersScreen extends StatefulWidget {
  const OnlineOrdersScreen({super.key});

  @override
  State<OnlineOrdersScreen> createState() => _OnlineOrdersScreenState();
}

class _OnlineOrdersScreenState extends State<OnlineOrdersScreen> {
  String _platform = 'All Platforms';
  String _statusTab = 'Pending';

  static const _statusColors = <String, Color>{
    'Pending': ViniiColors.amberSolid,
    'Accepted': ViniiColors.greenSolid,
    'Preparing': ViniiColors.blueSolid,
    'Ready': ViniiColors.greenSolid,
    'Dispatched': ViniiColors.blueSolid,
    'Delivered': ViniiColors.graySolid,
    'Cancelled': ViniiColors.redSolid,
  };

  static const _platformBadgeColors = <String, Color>{
    'Z': ViniiColors.redSolid,
    'S': ViniiColors.amberSolid,
    'W': ViniiColors.greenSolid,
  };

  @override
  Widget build(BuildContext context) => Container(
      color: ViniiColors.lightPageBg,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('Online Orders',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: ViniiColors.greenTint,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                    '${LocalOnlineOrdersCatalog.totalToday} orders today',
                    style: const TextStyle(
                        color: ViniiColors.greenSolid,
                        fontSize: 12,
                        fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final p in LocalOnlineOrdersCatalog.platforms)
                ChoiceChip(
                    label: Text(p),
                    selected: _platform == p,
                    selectedColor: ViniiColors.sidebarDark,
                    labelStyle: TextStyle(
                        color: _platform == p ? Colors.white : null,
                        fontWeight: FontWeight.w600),
                    onSelected: (_) => setState(() => _platform = p)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in LocalOnlineOrdersCatalog.statusTabs.entries)
                ChoiceChip(
                    label: Text('${entry.key}  ${entry.value}'),
                    selected: _statusTab == entry.key,
                    selectedColor: ViniiColors.brandGreen,
                    labelStyle: TextStyle(
                        color: _statusTab == entry.key ? Colors.black : null,
                        fontWeight: FontWeight.w600),
                    onSelected: (_) => setState(() => _statusTab = entry.key)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: constraints.maxWidth < _tableWidth
                      ? _tableWidth
                      : constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ViniiColors.lightBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ViniiColors.lightBorder)),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: LocalOnlineOrdersCatalog.rows.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 1, color: ViniiColors.lightBorder),
                      itemBuilder: (context, i) {
                        final row = LocalOnlineOrdersCatalog.rows[i];
                        return _OnlineOrderRow(
                            row: row,
                            statusColor: _statusColors[row.status]!,
                            platformColor: _platformBadgeColors[row.platform]!);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ));
}

class _OnlineOrderRow extends StatelessWidget {
  const _OnlineOrderRow(
      {required this.row,
      required this.statusColor,
      required this.platformColor});
  final OnlineOrderRow row;
  final Color statusColor, platformColor;

  bool get _isDestructive => row.status == 'Pending';

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Container(
            width: _colBadge,
            height: _colBadge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: platformColor, borderRadius: BorderRadius.circular(6)),
            child: Text(row.platform,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        SizedBox(
            width: _colOrder,
            child: Text(row.orderId,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 13))),
        SizedBox(
            width: _colCustomer,
            child: Text(row.customer,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13))),
        SizedBox(
            width: _colItems,
            child: Text(row.itemsLabel,
                style: const TextStyle(
                    fontSize: 12.5, color: ViniiColors.textMutedLight),
                maxLines: 1,
                overflow: TextOverflow.ellipsis)),
        SizedBox(
            width: _colAmount,
            child: Text('₹${(row.amountMinor / 100).toStringAsFixed(0)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700))),
        SizedBox(
            width: _colStatus,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(row.status,
                        style: TextStyle(
                            color: statusColor,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600))))),
        SizedBox(
            width: _colTime,
            child: Text(row.time,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: ViniiColors.textMutedLight))),
        SizedBox(
          width: _colActions,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isDestructive)
                    TextButton(
                      onPressed: null,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text('Reject',
                          style: TextStyle(color: ViniiColors.redSolid)),
                    ),
                  if (_isDestructive) const SizedBox(width: 4),
                  FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: _isDestructive
                          ? ViniiColors.brandGreen
                          : ViniiColors.grayTint,
                      foregroundColor: _isDestructive
                          ? Colors.black
                          : ViniiColors.textPrimaryLight,
                    ),
                    child: Text(row.actionLabel,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]));
}

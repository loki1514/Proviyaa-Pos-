// Rebuilt 1:1 from v1/POS-ALL-ORDERS-V3.png. Filters, search, Status/Date
// selectors, "View" and pagination are decorative (no query backing them
// yet) — the same "static until a real store exists" rule already
// applied to POS-MAIN's "Sort By: Popularity" and other unwired controls.

import 'package:flutter/material.dart';

import '../data/local_all_orders_catalog.dart';
import 'vinii_theme.dart';

// Fixed-width columns inside a horizontal scroller rather than flexible
// (Expanded) ones: at the reference's desktop width every column fits
// on one line, but flexible columns on a narrower window squeeze cell
// text into an ugly mid-word wrap ("Delive\nry") instead of a clean
// horizontal scroll — caught by actually resizing the running app.
const _colOrder = 90.0;
const _colType = 100.0;
const _colSource = 90.0;
const _colCustomer = 160.0;
const _colItems = 80.0;
const _colAmount = 100.0;
const _colStatus = 110.0;
const _colTime = 80.0;
const _colAction = 60.0;
const _tableWidth = _colOrder +
    _colType +
    _colSource +
    _colCustomer +
    _colItems +
    _colAmount +
    _colStatus +
    _colTime +
    _colAction +
    32; // horizontal padding

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  String _filter = 'All';

  static const _statusColors = <String, Color>{
    'New': ViniiColors.blueSolid,
    'Ready': ViniiColors.greenSolid,
    'Preparing': ViniiColors.amberSolid,
    'Completed': ViniiColors.graySolid,
    'Cancelled': ViniiColors.redSolid,
  };

  @override
  Widget build(BuildContext context) {
    final rows = _filter == 'All'
        ? LocalAllOrdersCatalog.rows
        : LocalAllOrdersCatalog.rows.where((r) => r.type == _filter).toList();

    return Container(
      color: ViniiColors.lightPageBg,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('All Orders',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${LocalAllOrdersCatalog.totalToday} orders today',
                        style: const TextStyle(
                            color: ViniiColors.textMutedLight, fontSize: 13)),
                  ]),
            ),
            OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.file_download_outlined, size: 16),
                label: const Text('Export')),
          ]),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in LocalAllOrdersCatalog.filterCounts.entries)
                ChoiceChip(
                    label: Text('${entry.key}  ${entry.value}'),
                    selected: _filter == entry.key,
                    selectedColor: ViniiColors.brandGreen,
                    labelStyle: TextStyle(
                        color: _filter == entry.key ? Colors.black : null,
                        fontWeight: FontWeight.w600),
                    onSelected: (_) => setState(() => _filter = entry.key)),
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
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ViniiColors.lightBorder))),
                        child: const Row(children: [
                          SizedBox(
                              width: _colOrder, child: _HeaderLabel('ORDER')),
                          SizedBox(
                              width: _colType, child: _HeaderLabel('TYPE')),
                          SizedBox(
                              width: _colSource, child: _HeaderLabel('SOURCE')),
                          SizedBox(
                              width: _colCustomer,
                              child: _HeaderLabel('TABLE/CUSTOMER')),
                          SizedBox(
                              width: _colItems, child: _HeaderLabel('ITEMS')),
                          SizedBox(
                              width: _colAmount, child: _HeaderLabel('AMOUNT')),
                          SizedBox(
                              width: _colStatus, child: _HeaderLabel('STATUS')),
                          SizedBox(
                              width: _colTime, child: _HeaderLabel('TIME')),
                          SizedBox(width: _colAction, child: _HeaderLabel('')),
                        ]),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: rows.length,
                          separatorBuilder: (_, __) => const Divider(
                              height: 1, color: ViniiColors.lightBorder),
                          itemBuilder: (context, i) => _OrderRow(
                              row: rows[i],
                              statusColor: _statusColors[rows[i].status]!),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: ViniiColors.textMutedLight,
          letterSpacing: 0.4));
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({required this.row, required this.statusColor});
  final AllOrdersRow row;
  final Color statusColor;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        SizedBox(
            width: _colOrder,
            child: Text(row.orderId,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: ViniiColors.brandGreen,
                    fontWeight: FontWeight.w600))),
        SizedBox(width: _colType, child: _Pill(text: row.type)),
        SizedBox(
            width: _colSource,
            child: Text(row.source,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13))),
        SizedBox(
            width: _colCustomer,
            child: Text(row.tableOrCustomer,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13))),
        SizedBox(
            width: _colItems,
            child: Text(row.itemsLabel,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, color: ViniiColors.textMutedLight))),
        SizedBox(
            width: _colAmount,
            child: Text('₹${(row.amountMinor / 100).toStringAsFixed(2)}',
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600))))),
        SizedBox(
            width: _colTime,
            child: Text(row.time,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, color: ViniiColors.textMutedLight))),
        SizedBox(
            width: _colAction,
            child: TextButton(
                onPressed: null,
                child: const Text('View',
                    style: TextStyle(fontWeight: FontWeight.w600)))),
      ]));
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
              color: ViniiColors.grayTint,
              borderRadius: BorderRadius.circular(20)),
          child: Text(text,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))));
}

// Rebuilt from v1/POS-ALL-ORDERS-V3.png with full SQLite CRUD support via DriftAllOrdersStore.

import 'package:flutter/material.dart';

import '../data/drift_all_orders_store.dart';
import '../data/local_all_orders_catalog.dart';
import 'vinii_theme.dart';

const _colOrder = 90.0;
const _colType = 100.0;
const _colSource = 90.0;
const _colCustomer = 160.0;
const _colItems = 90.0;
const _colAmount = 100.0;
const _colStatus = 120.0;
const _colTime = 80.0;
const _colAction = 100.0;
const _tableWidth = _colOrder +
    _colType +
    _colSource +
    _colCustomer +
    _colItems +
    _colAmount +
    _colStatus +
    _colTime +
    _colAction +
    32;

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key, this.ordersStore});
  final DriftAllOrdersStore? ordersStore;

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  String _filter = 'All';

  static const _statusColors = <String, Color>{
    'New': ViniiColors.blueSolid,
    'Hold': Colors.orange,
    'Ready': ViniiColors.greenSolid,
    'Preparing': ViniiColors.amberSolid,
    'Completed': ViniiColors.graySolid,
    'Cancelled': ViniiColors.redSolid,
  };

  void _openAddEditDialog(BuildContext context, AllOrdersRow? existing) {
    showDialog(
      context: context,
      builder: (ctx) => _AddEditOrderDialog(
        existing: existing,
        onSave: (order) async {
          if (widget.ordersStore != null) {
            if (existing == null) {
              await widget.ordersStore!.insertOrder(order);
            } else {
              await widget.ordersStore!.updateOrder(order);
            }
          }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Order $orderId?'),
        content: const Text(
            'Are you sure you want to delete this order? This action will permanently remove it from the local database.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              if (widget.ordersStore != null) {
                await widget.ordersStore!.deleteOrder(orderId);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _updateStatus(String orderId, String newStatus) async {
    if (widget.ordersStore != null) {
      await widget.ordersStore!.updateStatus(orderId, newStatus);
    }
  }

  Map<String, int> _computeFilterCounts(List<AllOrdersRow> orders) {
    final counts = <String, int>{
      'All': orders.length,
      'Dine In': orders.where((o) => o.type == 'Dine In').length,
      'Takeaway': orders.where((o) => o.type == 'Takeaway').length,
      'Delivery': orders.where((o) => o.type == 'Delivery').length,
      'Zomato': orders.where((o) => o.source == 'Zomato').length,
      'Swiggy': orders.where((o) => o.source == 'Swiggy').length,
    };
    return counts;
  }

  List<AllOrdersRow> _filterOrders(List<AllOrdersRow> orders) {
    if (_filter == 'All') return orders;
    if (_filter == 'Zomato' || _filter == 'Swiggy') {
      return orders.where((o) => o.source == _filter).toList();
    }
    return orders.where((o) => o.type == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ordersStore != null) {
      return StreamBuilder<List<AllOrdersRow>>(
        stream: widget.ordersStore!.watchAllOrders(),
        builder: (context, snapshot) {
          final orders = snapshot.data ?? [];
          return _buildContent(context, orders);
        },
      );
    }
    // Fallback if no store is supplied
    return _buildContent(context, const []);
  }

  Widget _buildContent(BuildContext context, List<AllOrdersRow> allOrders) {
    final filterCounts = _computeFilterCounts(allOrders);
    final visibleRows = _filterOrders(allOrders);

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
                    Text('${allOrders.length} orders total in database',
                        style: const TextStyle(
                            color: ViniiColors.textMutedLight, fontSize: 13)),
                  ]),
            ),
            OutlinedButton.icon(
              onPressed: allOrders.isEmpty ? null : () {},
              icon: const Icon(Icons.file_download_outlined, size: 16),
              label: const Text('Export'),
            ),
          ]),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in filterCounts.entries)
                ChoiceChip(
                  label: Text('${entry.key}  ${entry.value}'),
                  selected: _filter == entry.key,
                  selectedColor: ViniiColors.brandGreen,
                  labelStyle: TextStyle(
                      color: _filter == entry.key ? Colors.black : null,
                      fontWeight: FontWeight.w600),
                  onSelected: (_) => setState(() => _filter = entry.key),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: allOrders.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 56, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('No orders in database yet',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6),
                        Text(
                          'When a new order is created and paid via the POS, it will appear here automatically.',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
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
                              border:
                                  Border.all(color: ViniiColors.lightBorder)),
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
                                    width: _colOrder,
                                    child: _HeaderLabel('ORDER')),
                                SizedBox(
                                    width: _colType,
                                    child: _HeaderLabel('TYPE')),
                                SizedBox(
                                    width: _colSource,
                                    child: _HeaderLabel('SOURCE')),
                                SizedBox(
                                    width: _colCustomer,
                                    child: _HeaderLabel('TABLE/CUSTOMER')),
                                SizedBox(
                                    width: _colItems,
                                    child: _HeaderLabel('ITEMS')),
                                SizedBox(
                                    width: _colAmount,
                                    child: _HeaderLabel('AMOUNT')),
                                SizedBox(
                                    width: _colStatus,
                                    child: _HeaderLabel('STATUS')),
                                SizedBox(
                                    width: _colTime,
                                    child: _HeaderLabel('TIME')),
                                SizedBox(
                                    width: _colAction,
                                    child: _HeaderLabel('ACTION')),
                              ]),
                            ),
                            Expanded(
                              child: visibleRows.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'No orders match this filter.',
                                          style: TextStyle(color: Colors.grey)),
                                    )
                                  : ListView.separated(
                                      itemCount: visibleRows.length,
                                      separatorBuilder: (_, __) =>
                                          const Divider(
                                              height: 1,
                                              color: ViniiColors.lightBorder),
                                      itemBuilder: (context, i) => _OrderRow(
                                        row: visibleRows[i],
                                        statusColor: _statusColors[
                                                visibleRows[i].status] ??
                                            Colors.grey,
                                        onEdit: () => _openAddEditDialog(
                                            context, visibleRows[i]),
                                        onDelete: () => _confirmDelete(
                                            context, visibleRows[i].orderId),
                                        onStatusChanged: (newStatus) =>
                                            _updateStatus(
                                                visibleRows[i].orderId,
                                                newStatus),
                                      ),
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
  const _OrderRow({
    required this.row,
    required this.statusColor,
    required this.onEdit,
    required this.onDelete,
    required this.onStatusChanged,
  });

  final AllOrdersRow row;
  final Color statusColor;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<String> onStatusChanged;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            child: PopupMenuButton<String>(
              tooltip: 'Change status',
              onSelected: onStatusChanged,
              itemBuilder: (ctx) => [
                for (final s in [
                  'New',
                  'Hold',
                  'Preparing',
                  'Ready',
                  'Completed',
                  'Cancelled'
                ])
                  PopupMenuItem(
                    value: s,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _AllOrdersScreenState._statusColors[s] ??
                                Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(s),
                      ],
                    ),
                  ),
              ],
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(row.status,
                        style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down,
                        size: 14, color: statusColor),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            width: _colTime,
            child: Text(row.time,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, color: ViniiColors.textMutedLight))),
        SizedBox(
          width: _colAction,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 18, color: Colors.blueGrey),
                tooltip: 'Edit / View',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onEdit,
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 18, color: Colors.red),
                tooltip: 'Delete',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
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

class _AddEditOrderDialog extends StatefulWidget {
  const _AddEditOrderDialog({required this.existing, required this.onSave});
  final AllOrdersRow? existing;
  final Future<void> Function(AllOrdersRow) onSave;

  @override
  State<_AddEditOrderDialog> createState() => _AddEditOrderDialogState();
}

class _AddEditOrderDialogState extends State<_AddEditOrderDialog> {
  late final TextEditingController _orderIdController;
  late final TextEditingController _customerController;
  late final TextEditingController _itemsController;
  late final TextEditingController _amountController;
  late String _type;
  late String _source;
  late String _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final defaultId =
        '#${(DateTime.now().millisecondsSinceEpoch % 9000 + 1000)}';
    _orderIdController =
        TextEditingController(text: widget.existing?.orderId ?? defaultId);
    _customerController = TextEditingController(
        text: widget.existing?.tableOrCustomer ?? '');
    _itemsController =
        TextEditingController(text: widget.existing?.itemsLabel ?? '1 item');
    final initialAmount = widget.existing != null
        ? (widget.existing!.amountMinor / 100).toStringAsFixed(2)
        : '250.00';
    _amountController = TextEditingController(text: initialAmount);
    _type = widget.existing?.type ?? 'Dine In';
    _source = widget.existing?.source ?? 'Walk-in';
    _status = widget.existing?.status ?? 'New';
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _customerController.dispose();
    _itemsController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return AlertDialog(
      title: Text(isNew ? 'New Order' : 'Edit Order ${widget.existing!.orderId}'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _orderIdController,
                decoration: const InputDecoration(
                  labelText: 'Order ID',
                  hintText: 'e.g. #1088',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _type,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Dine In', child: Text('Dine In')),
                        DropdownMenuItem(
                            value: 'Takeaway', child: Text('Takeaway')),
                        DropdownMenuItem(
                            value: 'Delivery', child: Text('Delivery')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _type = v);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _source,
                      decoration: const InputDecoration(
                        labelText: 'Source',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Walk-in', child: Text('Walk-in')),
                        DropdownMenuItem(
                            value: 'Zomato', child: Text('Zomato')),
                        DropdownMenuItem(
                            value: 'Swiggy', child: Text('Swiggy')),
                        DropdownMenuItem(
                            value: 'Direct Phone',
                            child: Text('Direct Phone')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _source = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _customerController,
                decoration: const InputDecoration(
                  labelText: 'Table / Customer Name',
                  hintText: 'e.g. Table 5 or John Doe',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _itemsController,
                      decoration: const InputDecoration(
                        labelText: 'Items Summary',
                        hintText: 'e.g. 3 items',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Amount (₹)',
                        hintText: '250.00',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: 'Order Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'New', child: Text('New')),
                  DropdownMenuItem(value: 'Hold', child: Text('Hold')),
                  DropdownMenuItem(
                      value: 'Preparing', child: Text('Preparing')),
                  DropdownMenuItem(value: 'Ready', child: Text('Ready')),
                  DropdownMenuItem(
                      value: 'Completed', child: Text('Completed')),
                  DropdownMenuItem(
                      value: 'Cancelled', child: Text('Cancelled')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _status = v);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ViniiColors.brandGreen,
            foregroundColor: Colors.black,
          ),
          onPressed: _saving
              ? null
              : () async {
                  final id = _orderIdController.text.trim();
                  if (id.isEmpty) return;
                  final customer = _customerController.text.trim().isEmpty
                      ? 'Walk-in Customer'
                      : _customerController.text.trim();
                  final items = _itemsController.text.trim().isEmpty
                      ? '1 item'
                      : _itemsController.text.trim();
                  final amountNum =
                      double.tryParse(_amountController.text.trim()) ?? 0.0;
                  final amountMinor = (amountNum * 100).round();

                  setState(() => _saving = true);

                  final order = AllOrdersRow(
                    orderId: id,
                    type: _type,
                    source: _source,
                    tableOrCustomer: customer,
                    itemsLabel: items,
                    amountMinor: amountMinor,
                    status: _status,
                    time: widget.existing?.time ?? 'Just now',
                  );

                  await widget.onSave(order);
                  if (mounted) Navigator.pop(context);
                },
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(isNew ? 'Create Order' : 'Save Order'),
        ),
      ],
    );
  }
}

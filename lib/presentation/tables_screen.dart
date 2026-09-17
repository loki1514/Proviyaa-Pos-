// Rebuilt 1:1 from v1/POS-TABLES-DEFAULT.png and v1/POS-TABLES-V3.png
// with full SQLite CRUD support via DriftTableStore.

import 'package:flutter/material.dart';

import '../data/drift_table_store.dart';
import '../domain/restaurant_table.dart';
import 'vinii_theme.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({
    super.key,
    this.tableStore,
    required this.onOpenTable,
    required this.onStartOrder,
  });

  final DriftTableStore? tableStore;

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

  List<RestaurantTable> _filterTables(List<RestaurantTable> all) {
    final zone = switch (_filter) {
      _ZoneFilter.all => null,
      _ZoneFilter.indoor => TableZone.indoor,
      _ZoneFilter.outdoor => TableZone.outdoor,
      _ZoneFilter.privateDining => TableZone.privateDining,
    };
    if (zone == null) return all;
    return all.where((t) => t.zone == zone).toList();
  }

  void _openAddEditDialog(BuildContext context, RestaurantTable? existing) {
    showDialog(
      context: context,
      builder: (ctx) => _AddEditTableDialog(
        existing: existing,
        onSave: (table) async {
          if (widget.tableStore != null) {
            if (existing == null) {
              await widget.tableStore!.insertTable(table);
            } else {
              await widget.tableStore!.updateTable(table);
            }
          }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, RestaurantTable table) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Table ${table.label}?'),
        content: const Text(
            'Are you sure you want to delete this table? This action will remove it from the local database.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              if (widget.tableStore != null) {
                await widget.tableStore!.deleteTable(table.id);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _changeStatus(RestaurantTable table, TableStatus newStatus) async {
    if (widget.tableStore != null) {
      await widget.tableStore!.updateStatus(table.id, newStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tableStore != null) {
      return StreamBuilder<List<RestaurantTable>>(
        stream: widget.tableStore!.watchTables(),
        builder: (context, snapshot) {
          final tables = snapshot.data ?? const [];
          return _buildContent(context, tables);
        },
      );
    }
    return _buildContent(context, const []);
  }

  Widget _buildContent(BuildContext context, List<RestaurantTable> tables) {
    final visible = _filterTables(tables);
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
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          const SizedBox(width: 12),
          FilledButton.icon(
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Table'),
            style: FilledButton.styleFrom(
              backgroundColor: ViniiColors.brandGreen,
              foregroundColor: Colors.black,
            ),
            onPressed: () => _openAddEditDialog(context, null),
          ),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: tables.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.table_restaurant_outlined,
                          size: 56, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('No tables in database yet',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      SizedBox(height: 6),
                      Text(
                          'Click "+ Add Table" above to add your first restaurant table.',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                )
              : visible.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.table_restaurant_outlined,
                              size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          const Text('No tables found in this zone',
                              style: TextStyle(color: Colors.grey, fontSize: 16)),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Create a Table'),
                            style: FilledButton.styleFrom(
                              backgroundColor: ViniiColors.brandGreen,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => _openAddEditDialog(context, null),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 235,
                      mainAxisExtent: 182,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: visible.length,
                  itemBuilder: (context, i) => _TableCard(
                    table: visible[i],
                    onOpen: widget.onOpenTable,
                    onStart: widget.onStartOrder,
                    onEdit: (t) => _openAddEditDialog(context, t),
                    onDelete: (t) => _confirmDelete(context, t),
                    onUpdateStatus: _changeStatus,
                  ),
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
  const _TableCard({
    required this.table,
    required this.onOpen,
    required this.onStart,
    required this.onEdit,
    required this.onDelete,
    required this.onUpdateStatus,
  });

  final RestaurantTable table;
  final void Function(RestaurantTable) onOpen;
  final void Function(RestaurantTable) onStart;
  final void Function(RestaurantTable) onEdit;
  final void Function(RestaurantTable) onDelete;
  final void Function(RestaurantTable, TableStatus) onUpdateStatus;

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
          Row(children: [
            if (table.status != TableStatus.cleaning)
              Row(children: [
                const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                Text(
                    table.status == TableStatus.occupied
                        ? ' ${table.guestCount ?? table.seats} Guests'
                        : ' ${table.seats} seats',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ])
            else
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 18, color: Colors.grey),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onSelected: (val) {
                switch (val) {
                  case 'edit':
                    onEdit(table);
                    break;
                  case 'delete':
                    onDelete(table);
                    break;
                  case 'status_available':
                    onUpdateStatus(table, TableStatus.available);
                    break;
                  case 'status_cleaning':
                    onUpdateStatus(table, TableStatus.cleaning);
                    break;
                  case 'status_occupied':
                    onUpdateStatus(table, TableStatus.occupied);
                    break;
                }
              },
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 8),
                      Text('Edit Table'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                if (table.status != TableStatus.available)
                  const PopupMenuItem(
                    value: 'status_available',
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 16, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Set Available'),
                      ],
                    ),
                  ),
                if (table.status != TableStatus.cleaning)
                  const PopupMenuItem(
                    value: 'status_cleaning',
                    child: Row(
                      children: [
                        Icon(Icons.cleaning_services,
                            size: 16, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Set Cleaning'),
                      ],
                    ),
                  ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 16, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete Table',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
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
            TableStatus.cleaning => OutlinedButton(
                onPressed: () => onUpdateStatus(table, TableStatus.available),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.green),
                child: const Text('Mark Ready')),
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
            Text('${table.elapsedMinutes ?? 0} min',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Order Total',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('₹${((table.orderTotalMinor ?? 0) / 100).toStringAsFixed(0)}',
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
          Text('${table.reservedByName ?? "Guest"} · 7:30 PM',
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

class _AddEditTableDialog extends StatefulWidget {
  const _AddEditTableDialog({required this.existing, required this.onSave});
  final RestaurantTable? existing;
  final Future<void> Function(RestaurantTable) onSave;

  @override
  State<_AddEditTableDialog> createState() => _AddEditTableDialogState();
}

class _AddEditTableDialogState extends State<_AddEditTableDialog> {
  late final TextEditingController _labelController;
  late final TextEditingController _seatsController;
  late TableZone _zone;
  late TableStatus _status;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _labelController =
        TextEditingController(text: widget.existing?.label ?? '');
    _seatsController = TextEditingController(
        text: (widget.existing?.seats ?? 4).toString());
    _zone = widget.existing?.zone ?? TableZone.indoor;
    _status = widget.existing?.status ?? TableStatus.available;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return AlertDialog(
      title: Text(isNew ? 'Add New Table' : 'Edit Table ${widget.existing!.label}'),
      content: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _labelController,
              decoration: const InputDecoration(
                labelText: 'Table Label / Number',
                hintText: 'e.g. T19, P1, Booth 4',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _seatsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Seats',
                hintText: 'e.g. 4',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TableZone>(
              value: _zone,
              decoration: const InputDecoration(
                labelText: 'Zone / Area',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: TableZone.indoor, child: Text('Indoor')),
                DropdownMenuItem(
                    value: TableZone.outdoor, child: Text('Outdoor')),
                DropdownMenuItem(
                    value: TableZone.privateDining,
                    child: Text('Private Dining')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _zone = val);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TableStatus>(
              value: _status,
              decoration: const InputDecoration(
                labelText: 'Initial Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: TableStatus.available, child: Text('Available')),
                DropdownMenuItem(
                    value: TableStatus.occupied, child: Text('Occupied')),
                DropdownMenuItem(
                    value: TableStatus.reserved, child: Text('Reserved')),
                DropdownMenuItem(
                    value: TableStatus.cleaning, child: Text('Cleaning')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _status = val);
              },
            ),
          ],
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
                  final label = _labelController.text.trim();
                  if (label.isEmpty) return;
                  final seats = int.tryParse(_seatsController.text.trim()) ?? 4;
                  setState(() => _saving = true);

                  final table = RestaurantTable(
                    id: widget.existing?.id ?? label,
                    label: label,
                    seats: seats,
                    zone: _zone,
                    status: _status,
                    guestCount: widget.existing?.guestCount,
                    elapsedMinutes: widget.existing?.elapsedMinutes,
                    orderTotalMinor: widget.existing?.orderTotalMinor,
                    reservedByName: widget.existing?.reservedByName,
                    reservedAt: widget.existing?.reservedAt,
                  );

                  await widget.onSave(table);
                  if (mounted) Navigator.pop(context);
                },
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(isNew ? 'Create Table' : 'Save Changes'),
        ),
      ],
    );
  }
}

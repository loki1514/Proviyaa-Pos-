import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/drift_menu_store.dart';
import '../data/local_menu_catalog.dart';
import '../data/local_online_orders_catalog.dart';
import '../data/online_orders_store.dart';
import '../data/supabase_online_orders_store.dart';
import '../domain/menu.dart';
import 'vinii_theme.dart';

const _colBadge = 24.0;
const _colOrder = 100.0;
const _colCustomer = 120.0;
const _colItems = 220.0;
const _colAmount = 70.0;
const _colStatus = 110.0;
const _colTime = 70.0;
const _colActions = 190.0;
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
  const OnlineOrdersScreen({
    super.key,
    this.ordersStore,
    this.menuStore,
  });

  final OnlineOrdersStore? ordersStore;
  final DriftMenuStore? menuStore;

  @override
  State<OnlineOrdersScreen> createState() => _OnlineOrdersScreenState();
}

class _OnlineOrdersScreenState extends State<OnlineOrdersScreen> {
  late final OnlineOrdersStore _store =
      widget.ordersStore ?? SupabaseOnlineOrdersStore();

  @override
  void dispose() {
    if (widget.ordersStore == null && _store is SupabaseOnlineOrdersStore) {
      (_store as SupabaseOnlineOrdersStore).dispose();
    }
    super.dispose();
  }

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
    'Archived': ViniiColors.graySolid,
  };

  static const _platformBadgeColors = <String, Color>{
    'Z': ViniiColors.redSolid,
    'S': ViniiColors.amberSolid,
    'W': ViniiColors.greenSolid,
  };

  static const _allStatusTabs = [
    'All',
    'Pending',
    'Accepted',
    'Preparing',
    'Ready',
    'Dispatched',
    'Delivered',
    'Cancelled',
  ];

  bool _matchesPlatform(OnlineOrderRow order) {
    if (_platform == 'All Platforms') {
      return true;
    }
    final platLower = order.platform.toLowerCase();
    if (_platform == 'Zomato') {
      return platLower == 'z' || platLower == 'zomato';
    }
    if (_platform == 'Swiggy') {
      return platLower == 's' || platLower == 'swiggy';
    }
    if (_platform == 'Website') {
      return platLower == 'w' || platLower == 'website';
    }
    return true;
  }

  bool _matchesStatus(OnlineOrderRow order) {
    if (_statusTab == 'All') {
      return true;
    }
    return order.status.toLowerCase() == _statusTab.toLowerCase();
  }

  Future<void> _acceptOrder(OnlineOrderRow row) async {
    try {
      await _store.updateStatus(row.orderId, 'Accepted', 'Prepare');
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order ${row.orderId} Accepted'),
          backgroundColor: ViniiColors.greenSolid,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept order: $e'),
          backgroundColor: ViniiColors.redSolid,
        ),
      );
    }
  }

  Future<void> _rejectOrder(OnlineOrderRow row) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reject Order ${row.orderId}?'),
        content: Text(
          'Rejecting this order from ${row.customer} will permanently delete it from Supabase.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: ViniiColors.redSolid),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Reject & Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _store.deleteOrder(row.orderId);
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order ${row.orderId} Rejected & Deleted'),
            backgroundColor: ViniiColors.redSolid,
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete order: $e'),
            backgroundColor: ViniiColors.redSolid,
          ),
        );
      }
    }
  }

  Future<void> _advanceStage(OnlineOrderRow row) async {
    String nextStatus;
    String nextAction;
    switch (row.status) {
      case 'Pending':
        nextStatus = 'Accepted';
        nextAction = 'Prepare';
        break;
      case 'Accepted':
        nextStatus = 'Preparing';
        nextAction = 'Ready';
        break;
      case 'Preparing':
        nextStatus = 'Ready';
        nextAction = 'Dispatch';
        break;
      case 'Ready':
        nextStatus = 'Dispatched';
        nextAction = 'Complete';
        break;
      case 'Dispatched':
        nextStatus = 'Delivered';
        nextAction = 'Archive';
        break;
      case 'Delivered':
        nextStatus = 'Archived';
        nextAction = 'Archived';
        break;
      case 'Cancelled':
        nextStatus = 'Pending';
        nextAction = 'Accept';
        break;
      default:
        nextStatus = 'Accepted';
        nextAction = 'Prepare';
    }

    try {
      await _store.updateStatus(row.orderId, nextStatus, nextAction);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order ${row.orderId} moved to $nextStatus'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update order: $e'),
          backgroundColor: ViniiColors.redSolid,
        ),
      );
    }
  }

  Future<void> _showNewOrderDialog() async {
    final formKey = GlobalKey<FormState>();
    String platform = 'Z';
    String customer = '';
    final selectedQuantities = <String, int>{}; // itemId -> quantity
    String searchQuery = '';
    bool hasAttemptedSubmit = false;

    // Load available menu items from menuStore or catalog fallback
    List<MenuItem> availableItems = [];
    if (widget.menuStore != null) {
      try {
        final items = await widget.menuStore!.getAllItems();
        availableItems = items.where((i) => i.available).toList();
      } catch (_) {}
    }
    if (availableItems.isEmpty) {
      availableItems =
          LocalMenuCatalog.items.where((i) => i.available).toList();
    }
    final itemMap = {for (final i in availableItems) i.id: i};

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          // Compute POS billing amounts automatically
          int subtotalMinor = 0;
          for (final entry in selectedQuantities.entries) {
            final item = itemMap[entry.key];
            if (item != null) {
              subtotalMinor += item.priceMinor * entry.value;
            }
          }
          final gstMinor = (subtotalMinor * 0.05).round(); // 5% GST POS rule
          final totalMinor = subtotalMinor + gstMinor;

          final filteredItems = availableItems
              .where((i) =>
                  i.name.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();

          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.add_shopping_cart,
                    color: ViniiColors.greenSolid, size: 22),
                SizedBox(width: 8),
                Text('New Online Order',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            content: SizedBox(
              width: 520,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Platform Selector
                      DropdownButtonFormField<String>(
                        initialValue: platform,
                        decoration: const InputDecoration(
                          labelText: 'Platform',
                          isDense: true,
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'Z', child: Text('Zomato (Z)')),
                          DropdownMenuItem(
                              value: 'S', child: Text('Swiggy (S)')),
                          DropdownMenuItem(
                              value: 'W', child: Text('Website (W)')),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() => platform = val);
                          }
                        },
                      ),
                      const SizedBox(height: 12),

                      // Customer Name
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Customer Name',
                          hintText: 'e.g. Priya Verma',
                          isDense: true,
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Customer name is required'
                            : null,
                        onSaved: (v) => customer = v?.trim() ?? '',
                      ),
                      const SizedBox(height: 16),

                      // Multi-Select Items Section (HTML select multiple style)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Items (Multi-Select Menu):',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                          if (selectedQuantities.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: ViniiColors.greenTint,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${selectedQuantities.length} items chosen',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: ViniiColors.greenSolid,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Search filter bar
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          prefixIcon: const Icon(Icons.search, size: 16),
                          hintText:
                              'Filter items... (e.g. Biryani, Naan, Paneer)',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        onChanged: (val) =>
                            setDialogState(() => searchQuery = val.trim()),
                      ),
                      const SizedBox(height: 6),

                      // Multi-select scrollable box
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: ViniiColors.lightBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: (hasAttemptedSubmit &&
                                    selectedQuantities.isEmpty)
                                ? ViniiColors.redSolid
                                : ViniiColors.lightBorder,
                          ),
                        ),
                        child: filteredItems.isEmpty
                            ? const Center(
                                child: Text('No menu items match filter',
                                    style: TextStyle(
                                        color: ViniiColors.textMutedLight,
                                        fontSize: 12)),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: filteredItems.length,
                                separatorBuilder: (_, __) => const Divider(
                                    height: 1, color: ViniiColors.lightBorder),
                                itemBuilder: (ctx, i) {
                                  final item = filteredItems[i];
                                  final isSelected =
                                      selectedQuantities.containsKey(item.id);
                                  final qty = selectedQuantities[item.id] ?? 0;

                                  return InkWell(
                                    onTap: () {
                                      setDialogState(() {
                                        if (isSelected) {
                                          selectedQuantities.remove(item.id);
                                        } else {
                                          selectedQuantities[item.id] = 1;
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: isSelected
                                          ? ViniiColors.greenTint
                                          : Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Checkbox(
                                              value: isSelected,
                                              activeColor:
                                                  ViniiColors.brandGreen,
                                              checkColor: Colors.black,
                                              onChanged: (checked) {
                                                setDialogState(() {
                                                  if (checked == true) {
                                                    selectedQuantities[
                                                        item.id] = 1;
                                                  } else {
                                                    selectedQuantities
                                                        .remove(item.id);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          // Veg / Non-Veg indicator
                                          Container(
                                            width: 12,
                                            height: 12,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: item.isVeg
                                                    ? ViniiColors.greenSolid
                                                    : ViniiColors.redSolid,
                                              ),
                                            ),
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: item.isVeg
                                                    ? ViniiColors.greenSolid
                                                    : ViniiColors.redSolid,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '₹${(item.priceMinor / 100).toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (isSelected) ...[
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () {
                                                setDialogState(() {
                                                  if (qty <= 1) {
                                                    selectedQuantities
                                                        .remove(item.id);
                                                  } else {
                                                    selectedQuantities[
                                                        item.id] = qty - 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: ViniiColors
                                                          .lightBorder),
                                                ),
                                                child: const Icon(Icons.remove,
                                                    size: 14,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              child: Text(
                                                '$qty',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setDialogState(() {
                                                  selectedQuantities[item.id] =
                                                      qty + 1;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: ViniiColors
                                                          .lightBorder),
                                                ),
                                                child: const Icon(Icons.add,
                                                    size: 14,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      if (hasAttemptedSubmit && selectedQuantities.isEmpty) ...[
                        const SizedBox(height: 4),
                        const Text(
                          'Please select at least one item from the menu.',
                          style: TextStyle(
                              color: ViniiColors.redSolid, fontSize: 12),
                        ),
                      ],
                      const SizedBox(height: 12),

                      // Selected Items Preview Chips
                      if (selectedQuantities.isNotEmpty) ...[
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            for (final entry in selectedQuantities.entries)
                              Chip(
                                visualDensity: VisualDensity.compact,
                                padding: const EdgeInsets.all(2),
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                label: Text(
                                  '${entry.value}x ${itemMap[entry.key]?.name ?? entry.key}',
                                  style: const TextStyle(fontSize: 11.5),
                                ),
                                deleteIcon: const Icon(Icons.close, size: 14),
                                onDeleted: () {
                                  setDialogState(() {
                                    selectedQuantities.remove(entry.key);
                                  });
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],

                      // POS Billing & GST Auto-Calculation Card
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ViniiColors.grayTint,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ViniiColors.lightBorder),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Items Subtotal:',
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: ViniiColors.textMutedLight)),
                                Text(
                                    '₹${(subtotalMinor / 100).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('GST (5% POS Rules):',
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: ViniiColors.textMutedLight)),
                                Text('₹${(gstMinor / 100).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const Divider(
                                height: 14, color: ViniiColors.lightBorder),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Amount (Auto):',
                                    style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  '₹${(totalMinor / 100).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ViniiColors.greenSolid,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: ViniiColors.brandGreen),
                onPressed: () async {
                  setDialogState(() => hasAttemptedSubmit = true);
                  if (formKey.currentState?.validate() ?? false) {
                    if (selectedQuantities.isEmpty) {
                      return;
                    }
                    formKey.currentState?.save();

                    final prefix = platform == 'Z'
                        ? 'ZOM'
                        : platform == 'S'
                            ? 'SWG'
                            : 'WEB';
                    final randomId =
                        '#$prefix-${Random().nextInt(9000) + 1000}';
                    final now = DateTime.now();
                    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
                    final minute = now.minute.toString().padLeft(2, '0');
                    final ampm = now.hour >= 12 ? 'PM' : 'AM';

                    final itemsLabel = selectedQuantities.entries
                        .map((e) =>
                            '${e.value}x ${itemMap[e.key]?.name ?? e.key}')
                        .join(', ');

                    final newOrder = OnlineOrderRow(
                      orderId: randomId,
                      platform: platform,
                      customer: customer,
                      itemsLabel: itemsLabel,
                      amountMinor:
                          totalMinor, // Exact auto-calculated POS amount
                      status: 'Pending',
                      time: '$hour:$minute $ampm',
                      actionLabel: 'Accept',
                    );

                    try {
                      await _store.insertOrder(newOrder);
                      if (ctx.mounted) {
                        Navigator.of(ctx).pop();
                      }
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Created Order $randomId (Total: ₹${(totalMinor / 100).toStringAsFixed(2)})'),
                            backgroundColor: ViniiColors.brandGreen,
                          ),
                        );
                      }
                    } catch (err) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to create order: $err'),
                            backgroundColor: ViniiColors.redSolid,
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text('Create Order',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _copyMigrationSql(BuildContext context) {
    const migrationSql = '''
CREATE TABLE IF NOT EXISTS public.online_orders (
  order_id TEXT PRIMARY KEY,
  platform TEXT NOT NULL,
  customer TEXT NOT NULL,
  items_label TEXT NOT NULL,
  amount_minor BIGINT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Pending',
  action_label TEXT NOT NULL DEFAULT 'Accept',
  time TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
ALTER TABLE public.online_orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow anon select on online_orders" ON public.online_orders FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "Allow anon insert on online_orders" ON public.online_orders FOR INSERT TO anon, authenticated WITH CHECK (true);
CREATE POLICY "Allow anon update on online_orders" ON public.online_orders FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on online_orders" ON public.online_orders FOR DELETE TO anon, authenticated USING (true);
ALTER PUBLICATION supabase_realtime ADD TABLE public.online_orders;
''';
    Clipboard.setData(const ClipboardData(text: migrationSql));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'SQL Migration copied to clipboard! Paste into Supabase SQL Editor.'),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OnlineOrdersState>(
        stream: _store.watchState(),
        builder: (context, snapshot) {
          final state = snapshot.data ?? const OnlineOrdersState.loading();

          // Calculate counts strictly from the actual orders in Supabase
          final allOrders = state.orders;
          final filtered =
              allOrders.where(_matchesPlatform).where(_matchesStatus).toList();

          final statusCounts = <String, int>{
            'All': allOrders.length,
            for (final st in _allStatusTabs.skip(1))
              st: allOrders
                  .where((o) => o.status.toLowerCase() == st.toLowerCase())
                  .length,
          };

          return Container(
            color: ViniiColors.lightPageBg,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      const Text(
                        'Online Orders',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: ViniiColors.greenTint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          state.isLoading
                              ? 'Loading...'
                              : '${allOrders.length} orders today',
                          style: const TextStyle(
                            color: ViniiColors.greenSolid,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Supabase Status Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: state.isError
                              ? ViniiColors.redTint
                              : (state.isLoading
                                  ? ViniiColors.grayTint
                                  : ViniiColors.greenTint),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: state.isError
                                ? ViniiColors.redSolid.withValues(alpha: 0.3)
                                : (state.isLoading
                                    ? ViniiColors.graySolid
                                        .withValues(alpha: 0.3)
                                    : ViniiColors.greenSolid
                                        .withValues(alpha: 0.3)),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.isLoading) ...[
                              const SizedBox(
                                width: 12,
                                height: 12,
                                child:
                                    CircularProgressIndicator(strokeWidth: 1.5),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Syncing...',
                                style: TextStyle(
                                  color: ViniiColors.sidebarDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ] else if (state.isError) ...[
                              const Icon(Icons.error_outline,
                                  color: ViniiColors.redSolid, size: 14),
                              const SizedBox(width: 6),
                              const Text(
                                'Sync Error',
                                style: TextStyle(
                                  color: ViniiColors.redSolid,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ] else ...[
                              const Icon(Icons.cloud_done,
                                  color: ViniiColors.greenSolid, size: 14),
                              const SizedBox(width: 6),
                              const Text(
                                'Supabase Live',
                                style: TextStyle(
                                  color: ViniiColors.greenSolid,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: ViniiColors.brandGreen,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'New Order',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: _showNewOrderDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Platform Chips
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
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) => setState(() => _platform = p),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Status Tabs with Live Dynamic Counts from Supabase
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final entry in statusCounts.entries)
                        ChoiceChip(
                          label: Text(state.isLoading
                              ? '${entry.key}  -'
                              : '${entry.key}  ${entry.value}'),
                          selected: _statusTab == entry.key,
                          selectedColor: ViniiColors.brandGreen,
                          labelStyle: TextStyle(
                            color:
                                _statusTab == entry.key ? Colors.black : null,
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) =>
                              setState(() => _statusTab = entry.key),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Main Content: Skeleton, Error, Empty, or Data Table
                  Expanded(
                    child: _buildBody(state, filtered),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildBody(OnlineOrdersState state, List<OnlineOrderRow> filtered) {
    // 1. Loading State: Display Skeleton Loader (Never show "No orders found" while loading)
    if (state.isLoading) {
      return const _OrdersSkeletonLoader();
    }

    // 2. Error State: Display Error message with Retry and Copy Migration SQL options
    if (state.isError) {
      return _OrdersErrorView(
        message: state.errorMessage ??
            'Failed to connect to Supabase. Check your configuration.',
        onRetry: () => _store.refresh(),
        onCopySql: () => _copyMigrationSql(context),
      );
    }

    // 3. Success State: Empty Supabase database
    if (state.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: ViniiColors.lightBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ViniiColors.lightBorder),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: 56,
                color: ViniiColors.graySolid,
              ),
              const SizedBox(height: 16),
              const Text(
                'No orders found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ViniiColors.sidebarDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'There are currently no online orders in Supabase.',
                style: TextStyle(
                  fontSize: 13,
                  color: ViniiColors.textMutedLight,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: ViniiColors.brandGreen,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create First Order',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _showNewOrderDialog,
              ),
            ],
          ),
        ),
      );
    }

    // 4. Success State: Filtered subset is empty
    if (filtered.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: ViniiColors.lightBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ViniiColors.lightBorder),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_alt_off_outlined,
                  size: 48, color: ViniiColors.graySolid),
              const SizedBox(height: 12),
              Text(
                'No $_statusTab orders for $_platform',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ViniiColors.sidebarDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Try selecting "All" or a different platform.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: ViniiColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 5. Success State: Display Actual Orders Table from Supabase
    return LayoutBuilder(
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
              border: Border.all(color: ViniiColors.lightBorder),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: ViniiColors.lightBorder,
              ),
              itemBuilder: (context, i) {
                final row = filtered[i];
                final platColor =
                    _platformBadgeColors[row.platform.toUpperCase()] ??
                        ViniiColors.blueSolid;
                final statColor =
                    _statusColors[row.status] ?? ViniiColors.graySolid;

                return _OnlineOrderRowWidget(
                  row: row,
                  statusColor: statColor,
                  platformColor: platColor,
                  onAccept: () => _acceptOrder(row),
                  onReject: () => _rejectOrder(row),
                  onAdvanceStage: () => _advanceStage(row),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _OnlineOrderRowWidget extends StatelessWidget {
  const _OnlineOrderRowWidget({
    required this.row,
    required this.statusColor,
    required this.platformColor,
    required this.onAccept,
    required this.onReject,
    required this.onAdvanceStage,
  });

  final OnlineOrderRow row;
  final Color statusColor;
  final Color platformColor;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onAdvanceStage;

  bool get _isPending => row.status == 'Pending';

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: _colBadge,
              height: _colBadge,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: platformColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                row.platform.isNotEmpty ? row.platform[0].toUpperCase() : 'O',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: _colOrder,
              child: Text(
                row.orderId,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
            SizedBox(
              width: _colCustomer,
              child: Text(
                row.customer,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            SizedBox(
              width: _colItems,
              child: Text(
                row.itemsLabel,
                style: const TextStyle(
                    fontSize: 12.5, color: ViniiColors.textMutedLight),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: _colAmount,
              child: Text(
                '₹${(row.amountMinor / 100).toStringAsFixed(0)}',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: _colStatus,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    row.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _colTime,
              child: Text(
                row.time,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: ViniiColors.textMutedLight),
              ),
            ),
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
                      if (_isPending) ...[
                        TextButton(
                          onPressed: onReject,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Text(
                            'Reject',
                            style: TextStyle(
                              color: ViniiColors.redSolid,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        FilledButton(
                          onPressed: onAccept,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: ViniiColors.brandGreen,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ),
                      ] else ...[
                        TextButton(
                          onPressed: onReject,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: ViniiColors.redSolid,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        FilledButton(
                          onPressed: onAdvanceStage,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: ViniiColors.grayTint,
                            foregroundColor: ViniiColors.textPrimaryLight,
                          ),
                          child: Text(
                            row.actionLabel,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _OrdersSkeletonLoader extends StatelessWidget {
  const _OrdersSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ViniiColors.lightBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ViniiColors.lightBorder),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12),
                Text(
                  'Loading orders from Supabase...',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ViniiColors.textMutedLight,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: ViniiColors.lightBorder),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 6,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: ViniiColors.lightBorder),
              itemBuilder: (context, i) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    _skeletonBox(24, 24, borderRadius: 6),
                    const SizedBox(width: 12),
                    _skeletonBox(80, 14),
                    const SizedBox(width: 20),
                    _skeletonBox(100, 14),
                    const SizedBox(width: 20),
                    Expanded(child: _skeletonBox(180, 14)),
                    const SizedBox(width: 20),
                    _skeletonBox(50, 14),
                    const SizedBox(width: 20),
                    _skeletonBox(70, 20, borderRadius: 10),
                    const SizedBox(width: 20),
                    _skeletonBox(50, 14),
                    const SizedBox(width: 20),
                    _skeletonBox(100, 26, borderRadius: 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeletonBox(double width, double height, {double borderRadius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECEF),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class _OrdersErrorView extends StatelessWidget {
  const _OrdersErrorView({
    required this.message,
    required this.onRetry,
    required this.onCopySql,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onCopySql;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ViniiColors.lightBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ViniiColors.lightBorder),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off,
                size: 54,
                color: ViniiColors.redSolid,
              ),
              const SizedBox(height: 16),
              const Text(
                'Supabase Connection Error',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: ViniiColors.textMutedLight,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: ViniiColors.brandGreen,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Retry Connection',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: onCopySql,
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Copy SQL Migration'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

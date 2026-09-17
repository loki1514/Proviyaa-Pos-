// Rebuilt 1:1 from v1/POS-MAIN-DEFAULT.png and v1/POS-MAIN-V3.png
// (light/dark pair) — see Q02 in docs/DECISIONS-AND-QUESTIONS.txt.
// "Save & Hold" is not wired to a real screen yet (Hold Orders isn't
// rebuilt). "Send KOT" and "Proceed to Pay" both really save the order
// through the existing, tested application services — they differ only
// in what happens next (stay here vs. go straight to Payment), matching
// the PRD's own two models: pay-first takeaway and pay-later table
// service.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../application/kitchen_service.dart';
import '../application/order_service.dart';
import '../application/payment_service.dart';
import '../data/drift_all_orders_store.dart';
import '../data/drift_menu_store.dart';
import '../data/drift_table_store.dart';
import '../data/local_all_orders_catalog.dart';
import '../domain/menu.dart';
import '../domain/order.dart';
import '../domain/restaurant_table.dart';
import 'payment_screen.dart';
import 'vinii_theme.dart';

class PosOrderScreen extends StatefulWidget {
  const PosOrderScreen(
      {super.key,
      required this.orderService,
      required this.kitchenService,
      required this.paymentService,
      required this.locationId,
      this.allOrdersStore,
      this.tableStore,
      this.menuStore,
      this.table});
  final OrderService orderService;
  final KitchenService kitchenService;
  final PaymentService paymentService;
  final DriftAllOrdersStore? allOrdersStore;
  final DriftTableStore? tableStore;
  final DriftMenuStore? menuStore;
  final String locationId;

  /// Arrived here from a Tables card — dine-in against this table.
  /// Null means takeaway (arrived from "+ New Order" with no table).
  final RestaurantTable? table;

  @override
  State<PosOrderScreen> createState() => _PosOrderScreenState();
}

class _PosOrderScreenState extends State<PosOrderScreen> {
  final _cart = <String, int>{}; // itemId -> quantity
  final Map<String, MenuItem> _knownItems = {};
  String _categoryId = 'all';
  String _searchQuery = '';
  late OrderType _orderType;
  RestaurantTable? _selectedTable;
  List<RestaurantTable> _availableTables = [];
  bool _saving = false;
  Stream<List<MenuCategory>>? _categoriesStream;
  Stream<List<MenuItem>>? _itemsStream;

  @override
  void initState() {
    super.initState();
    _selectedTable = widget.table;
    _orderType = widget.table != null ? OrderType.dineIn : OrderType.takeaway;
    _initStreams();
    if (widget.tableStore != null) {
      widget.tableStore!.getAllTables().then((tables) {
        if (mounted) {
          setState(() {
            _availableTables = tables;
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant PosOrderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menuStore != widget.menuStore) {
      _initStreams();
    }
  }

  void _initStreams() {
    _categoriesStream =
        widget.menuStore?.watchCategories() ?? Stream.value(const []);
    _itemsStream = widget.menuStore?.watchItems() ?? Stream.value(const []);
  }

  int get _subtotalMinor => _cart.entries.fold(0, (sum, e) {
        final item = _knownItems[e.key];
        return sum + (item?.priceMinor ?? 0) * e.value;
      });

  int get _taxMinor =>
      (_subtotalMinor * 0.05).round(); // GST 5%, matches reference
  int get _totalMinor => _subtotalMinor + _taxMinor;

  void _addItem(MenuItem item) {
    if (!item.available) return;
    _knownItems[item.id] = item;
    setState(() => _cart.update(item.id, (q) => q + 1, ifAbsent: () => 1));
  }

  void _removeItem(MenuItem item) => setState(() {
        final q = _cart[item.id];
        if (q == null) return;
        if (q <= 1) {
          _cart.remove(item.id);
        } else {
          _cart[item.id] = q - 1;
        }
      });

  List<OrderLine> _lines() => _cart.entries.map((e) {
        final item = _knownItems[e.key];
        return OrderLine(
            itemId: e.key,
            name: item?.name ?? 'Item ${e.key}',
            unitMinor: item?.priceMinor ?? 0,
            quantity: e.value);
      }).toList(growable: false);

  Future<LocalOrder?> _saveOrderAndKot() async {
    if (_cart.isEmpty) return null;
    setState(() => _saving = true);
    try {
      final order = await widget.orderService
          .saveCashOrder(
              clientOrderId: const Uuid().v4(),
              locationId: widget.locationId,
              orderType: _orderType,
              tableLabel: _selectedTable?.label,
              lines: _lines())
          // A local-database write should never take long; if the
          // platform's storage backend is stuck (e.g. a web build whose
          // WASM/OPFS worker never resolves — see docs/JOURNAL.md), a
          // silent infinite "Saving..." spinner is worse than a clear
          // failure the user can retry.
          .timeout(const Duration(seconds: 8));
      await widget.kitchenService
          .createTicketForOrder(order)
          .timeout(const Duration(seconds: 8));
      return order;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e is TimeoutException
                ? 'Saving is taking too long — the local database may be unavailable. Please try again.'
                : 'Could not save the order: $e')));
      }
      return null;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _sendKot() async {
    final order = await _saveOrderAndKot();
    if (order == null || !mounted) return;
    setState(_cart.clear);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('KOT sent to kitchen.')));
  }

  Future<void> _proceedToPay() async {
    final order = await _saveOrderAndKot();
    if (order == null || !mounted) return;
    setState(_cart.clear);
    final completed = await Navigator.of(context).push<bool>(MaterialPageRoute(
        builder: (_) => PaymentScreen(
            order: order,
            paymentService: widget.paymentService,
            allOrdersStore: widget.allOrdersStore,
            orderNumber:
                (DateTime.now().millisecondsSinceEpoch % 10000).toString())));
    if (completed == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveAndHold() async {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Warning: No items added. Please add items to the order before saving.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (_orderType == OrderType.dineIn && _selectedTable == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Warning: Please select a table for Dine In orders.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final orderNumber = (DateTime.now().millisecondsSinceEpoch % 10000)
          .toString()
          .padLeft(4, '0');

      final order = await widget.orderService
          .saveCashOrder(
              clientOrderId: const Uuid().v4(),
              locationId: widget.locationId,
              orderType: _orderType,
              tableLabel: _selectedTable?.label,
              lines: _lines())
          .timeout(const Duration(seconds: 8));

      try {
        await widget.kitchenService
            .createTicketForOrder(order)
            .timeout(const Duration(seconds: 8));
      } catch (_) {}

      if (widget.allOrdersStore != null) {
        final itemsCount = _cart.values.fold<int>(0, (sum, q) => sum + q);
        final itemsDesc = itemsCount == 1 ? '1 item' : '$itemsCount items';
        final isDineIn = _orderType == OrderType.dineIn;
        final tableOrCust = isDineIn
            ? (_selectedTable != null
                ? 'Table ${_selectedTable!.label}'
                : 'Dine In')
            : 'Walk-in Customer';

        await widget.allOrdersStore!.insertOrder(
          AllOrdersRow(
            orderId: '#$orderNumber',
            type: isDineIn ? 'Dine In' : 'Takeaway',
            source: 'Walk-in',
            tableOrCustomer: tableOrCust,
            itemsLabel: itemsDesc,
            amountMinor: _totalMinor,
            status: 'Hold',
            time: 'Just now',
          ),
        );
      }

      if (_orderType == OrderType.dineIn &&
          _selectedTable != null &&
          widget.tableStore != null) {
        final currentTable = _selectedTable!;
        await widget.tableStore!.updateTable(
          RestaurantTable(
            id: currentTable.id,
            label: currentTable.label,
            seats: currentTable.seats,
            zone: currentTable.zone,
            status: TableStatus.occupied,
            guestCount: currentTable.guestCount ?? currentTable.seats,
            elapsedMinutes: 0,
            orderTotalMinor: _totalMinor,
            reservedByName: currentTable.reservedByName,
            reservedAt: currentTable.reservedAt,
          ),
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Order #$orderNumber saved on Hold${_selectedTable != null ? " for Table ${_selectedTable!.label}" : ""}.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is TimeoutException
                ? 'Saving is taking too long — the local database may be unavailable. Please try again.'
                : 'Could not save the held order: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _selectedTable != null
        ? '${_selectedTable!.label} — New Order'
        : 'New Order';
    return StreamBuilder<List<MenuCategory>>(
      stream: _categoriesStream,
      builder: (context, catSnapshot) {
        final categories = catSnapshot.data ?? [];
        return StreamBuilder<List<MenuItem>>(
          stream: _itemsStream,
          builder: (context, itemSnapshot) {
            final allItems = itemSnapshot.data ?? [];
            for (final i in allItems) {
              _knownItems[i.id] = i;
            }

            final itemsCountPerCategory = <String, int>{};
            for (final item in allItems) {
              itemsCountPerCategory[item.categoryId] =
                  (itemsCountPerCategory[item.categoryId] ?? 0) + 1;
            }

            final categoriesWithCounts = categories
                .map((c) => c.copyWith(
                    itemCount: itemsCountPerCategory[c.id] ?? 0))
                .toList();

            final effectiveCategoryId = (_categoryId == 'all' ||
                    categories.any((c) => c.id == _categoryId))
                ? _categoryId
                : 'all';

            final selectedCategoryName = effectiveCategoryId == 'all'
                ? 'All Items'
                : (categories
                        .where((c) => c.id == effectiveCategoryId)
                        .map((c) => c.name)
                        .firstOrNull ??
                    'Category');

            final filteredItems = allItems.where((i) {
              final matchesCategory = effectiveCategoryId == 'all' ||
                  i.categoryId == effectiveCategoryId;
              final matchesSearch = _searchQuery.isEmpty ||
                  i.name.toLowerCase().contains(_searchQuery);
              return matchesCategory && matchesSearch;
            }).toList();

            return Scaffold(
              appBar: AppBar(title: Text(title)),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CategorySidebar(
                    categories: categoriesWithCounts,
                    totalItemsCount: allItems.length,
                    selected: effectiveCategoryId,
                    onSelect: (id) => setState(() => _categoryId = id),
                  ),
                  Expanded(
                    flex: 3,
                    child: _ItemGrid(
                      categoryName: selectedCategoryName,
                      items: filteredItems,
                      hasCategories: categories.isNotEmpty,
                      searchQuery: _searchQuery,
                      onSearchChanged: (q) =>
                          setState(() => _searchQuery = q.trim().toLowerCase()),
                      onTap: _addItem,
                    ),
                  ),
                  SizedBox(
                    width: 320,
                    child: _OrderPanel(
                      table: widget.table,
                      selectedTable: _selectedTable,
                      availableTables: _availableTables,
                      onTableChanged: (t) => setState(() => _selectedTable = t),
                      orderType: _orderType,
                      onOrderTypeChanged: widget.table == null
                          ? (t) => setState(() => _orderType = t)
                          : null,
                      cart: _cart,
                      knownItems: _knownItems,
                      subtotalMinor: _subtotalMinor,
                      taxMinor: _taxMinor,
                      totalMinor: _totalMinor,
                      onRemove: _removeItem,
                      onAdd: _addItem,
                      saving: _saving,
                      onProceedToPay: _saving ? null : _proceedToPay,
                      onSendKot: _sendKot,
                      onSaveHold: _saveAndHold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _CategorySidebar extends StatelessWidget {
  const _CategorySidebar({
    required this.categories,
    required this.totalItemsCount,
    required this.selected,
    required this.onSelect,
  });
  final List<MenuCategory> categories;
  final int totalItemsCount;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 195,
      child: categories.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No categories in database',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'CATEGORIES',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                _CategoryTile(
                  label: 'All Items',
                  count: totalItemsCount,
                  selected: selected == 'all',
                  onTap: () => onSelect('all'),
                ),
                for (final c in categories)
                  _CategoryTile(
                    label: c.name,
                    count: c.itemCount,
                    selected: selected == c.id,
                    onTap: () => onSelect(c.id),
                  ),
              ],
            ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: selected ? ViniiColors.greenTint : null,
          border: selected ? Border.all(color: ViniiColors.brandGreen) : null,
          borderRadius: BorderRadius.circular(8)),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: Icon(Icons.star_border,
              size: 18, color: selected ? ViniiColors.brandGreen : Colors.grey),
          title: Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? ViniiColors.brandGreen : null)),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: selected
                  ? ViniiColors.brandGreen.withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: selected ? ViniiColors.brandGreen : Colors.grey.shade700,
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ItemGrid extends StatelessWidget {
  const _ItemGrid({
    required this.categoryName,
    required this.items,
    required this.hasCategories,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onTap,
  });
  final String categoryName;
  final List<MenuItem> items;
  final bool hasCategories;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final void Function(MenuItem) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$categoryName  ·  ${items.length} items',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                width: 220,
                height: 36,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 16),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                  ),
                  onChanged: onSearchChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          searchQuery.isNotEmpty
                              ? Icons.search_off
                              : (!hasCategories
                                  ? Icons.restaurant_menu
                                  : Icons.fastfood_outlined),
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          searchQuery.isNotEmpty
                              ? 'No items matching "$searchQuery"'
                              : (!hasCategories
                                  ? 'No categories or items in database yet'
                                  : 'No items in this category'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          searchQuery.isNotEmpty
                              ? 'Try searching with a different keyword.'
                              : 'Add categories and items in Menu Management to start taking orders.',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      mainAxisExtent: 130,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, i) =>
                        _ItemCard(item: items[i], onTap: onTap),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.onTap});
  final MenuItem item;
  final void Function(MenuItem) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.available ? () => onTap(item) : null,
      borderRadius: BorderRadius.circular(10),
      child: Opacity(
        opacity: item.available ? 1 : 0.55,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (item.isBestseller)
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: ViniiColors.amberTint,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text('Bestseller',
                      style: TextStyle(
                          fontSize: 10, color: ViniiColors.amberSolid))),
            const Spacer(),
            Row(children: [
              Icon(Icons.circle,
                  size: 8,
                  color: item.isVeg
                      ? ViniiColors.greenSolid
                      : ViniiColors.redSolid),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
            ]),
            const SizedBox(height: 2),
            Text('₹${(item.priceMinor / 100).toStringAsFixed(item.priceMinor % 100 == 0 ? 0 : 2)}'),
            const SizedBox(height: 2),
            Row(children: [
              Icon(Icons.circle,
                  size: 6,
                  color: item.available
                      ? ViniiColors.greenSolid
                      : ViniiColors.redSolid),
              const SizedBox(width: 4),
              Expanded(
                  child: Text(
                      item.available
                          ? 'Available'
                          : (item.unavailableReason ?? 'Unavailable'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          color: item.available
                              ? ViniiColors.greenSolid
                              : ViniiColors.redSolid))),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _OrderPanel extends StatelessWidget {
  const _OrderPanel(
      {required this.table,
      this.selectedTable,
      this.availableTables = const [],
      this.onTableChanged,
      required this.orderType,
      required this.onOrderTypeChanged,
      required this.cart,
      required this.knownItems,
      required this.subtotalMinor,
      required this.taxMinor,
      required this.totalMinor,
      required this.onRemove,
      required this.onAdd,
      required this.saving,
      required this.onProceedToPay,
      required this.onSendKot,
      required this.onSaveHold});

  final RestaurantTable? table;
  final RestaurantTable? selectedTable;
  final List<RestaurantTable> availableTables;
  final ValueChanged<RestaurantTable?>? onTableChanged;
  final OrderType orderType;
  final ValueChanged<OrderType>? onOrderTypeChanged;
  final Map<String, int> cart;
  final Map<String, MenuItem> knownItems;
  final int subtotalMinor, taxMinor, totalMinor;
  final void Function(MenuItem) onRemove, onAdd;
  final bool saving;
  final VoidCallback? onProceedToPay;
  final VoidCallback onSendKot, onSaveHold;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border:
              Border(left: BorderSide(color: Theme.of(context).dividerColor))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Current Order', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(spacing: 6, runSpacing: 6, children: [
            _OrderTypePill(
                label: 'Dine In',
                selected: orderType == OrderType.dineIn,
                onTap: onOrderTypeChanged == null
                    ? null
                    : () => onOrderTypeChanged!(OrderType.dineIn)),
            _OrderTypePill(
                label: 'Takeaway',
                selected: orderType == OrderType.takeaway,
                onTap: onOrderTypeChanged == null
                    ? null
                    : () => onOrderTypeChanged!(OrderType.takeaway)),
          ]),
          if (table != null) ...[
            const SizedBox(height: 8),
            Text(
                '${table!.label}  ·  ${table!.guestCount ?? table!.seats} Guests',
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ] else if (orderType == OrderType.dineIn) ...[
            const SizedBox(height: 8),
            if (availableTables.isEmpty)
              const Text('No tables in database yet',
                  style: TextStyle(fontSize: 12, color: Colors.orange))
            else
              DropdownButtonFormField<RestaurantTable>(
                value: selectedTable,
                isDense: true,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Select Table',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                hint:
                    const Text('Choose table', style: TextStyle(fontSize: 13)),
                items: [
                  for (final t in availableTables)
                    DropdownMenuItem(
                      value: t,
                      child: Text(
                        '${t.label} (${t.seats} seats · ${t.status.name})',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                ],
                onChanged: onTableChanged,
              ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text('No items yet — tap a menu item to add it.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey)))
                : ListView(
                    children: [
                      for (final entry in cart.entries) ...[
                        _OrderLineTile(
                          item: knownItems[entry.key] ??
                              MenuItem(
                                id: entry.key,
                                categoryId: '',
                                name: 'Item ${entry.key}',
                                priceMinor: 0,
                                isVeg: true,
                              ),
                          quantity: entry.value,
                          onAdd: onAdd,
                          onRemove: onRemove,
                        ),
                      ],
                    ],
                  ),
          ),
          const Divider(),
          _TotalsRow(label: 'Subtotal', valueMinor: subtotalMinor),
          _TotalsRow(label: 'Tax (GST 5%)', valueMinor: taxMinor),
          const Divider(),
          _TotalsRow(label: 'TOTAL', valueMinor: totalMinor, bold: true),
          const SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: cart.isEmpty ? null : onProceedToPay,
                  // (onProceedToPay is already null while saving —
                  // the caller passes `_saving ? null : _proceedToPay`.)
                  style: FilledButton.styleFrom(
                      backgroundColor: ViniiColors.brandGreen),
                  child: const Text('Proceed to Pay',
                      style: TextStyle(color: Colors.black)))),
          const SizedBox(height: 8),
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: cart.isEmpty || saving ? null : onSendKot,
                  child: Text(saving ? 'Saving…' : 'Send KOT'))),
          const SizedBox(height: 8),
          Center(
              child: TextButton(
                  onPressed: saving ? null : onSaveHold,
                  child: const Text('Save & Hold'))),
        ]),
      ),
    );
  }
}

class _OrderTypePill extends StatelessWidget {
  const _OrderTypePill(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: selected,
      selectedColor: ViniiColors.brandGreen,
      labelStyle: TextStyle(color: selected ? Colors.black : null),
      onSelected: onTap == null ? null : (_) => onTap!());
}

class _OrderLineTile extends StatelessWidget {
  const _OrderLineTile(
      {required this.item,
      required this.quantity,
      required this.onAdd,
      required this.onRemove});
  final MenuItem item;
  final int quantity;
  final void Function(MenuItem) onAdd, onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Expanded(
            child:
                Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis)),
        IconButton(
            iconSize: 18,
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => onRemove(item)),
        Text('$quantity'),
        IconButton(
            iconSize: 18,
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => onAdd(item)),
        SizedBox(
            width: 56,
            child: Text(
                '₹${(item.priceMinor * quantity / 100).toStringAsFixed(item.priceMinor % 100 == 0 ? 0 : 2)}',
                textAlign: TextAlign.right)),
      ]),
    );
  }
}

class _TotalsRow extends StatelessWidget {
  const _TotalsRow(
      {required this.label, required this.valueMinor, this.bold = false});
  final String label;
  final int valueMinor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style =
        TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: style),
        Text('₹${(valueMinor / 100).toStringAsFixed(2)}', style: style),
      ]),
    );
  }
}

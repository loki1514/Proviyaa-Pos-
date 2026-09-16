// Rebuilt 1:1 from v1/POS-MAIN-DEFAULT.png and v1/POS-MAIN-V3.png
// (light/dark pair) — see Q02 in docs/DECISIONS-AND-QUESTIONS.txt.
// "Save & Hold" is not wired to a real screen yet (Hold Orders isn't
// rebuilt). "Send KOT" and "Proceed to Pay" both really save the order
// through the existing, tested application services — they differ only
// in what happens next (stay here vs. go straight to Payment), matching
// the PRD's own two models: pay-first takeaway and pay-later table
// service.

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../application/kitchen_service.dart';
import '../application/order_service.dart';
import '../application/payment_service.dart';
import '../data/local_menu_catalog.dart';
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
      this.table});
  final OrderService orderService;
  final KitchenService kitchenService;
  final PaymentService paymentService;
  final String locationId;

  /// Arrived here from a Tables card — dine-in against this table.
  /// Null means takeaway (arrived from "+ New Order" with no table).
  final RestaurantTable? table;

  @override
  State<PosOrderScreen> createState() => _PosOrderScreenState();
}

class _PosOrderScreenState extends State<PosOrderScreen> {
  final _cart = <String, int>{}; // itemId -> quantity
  String _categoryId = 'all';
  late OrderType _orderType =
      widget.table != null ? OrderType.dineIn : OrderType.takeaway;
  bool _saving = false;

  int get _subtotalMinor => _cart.entries.fold(0, (sum, e) {
        final item = LocalMenuCatalog.items.firstWhere((i) => i.id == e.key);
        return sum + item.priceMinor * e.value;
      });

  int get _taxMinor =>
      (_subtotalMinor * 0.05).round(); // GST 5%, matches reference
  int get _totalMinor => _subtotalMinor + _taxMinor;

  void _addItem(MenuItem item) {
    if (!item.available) return;
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
        final item = LocalMenuCatalog.items.firstWhere((i) => i.id == e.key);
        return OrderLine(
            itemId: item.id,
            name: item.name,
            unitMinor: item.priceMinor,
            quantity: e.value);
      }).toList(growable: false);

  Future<LocalOrder?> _saveOrderAndKot() async {
    if (_cart.isEmpty) return null;
    setState(() => _saving = true);
    try {
      final order = await widget.orderService.saveCashOrder(
          clientOrderId: const Uuid().v4(),
          locationId: widget.locationId,
          orderType: _orderType,
          tableLabel: widget.table?.label,
          lines: _lines());
      await widget.kitchenService.createTicketForOrder(order);
      return order;
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
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PaymentScreen(
            order: order,
            paymentService: widget.paymentService,
            // No real order-numbering scheme yet (PRD §11); a short,
            // visibly-a-placeholder display number stands in for it.
            orderNumber:
                (DateTime.now().millisecondsSinceEpoch % 10000).toString())));
  }

  void _notRebuiltYet(String what) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$what — not rebuilt yet against the real screens.')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.table != null
              ? '${widget.table!.label} — New Order'
              : 'New Order')),
      body: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _CategorySidebar(
            selected: _categoryId,
            onSelect: (id) => setState(() => _categoryId = id)),
        Expanded(
            flex: 3,
            child: _ItemGrid(categoryId: _categoryId, onTap: _addItem)),
        SizedBox(
            width: 320,
            child: _OrderPanel(
                table: widget.table,
                orderType: _orderType,
                onOrderTypeChanged: widget.table == null
                    ? (t) => setState(() => _orderType = t)
                    : null,
                cart: _cart,
                subtotalMinor: _subtotalMinor,
                taxMinor: _taxMinor,
                totalMinor: _totalMinor,
                onRemove: _removeItem,
                onAdd: _addItem,
                saving: _saving,
                onProceedToPay: _saving ? null : _proceedToPay,
                onSendKot: _sendKot,
                onSaveHold: () => _notRebuiltYet('Hold Orders screen'))),
      ]),
    );
  }
}

class _CategorySidebar extends StatelessWidget {
  const _CategorySidebar({required this.selected, required this.onSelect});
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('CATEGORIES',
                    style: TextStyle(
                        fontSize: 11, color: Colors.grey, letterSpacing: 1))),
            _CategoryTile(
                label: 'All Items',
                selected: selected == 'all',
                onTap: () => onSelect('all')),
            for (final c in LocalMenuCatalog.categories)
              _CategoryTile(
                  label: c.name,
                  selected: selected == c.id,
                  onTap: () => onSelect(c.id)),
          ]),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile(
      {required this.label, required this.selected, required this.onTap});
  final String label;
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
      // ListTile paints its ink/background on the nearest Material
      // ancestor — without one here, it would paint on whatever
      // Material is further up the tree, behind this Container's own
      // background, and log a runtime assertion about it.
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          dense: true,
          leading: Icon(Icons.star_border,
              size: 18, color: selected ? ViniiColors.brandGreen : Colors.grey),
          title: Text(label,
              style: TextStyle(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? ViniiColors.brandGreen : null)),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ItemGrid extends StatelessWidget {
  const _ItemGrid({required this.categoryId, required this.onTap});
  final String categoryId;
  final void Function(MenuItem) onTap;

  @override
  Widget build(BuildContext context) {
    final items = categoryId == 'all'
        ? LocalMenuCatalog.items
        : LocalMenuCatalog.itemsIn(categoryId);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('All Items  ·  ${items.length} items',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 130,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemCount: items.length,
            itemBuilder: (context, i) =>
                _ItemCard(item: items[i], onTap: onTap),
          ),
        ),
      ]),
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
            Text('₹${(item.priceMinor / 100).toStringAsFixed(0)}'),
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
      required this.orderType,
      required this.onOrderTypeChanged,
      required this.cart,
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
  final OrderType orderType;
  final ValueChanged<OrderType>? onOrderTypeChanged;
  final Map<String, int> cart;
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
                      for (final entry in cart.entries)
                        _OrderLineTile(
                            item: LocalMenuCatalog.items
                                .firstWhere((i) => i.id == entry.key),
                            quantity: entry.value,
                            onAdd: onAdd,
                            onRemove: onRemove),
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
                  onPressed: cart.isEmpty ? null : onSaveHold,
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
                '₹${(item.priceMinor * quantity / 100).toStringAsFixed(0)}',
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

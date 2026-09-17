// Rebuilt 1:1 from v1/POS-PAYMENT-DEFAULT.png and v1/POS-PAYMENT-V3.png
// (light/dark pair) — see Q02 in docs/DECISIONS-AND-QUESTIONS.txt. One
// real nuance the reference has that a naive theme flip would miss: the
// order-recap column on the left stays light in BOTH screens — only the
// payment-method column on the right goes dark in V3. Reproduced with
// an explicit light-styled Container on the left rather than inheriting
// the ambient theme.
//
// Only Cash is wired to actually complete — PRD §9: "A screenshot,
// manually entered UPI reference or offline 'paid' tap is not provider
// verification." Card/UPI/Split Pay are shown (matching the reference)
// but refuse to complete, since accepting them here would misrepresent
// an unverified tap as a confirmed digital payment.
//
// Completing a cash payment really persists a Payment record through
// PaymentService (own table, own idempotent-by-order-id write) — kept
// separate from LocalOrder/LocalOrderStatus per PRD §9: "Separate
// order, kitchen, delivery, payment and settlement states; do not
// overload one status."
//
// Service Charge, Discount/coupon and Add Tip appear in the reference
// but there is no real service-charge/promotion/tip feature built yet
// — inventing a 10% figure or a WELCOME10 coupon would misrepresent
// functionality that doesn't exist, so those rows are left out rather
// than faked. Only Subtotal, GST and Total (values this app actually
// computes) are shown.

import 'dart:async';

import 'package:flutter/material.dart';

import '../application/payment_service.dart';
import '../data/drift_all_orders_store.dart';
import '../data/local_all_orders_catalog.dart';
import '../domain/order.dart';
import 'vinii_theme.dart';

enum _PaymentMethod { cash, card, upi, split }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.order,
      required this.orderNumber,
      required this.paymentService,
      this.allOrdersStore});
  final LocalOrder order;
  final PaymentService paymentService;
  final DriftAllOrdersStore? allOrdersStore;

  /// A short display number — the real order-numbering scheme (PRD §11:
  /// "display numbering is separate [from the record id] and must not
  /// be silently rewritten") isn't built yet, so the caller supplies one.
  final String orderNumber;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  _PaymentMethod _method = _PaymentMethod.cash;
  bool _completing = false;
  // Defaults to the exact total, in rupees (the field the user sees and
  // types into) — not minor units. Mixing those up here once already
  // produced a ₹52500 default instead of ₹525; caught by actually
  // running the screen, not by reading the code.
  late final _amountController =
      TextEditingController(text: (_totalMinor / 100).toStringAsFixed(0));

  int get _taxMinor => (widget.order.subtotalMinor * 0.05).round();
  int get _totalMinor => widget.order.subtotalMinor + _taxMinor;

  int? get _amountReceivedMinor {
    final rupees = double.tryParse(_amountController.text.trim());
    return rupees == null ? null : (rupees * 100).round();
  }

  int? get _changeDueMinor {
    final received = _amountReceivedMinor;
    if (received == null) return null;
    return received - _totalMinor;
  }

  void _selectMethod(_PaymentMethod m) {
    if (m != _PaymentMethod.cash) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '${_methodLabel(m)} needs provider verification, which isn\'t connected yet — cash only for now.')));
      return;
    }
    setState(() => _method = m);
  }

  Future<void> _completePayment() async {
    final received = _amountReceivedMinor;
    final change = _changeDueMinor;
    if (received == null || change == null || change < 0) return;
    setState(() => _completing = true);
    try {
      // Same reasoning as pos_order_screen.dart's _saveOrderAndKot: a
      // local-database write should never take long, so bound it rather
      // than leaving the button on "completing" forever if the platform
      // storage backend is stuck.
      await widget.paymentService
          .recordCashPayment(
              clientOrderId: widget.order.clientOrderId,
              amountMinor: _totalMinor,
              receivedMinor: received)
          .timeout(const Duration(seconds: 8));

      if (widget.allOrdersStore != null) {
        final itemsCount =
            widget.order.lines.fold<int>(0, (sum, l) => sum + l.quantity);
        final itemsDesc = itemsCount == 1 ? '1 item' : '$itemsCount items';
        final typeLabel =
            widget.order.orderType == OrderType.dineIn ? 'Dine In' : 'Takeaway';
        final tableOrCust = widget.order.tableLabel != null &&
                widget.order.tableLabel!.isNotEmpty
            ? 'Table ${widget.order.tableLabel}'
            : (typeLabel == 'Dine In' ? 'Dine In' : 'Walk-in Customer');

        await widget.allOrdersStore!.insertOrder(
          AllOrdersRow(
            orderId: '#${widget.orderNumber}',
            type: typeLabel,
            source: 'Walk-in',
            tableOrCustomer: tableOrCust,
            itemsLabel: itemsDesc,
            amountMinor: _totalMinor,
            status: 'Completed',
            time: 'Just now',
          ),
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Payment completed — ₹${(_totalMinor / 100).toStringAsFixed(2)}, change ₹${(change / 100).toStringAsFixed(2)}. Order recorded in All Orders!')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e is TimeoutException
                ? 'Saving is taking too long — the local database may be unavailable. Please try again.'
                : 'Could not record the payment: $e')));
      }
    } finally {
      if (mounted) setState(() => _completing = false);
    }
  }

  static String _methodLabel(_PaymentMethod m) => switch (m) {
        _PaymentMethod.cash => 'Cash',
        _PaymentMethod.card => 'Card',
        _PaymentMethod.upi => 'UPI / QR',
        _PaymentMethod.split => 'Split Pay',
      };

  @override
  Widget build(BuildContext context) {
    final change = _changeDueMinor;
    final canComplete = change != null && change >= 0;

    return Scaffold(
      body: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            flex: 3,
            child: _OrderRecap(
                order: widget.order, orderNumber: widget.orderNumber)),
        SizedBox(
          width: 420,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                const SizedBox(width: 4),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('PAYMENT SCREEN',
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey, letterSpacing: 1)),
                  Text('Select Method',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ]),
              ]),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.7,
                children: [
                  _MethodTile(
                      icon: Icons.payments_outlined,
                      label: 'Cash',
                      selected: _method == _PaymentMethod.cash,
                      onTap: () => _selectMethod(_PaymentMethod.cash)),
                  _MethodTile(
                      icon: Icons.credit_card,
                      label: 'Card',
                      selected: _method == _PaymentMethod.card,
                      onTap: () => _selectMethod(_PaymentMethod.card)),
                  _MethodTile(
                      icon: Icons.qr_code,
                      label: 'UPI / QR',
                      selected: _method == _PaymentMethod.upi,
                      onTap: () => _selectMethod(_PaymentMethod.upi)),
                  _MethodTile(
                      icon: Icons.call_split,
                      label: 'Split Pay',
                      selected: _method == _PaymentMethod.split,
                      onTap: () => _selectMethod(_PaymentMethod.split)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('AMOUNT RECEIVED',
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey, letterSpacing: 1)),
              const SizedBox(height: 6),
              TextField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    prefixText: '₹', border: OutlineInputBorder()),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              const Text('Quick Amounts',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 6),
              Wrap(spacing: 8, runSpacing: 8, children: [
                _QuickAmountChip(
                    label: '₹${(_totalMinor / 100).toStringAsFixed(0)} (Exact)',
                    minor: _totalMinor,
                    controller: _amountController,
                    onPicked: () => setState(() {})),
                _QuickAmountChip(
                    label: '₹${(_totalMinor / 100 + 100).toStringAsFixed(0)}',
                    minor: _totalMinor + 10000,
                    controller: _amountController,
                    onPicked: () => setState(() {})),
                _QuickAmountChip(
                    label: '₹${(_totalMinor / 100 + 300).toStringAsFixed(0)}',
                    minor: _totalMinor + 30000,
                    controller: _amountController,
                    onPicked: () => setState(() {})),
              ]),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Change Due',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                    change == null
                        ? '—'
                        : '₹${(change / 100).toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: change != null && change < 0
                            ? ViniiColors.redSolid
                            : ViniiColors.greenSolid)),
              ]),
              const Spacer(),
              SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      onPressed:
                          canComplete && !_completing ? _completePayment : null,
                      style: FilledButton.styleFrom(
                          backgroundColor: ViniiColors.brandGreen,
                          padding: const EdgeInsets.all(16)),
                      child: Text(
                          'Complete Payment ₹${(_totalMinor / 100).toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              const SizedBox(height: 8),
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text(
                                  'Printing isn\'t wired to hardware yet (Q03).'))),
                      child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Print Bill')))),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _OrderRecap extends StatelessWidget {
  const _OrderRecap({required this.order, required this.orderNumber});
  final LocalOrder order;
  final String orderNumber;

  int get _taxMinor => (order.subtotalMinor * 0.05).round();
  int get _totalMinor => order.subtotalMinor + _taxMinor;

  @override
  Widget build(BuildContext context) {
    // Deliberately light regardless of app theme — matches both
    // reference screens, where this column never goes dark.
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black87),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(
                'Order #$orderNumber${order.tableLabel != null ? ' — ${order.tableLabel}' : ''}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: ViniiColors.greenTint,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                    order.orderType == OrderType.dineIn
                        ? 'Dine In'
                        : 'Takeaway',
                    style: const TextStyle(
                        color: ViniiColors.brandGreen, fontSize: 12))),
          ]),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE3E5EB)),
                borderRadius: BorderRadius.circular(10)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('ORDER ITEMS',
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey, letterSpacing: 1)),
              const SizedBox(height: 10),
              for (final line in order.lines)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(children: [
                    Text('${line.quantity}× ',
                        style: const TextStyle(
                            color: ViniiColors.greenSolid,
                            fontWeight: FontWeight.bold)),
                    Expanded(child: Text(line.name)),
                    Text('₹${(line.totalMinor / 100).toStringAsFixed(0)}'),
                  ]),
                ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE3E5EB)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              _totalsRow('Subtotal', order.subtotalMinor),
              _totalsRow('GST (5%)', _taxMinor),
              const Divider(),
              _totalsRow('Total Amount', _totalMinor, bold: true),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _totalsRow(String label, int minor, {bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontSize: bold ? 16 : 14)),
          Text('₹${(minor / 100).toStringAsFixed(bold ? 0 : 2)}',
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontSize: bold ? 20 : 14)),
        ]),
      );
}

class _MethodTile extends StatelessWidget {
  const _MethodTile(
      {required this.icon,
      required this.label,
      required this.selected,
      required this.onTap});
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: selected
                    ? ViniiColors.brandGreen
                    : Theme.of(context).dividerColor,
                width: selected ? 2 : 1),
            color:
                selected ? ViniiColors.greenTint.withValues(alpha: 0.15) : null,
            borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: selected ? ViniiColors.brandGreen : Colors.grey),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? ViniiColors.brandGreen : null)),
        ]),
      ),
    );
  }
}

class _QuickAmountChip extends StatelessWidget {
  const _QuickAmountChip(
      {required this.label,
      required this.minor,
      required this.controller,
      required this.onPicked});
  final String label;
  final int minor;
  final TextEditingController controller;
  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        controller.text.trim() == (minor / 100).toStringAsFixed(0) ||
            controller.text.trim() == (minor / 100).toString();
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: ViniiColors.brandGreen,
      labelStyle: TextStyle(color: isSelected ? Colors.black : null),
      onSelected: (_) {
        controller.text = (minor / 100).toStringAsFixed(0);
        onPicked();
      },
    );
  }
}

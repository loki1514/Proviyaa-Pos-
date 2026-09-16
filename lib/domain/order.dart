enum LocalOrderStatus {
  draft,
  savedLocal,
  pendingUpload,
  synchronized,
  needsReview
}

/// PRD §4 R04/R05 first slice: dine-in (against a table) or takeaway.
/// Local delivery is a later activation, not V1.
enum OrderType { dineIn, takeaway }

class OrderLine {
  const OrderLine(
      {required this.itemId,
      required this.name,
      required this.unitMinor,
      required this.quantity});
  final String itemId, name;
  final int unitMinor, quantity;
  int get totalMinor => unitMinor * quantity;
}

class LocalOrder {
  const LocalOrder(
      {required this.clientOrderId,
      required this.locationId,
      required this.currencyCode,
      required this.lines,
      required this.status,
      required this.orderType,
      this.tableLabel});
  final String clientOrderId, locationId, currencyCode;
  final List<OrderLine> lines;
  final LocalOrderStatus status;
  final OrderType orderType;

  /// Only meaningful when [orderType] is [OrderType.dineIn]. A plain
  /// label, not a full table/session model — see R05 "Basic active" in
  /// docs/REQUIREMENT-TRACEABILITY.txt.
  final String? tableLabel;

  int get subtotalMinor => lines.fold(0, (sum, line) => sum + line.totalMinor);
}

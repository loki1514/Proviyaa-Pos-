// Restaurant table domain — PRD §4 R05, PAGE-RES-003 in
// docs/sources/Product Architecture .converted.txt (floor plan, status,
// merge, split, transfer — merge/split/transfer are not modeled yet:
// they aren't visible in any of the 36 reference screens, only named in
// the architecture doc, so building UI for them now would be inventing
// layout again).

enum TableZone { indoor, outdoor, privateDining }

enum TableStatus { available, occupied, reserved, cleaning }

class RestaurantTable {
  const RestaurantTable(
      {required this.id,
      required this.label,
      required this.seats,
      required this.zone,
      required this.status,
      this.guestCount,
      this.elapsedMinutes,
      this.orderTotalMinor,
      this.reservedByName,
      this.reservedAt});

  final String id, label;
  final int seats;
  final TableZone zone;
  final TableStatus status;

  /// Occupied only.
  final int? guestCount;
  final int? elapsedMinutes;
  final int? orderTotalMinor;

  /// Reserved only.
  final String? reservedByName;
  final DateTime? reservedAt;
}

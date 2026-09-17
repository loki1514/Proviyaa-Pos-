// Menu domain — PRD §4 R03. First local slice: a seeded, clearly-labeled
// demo catalog. Consuming the real published catalog from Proviyaa OS is
// Phase B (device/config bootstrap) and is not implemented yet.

class MenuCategory {
  const MenuCategory(
      {required this.id, required this.name, this.itemCount = 0});
  final String id, name;
  final int itemCount;

  MenuCategory copyWith({String? id, String? name, int? itemCount}) =>
      MenuCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        itemCount: itemCount ?? this.itemCount,
      );
}

class MenuItem {
  const MenuItem(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.priceMinor,
      required this.isVeg,
      this.isBestseller = false,
      this.available = true,
      this.unavailableReason});
  final String id, categoryId, name;
  final int priceMinor;
  final bool isVeg;
  final bool isBestseller;
  final bool available;

  /// e.g. "Unavailable until 8 PM" — shown verbatim next to the status
  /// dot when [available] is false. Null means no specific reason is
  /// known, just "Unavailable".
  final String? unavailableReason;
}

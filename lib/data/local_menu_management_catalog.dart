// Seeded 1:1 from v1/POS-MENU-V3.png. A distinct catalog from
// local_menu_catalog.dart (which matches the different item set/prices
// in v1/POS-MAIN-V3.png's order-capture grid) — the two reference
// screens show different demo data, so forcing one shared catalog would
// misrepresent one of them.

class MenuManagementCategory {
  const MenuManagementCategory(
      {required this.id, required this.name, required this.itemCount});
  final String id, name;
  final int itemCount;
}

enum MenuTag { none, bestSeller, isNew }

class MenuManagementItem {
  const MenuManagementItem(
      {required this.name,
      required this.priceLabel,
      required this.isVeg,
      this.tag = MenuTag.none,
      this.variantCount,
      this.available = true,
      this.unavailableReason});

  final String name, priceLabel;
  final bool isVeg, available;
  final MenuTag tag;
  final int? variantCount;
  final String? unavailableReason;
}

class LocalMenuManagementCatalog {
  static const totalItems = 142;
  static const offItemsCount = 2;

  static const categories = <MenuManagementCategory>[
    MenuManagementCategory(id: 'all', name: 'All Items', itemCount: 142),
    MenuManagementCategory(id: 'starters', name: 'Starters', itemCount: 18),
    MenuManagementCategory(
        id: 'main-course', name: 'Main Course', itemCount: 24),
    MenuManagementCategory(
        id: 'breads-rice', name: 'Breads & Rice', itemCount: 16),
    MenuManagementCategory(id: 'beverages', name: 'Beverages', itemCount: 20),
    MenuManagementCategory(id: 'desserts', name: 'Desserts', itemCount: 12),
    MenuManagementCategory(
        id: 'combos-meals', name: 'Combos & Meals', itemCount: 8),
    MenuManagementCategory(id: 'specials', name: 'Specials', itemCount: 6),
    MenuManagementCategory(id: 'bar-menu', name: 'Bar Menu', itemCount: 14),
    MenuManagementCategory(id: 'kids-menu', name: 'Kids Menu', itemCount: 8),
  ];

  /// Only "Starters" has populated reference items (the screenshot has
  /// that category open); the rest show their item count only.
  static const startersItems = <MenuManagementItem>[
    MenuManagementItem(
        name: 'Paneer Tikka',
        priceLabel: '₹320',
        isVeg: true,
        tag: MenuTag.bestSeller),
    MenuManagementItem(name: 'Chicken Tikka', priceLabel: '₹380', isVeg: false),
    MenuManagementItem(
        name: 'Tandoori Soya Chaap',
        priceLabel: 'From ₹280',
        isVeg: true,
        variantCount: 3),
    MenuManagementItem(
        name: 'Paneer Malai Tikka',
        priceLabel: '₹340',
        isVeg: true,
        tag: MenuTag.isNew),
    MenuManagementItem(
        name: 'Hariyali Kabab',
        priceLabel: '₹290',
        isVeg: true,
        available: false,
        unavailableReason: 'Off until 8 PM'),
    MenuManagementItem(
        name: 'Assorted Platter',
        priceLabel: '₹520',
        isVeg: false,
        available: false,
        unavailableReason: 'Off for 2 hrs'),
  ];
}

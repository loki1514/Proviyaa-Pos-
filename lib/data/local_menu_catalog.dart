import '../domain/menu.dart';

/// A seeded, local-only demo catalog — NOT the real restaurant menu. It
/// stands in for the Phase B config/catalog sync from Proviyaa OS (PRD
/// §4 R02) so Phase C (local order capture) has something to sell
/// against. Replace with the real published-catalog projection once
/// device bootstrap/config sync exists.
///
/// Item names/prices match v1/POS-MAIN-DEFAULT.png exactly (same
/// reference the order-capture screen is rebuilt from) rather than
/// using different placeholder data for two screens that show the same
/// menu.
class LocalMenuCatalog {
  static const categories = <MenuCategory>[
    MenuCategory(id: 'starters', name: 'Starters'),
    MenuCategory(id: 'pizza', name: 'Pizza'),
    MenuCategory(id: 'breads', name: 'Breads'),
    MenuCategory(id: 'pasta', name: 'Pasta'),
    MenuCategory(id: 'main-course', name: 'Main Course'),
    MenuCategory(id: 'biryani', name: 'Biryani'),
    MenuCategory(id: 'beverages', name: 'Beverages'),
    MenuCategory(id: 'desserts', name: 'Desserts'),
    MenuCategory(id: 'combos', name: 'Combos'),
  ];

  static const items = <MenuItem>[
    MenuItem(
        id: 'paneer-butter-masala',
        categoryId: 'main-course',
        name: 'Paneer Butter Masala',
        priceMinor: 32000,
        isVeg: true,
        isBestseller: true),
    MenuItem(
        id: 'chicken-tikka',
        categoryId: 'starters',
        name: 'Chicken Tikka',
        priceMinor: 38000,
        isVeg: false),
    MenuItem(
        id: 'garlic-naan',
        categoryId: 'breads',
        name: 'Garlic Naan',
        priceMinor: 6000,
        isVeg: true),
    MenuItem(
        id: 'veg-biryani',
        categoryId: 'biryani',
        name: 'Veg Biryani',
        priceMinor: 28000,
        isVeg: true),
    MenuItem(
        id: 'butter-chicken',
        categoryId: 'main-course',
        name: 'Butter Chicken',
        priceMinor: 42000,
        isVeg: false),
    MenuItem(
        id: 'masala-dosa',
        categoryId: 'main-course',
        name: 'Masala Dosa',
        priceMinor: 18000,
        isVeg: true),
    MenuItem(
        id: 'dal-makhani',
        categoryId: 'main-course',
        name: 'Dal Makhani',
        priceMinor: 22000,
        isVeg: true),
    MenuItem(
        id: 'tandoori-roti',
        categoryId: 'breads',
        name: 'Tandoori Roti',
        priceMinor: 3000,
        isVeg: true),
    MenuItem(
        id: 'coke',
        categoryId: 'beverages',
        name: 'Coke',
        priceMinor: 7000,
        isVeg: true),
    MenuItem(
        id: 'gulab-jamun',
        categoryId: 'desserts',
        name: 'Gulab Jamun',
        priceMinor: 12000,
        isVeg: true,
        available: false,
        unavailableReason: 'Unavailable until 8 PM'),
    MenuItem(
        id: 'margherita-pizza',
        categoryId: 'pizza',
        name: 'Margherita Pizza',
        priceMinor: 35000,
        isVeg: true),
    MenuItem(
        id: 'caesar-salad',
        categoryId: 'starters',
        name: 'Caesar Salad',
        priceMinor: 26000,
        isVeg: true),
  ];

  static List<MenuItem> itemsIn(String categoryId) =>
      items.where((i) => i.categoryId == categoryId).toList(growable: false);
}

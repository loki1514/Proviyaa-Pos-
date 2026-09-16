// Rebuilt 1:1 from v1/POS-MENU-V3.png. Only "Starters" has populated
// reference item cards; other categories show their item count in the
// left rail only, with an honest empty state instead of invented items.
// The availability toggle and "Edit"/menu-dot controls are decorative,
// same rule as elsewhere for controls with no backing store yet.

import 'package:flutter/material.dart';

import '../data/local_menu_management_catalog.dart';
import 'vinii_theme.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _categoryId = 'starters';

  @override
  Widget build(BuildContext context) {
    final category = LocalMenuManagementCatalog.categories
        .firstWhere((c) => c.id == _categoryId);

    return Container(
      color: ViniiColors.lightPageBg,
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
              color: ViniiColors.lightBg,
              border:
                  Border(right: BorderSide(color: ViniiColors.lightBorder))),
          child: ListView(
            children: [
              for (final c in LocalMenuManagementCatalog.categories)
                _CategoryTile(
                    category: c,
                    selected: c.id == _categoryId,
                    onTap: () => setState(() => _categoryId = c.id)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Menu Management',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Organize categories, items, and pricing',
                            style: TextStyle(
                                color: ViniiColors.textMutedLight,
                                fontSize: 13)),
                      ]),
                ),
                OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Category')),
                const SizedBox(width: 8),
                FilledButton.icon(
                    onPressed: null,
                    style: FilledButton.styleFrom(
                        backgroundColor: ViniiColors.brandGreen,
                        foregroundColor: Colors.black),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Item',
                        style: TextStyle(fontWeight: FontWeight.w700))),
                const SizedBox(width: 8),
                OutlinedButton(
                    onPressed: null,
                    child: Text(
                        'View Off Items  ${LocalMenuManagementCatalog.offItemsCount}')),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                Text(category.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text('${category.itemCount} items',
                    style: const TextStyle(
                        color: ViniiColors.textMutedLight, fontSize: 13)),
              ]),
              const SizedBox(height: 12),
              Expanded(
                child: _categoryId == 'starters'
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                mainAxisExtent: 180,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 20),
                        itemCount:
                            LocalMenuManagementCatalog.startersItems.length,
                        itemBuilder: (context, i) => _MenuItemCard(
                            item: LocalMenuManagementCatalog.startersItems[i]))
                    : const Center(
                        child: Text(
                            'No populated reference for this category yet.',
                            style:
                                TextStyle(color: ViniiColors.textMutedLight))),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile(
      {required this.category, required this.selected, required this.onTap});
  final MenuManagementCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: selected ? ViniiColors.lightGreenTint : null,
          child: Row(children: [
            Expanded(
                child: Text(category.name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected
                            ? ViniiColors.greenSolid
                            : ViniiColors.textPrimaryLight))),
            Text('${category.itemCount}',
                style: const TextStyle(
                    fontSize: 12, color: ViniiColors.textMutedLight)),
          ]),
        ),
      ));
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({required this.item});
  final MenuManagementItem item;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: ViniiColors.lightBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: item.available
                  ? ViniiColors.lightBorder
                  : ViniiColors.redSolid,
              width: item.available ? 1 : 1.4)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: ViniiColors.grayTint,
            child: Stack(children: [
              if (item.tag == MenuTag.bestSeller)
                Positioned(
                    top: 8,
                    left: 8,
                    child: _Tag(
                        text: 'Best Seller', color: ViniiColors.amberSolid)),
              if (item.tag == MenuTag.isNew)
                Positioned(
                    top: 8,
                    left: 8,
                    child: _Tag(text: 'New', color: ViniiColors.blueSolid)),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.name,
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    decoration:
                        item.available ? null : TextDecoration.lineThrough,
                    color: item.available ? null : ViniiColors.textMutedLight)),
            Row(children: [
              Text(item.priceLabel,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              if (item.variantCount != null)
                Text('  ${item.variantCount} variants',
                    style: const TextStyle(
                        fontSize: 11, color: ViniiColors.textMutedLight)),
            ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: item.isVeg
                            ? ViniiColors.greenSolid
                            : ViniiColors.redSolid,
                        shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text(item.isVeg ? 'Veg' : 'Non-Veg',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: item.isVeg
                            ? ViniiColors.greenSolid
                            : ViniiColors.redSolid)),
              ]),
              Text(
                  item.available
                      ? 'Available'
                      : (item.unavailableReason ?? 'Unavailable'),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: item.available
                          ? ViniiColors.greenSolid
                          : ViniiColors.redSolid)),
            ]),
          ]),
        ),
      ]));
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)));
}

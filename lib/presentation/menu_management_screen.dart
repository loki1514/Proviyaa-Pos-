// Menu Management Screen with full SQLite CRUD support via DriftMenuStore.
// Rebuilt from v1/POS-MENU-V3.png with reactive categories, items,
// and edge-case form validations.

import 'package:flutter/material.dart';

import '../data/drift_menu_store.dart';
import '../domain/menu.dart';
import 'vinii_theme.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key, this.menuStore});
  final DriftMenuStore? menuStore;

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _selectedCategoryId = 'all';
  Stream<List<MenuCategory>>? _categoriesStream;
  Stream<List<MenuItem>>? _itemsStream;

  @override
  void initState() {
    super.initState();
    _initStreams();
  }

  @override
  void didUpdateWidget(covariant MenuManagementScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.menuStore != widget.menuStore) {
      _initStreams();
    }
  }

  void _initStreams() {
    _categoriesStream = widget.menuStore?.watchCategories();
    _itemsStream = widget.menuStore?.watchItems();
  }

  void _openAddEditCategoryDialog(
      BuildContext context, MenuCategory? existing, List<MenuCategory> allCategories) {
    showDialog(
      context: context,
      builder: (ctx) => _AddEditCategoryDialog(
        existing: existing,
        existingCategories: allCategories,
        onSave: (cat) async {
          if (widget.menuStore != null) {
            if (existing == null) {
              await widget.menuStore!.insertCategory(cat);
              if (mounted) setState(() => _selectedCategoryId = cat.id);
            } else {
              await widget.menuStore!.updateCategory(cat);
            }
          }
        },
      ),
    );
  }

  void _confirmDeleteCategory(BuildContext context, MenuCategory category) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Category "${category.name}"?'),
        content: Text(category.itemCount > 0
            ? 'This category contains ${category.itemCount} items. Deleting it will also delete all of its items from the database. Are you sure you want to proceed?'
            : 'Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              if (widget.menuStore != null) {
                await widget.menuStore!.deleteCategory(category.id);
                if (mounted && _selectedCategoryId == category.id) {
                  setState(() => _selectedCategoryId = 'all');
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _openAddEditItemDialog(
      BuildContext context, MenuItem? existing, List<MenuCategory> categories) {
    if (categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Warning: Please create at least one category before adding items.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final defaultCat = _selectedCategoryId == 'all'
        ? categories.first.id
        : _selectedCategoryId;

    showDialog(
      context: context,
      builder: (ctx) => _AddEditItemDialog(
        existing: existing,
        categories: categories,
        defaultCategoryId: defaultCat,
        onSave: (item) async {
          if (widget.menuStore != null) {
            if (existing == null) {
              await widget.menuStore!.insertItem(item);
            } else {
              await widget.menuStore!.updateItem(item);
            }
          }
        },
      ),
    );
  }

  void _confirmDeleteItem(BuildContext context, MenuItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete "${item.name}"?'),
        content: const Text(
            'Are you sure you want to delete this item from the database? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              if (widget.menuStore != null) {
                await widget.menuStore!.deleteItem(item.id);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showOffItemsDialog(BuildContext context, List<MenuItem> allItems) {
    final offItems = allItems.where((i) => !i.available).toList();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Off Items (${offItems.length})'),
        content: SizedBox(
          width: 450,
          child: offItems.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('All menu items are currently available!',
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: offItems.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (ctx, i) {
                    final item = offItems[i];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        item.unavailableReason ?? 'Unavailable',
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      trailing: FilledButton.tonal(
                        onPressed: () async {
                          if (widget.menuStore != null) {
                            await widget.menuStore!
                                .toggleItemAvailability(item.id, true);
                          }
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: const Text('Make Available'),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.menuStore != null &&
        _categoriesStream != null &&
        _itemsStream != null) {
      return StreamBuilder<List<MenuCategory>>(
        stream: _categoriesStream,
        builder: (context, catSnapshot) {
          final categories = catSnapshot.data ?? [];
          return StreamBuilder<List<MenuItem>>(
            stream: _itemsStream,
            builder: (context, itemSnapshot) {
              final allItems = itemSnapshot.data ?? [];
              return _buildContent(context, categories, allItems);
            },
          );
        },
      );
    }
    return _buildContent(context, const [], const []);
  }

  Widget _buildContent(BuildContext context, List<MenuCategory> rawCategories,
      List<MenuItem> allItems) {
    final offCount = allItems.where((i) => !i.available).length;
    final totalCount = allItems.length;

    // Attach real-time computed item counts
    final categories = rawCategories.map((c) {
      final count = allItems.where((i) => i.categoryId == c.id).length;
      return MenuCategory(id: c.id, name: c.name, itemCount: count);
    }).toList();

    // Filter items based on selected category
    final visibleItems = _selectedCategoryId == 'all'
        ? allItems
        : allItems.where((i) => i.categoryId == _selectedCategoryId).toList();

    final selectedCategory = _selectedCategoryId == 'all'
        ? null
        : categories.where((c) => c.id == _selectedCategoryId).firstOrNull;

    final headerTitle = selectedCategory?.name ?? 'All Items';
    final headerCount = visibleItems.length;

    return Container(
      color: ViniiColors.lightPageBg,
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Left Rail Categories Sidebar
        Container(
          width: 230,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
              color: ViniiColors.lightBg,
              border: Border(right: BorderSide(color: ViniiColors.lightBorder))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text('CATEGORIES',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _CategoryTile(
                      label: 'All Items',
                      count: totalCount,
                      selected: _selectedCategoryId == 'all',
                      onTap: () => setState(() => _selectedCategoryId = 'all'),
                    ),
                    for (final c in categories)
                      _CategoryTile(
                        label: c.name,
                        count: c.itemCount,
                        selected: c.id == _selectedCategoryId,
                        onTap: () => setState(() => _selectedCategoryId = c.id),
                        onEdit: () =>
                            _openAddEditCategoryDialog(context, c, categories),
                        onDelete: () => _confirmDeleteCategory(context, c),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Main Content Area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Action Bar
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
                    onPressed: () =>
                        _openAddEditCategoryDialog(context, null, categories),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Category'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () =>
                        _openAddEditItemDialog(context, null, categories),
                    style: FilledButton.styleFrom(
                        backgroundColor: ViniiColors.brandGreen,
                        foregroundColor: Colors.black),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Item',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => _showOffItemsDialog(context, allItems),
                    child: Text('View Off Items  $offCount'),
                  ),
                ]),
                const SizedBox(height: 20),

                // Category Title Header
                Row(children: [
                  Text(headerTitle,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text('$headerCount items',
                      style: const TextStyle(
                          color: ViniiColors.textMutedLight, fontSize: 13)),
                ]),
                const SizedBox(height: 12),

                // Items Grid or Honest Empty State
                Expanded(
                  child: categories.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.category_outlined,
                                  size: 56, color: Colors.grey),
                              SizedBox(height: 12),
                              Text('No categories in menu yet',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 6),
                              Text(
                                  'Click "+ Add Category" above to create your first menu category.',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                        )
                      : visibleItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.lunch_dining_outlined,
                                      size: 56, color: Colors.grey),
                                  const SizedBox(height: 12),
                                  Text(
                                    _selectedCategoryId == 'all'
                                        ? 'No menu items created yet'
                                        : 'No items in this category yet',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                      'Click "+ Add Item" above to add items.',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                ],
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300,
                                      mainAxisExtent: 195,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 20),
                              itemCount: visibleItems.length,
                              itemBuilder: (context, i) {
                                final item = visibleItems[i];
                                return _MenuItemCard(
                                  item: item,
                                  onEdit: () => _openAddEditItemDialog(
                                      context, item, categories),
                                  onDelete: () =>
                                      _confirmDeleteItem(context, item),
                                  onToggleAvailability: () async {
                                    if (widget.menuStore != null) {
                                      await widget.menuStore!
                                          .toggleItemAvailability(
                                              item.id, !item.available);
                                    }
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: selected ? ViniiColors.lightGreenTint : null,
          child: Row(children: [
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? ViniiColors.greenSolid
                      : ViniiColors.textPrimaryLight,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? ViniiColors.greenSolid.withValues(alpha: 0.15)
                    : Colors.grey.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: selected ? ViniiColors.greenSolid : Colors.grey[700],
                ),
              ),
            ),
            if (onEdit != null || onDelete != null) ...[
              const SizedBox(width: 4),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                iconSize: 16,
                icon: const Icon(Icons.more_vert, size: 16, color: Colors.grey),
                onSelected: (val) {
                  if (val == 'edit' && onEdit != null) onEdit!();
                  if (val == 'delete' && onDelete != null) onDelete!();
                },
                itemBuilder: (ctx) => [
                  if (onEdit != null)
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit Name'),
                        ],
                      ),
                    ),
                  if (onDelete != null)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleAvailability,
  });

  final MenuItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleAvailability;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ViniiColors.lightBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: item.available ? ViniiColors.lightBorder : ViniiColors.redSolid,
          width: item.available ? 1 : 1.4,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top banner / visual area
        Expanded(
          child: Container(
            width: double.infinity,
            color: ViniiColors.grayTint,
            child: Stack(children: [
              if (item.isBestseller)
                const Positioned(
                  top: 8,
                  left: 8,
                  child: _Tag(text: 'Best Seller', color: ViniiColors.amberSolid),
                ),
              Positioned(
                top: 4,
                right: 4,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  iconSize: 18,
                  icon: const Icon(Icons.more_vert, size: 18, color: Colors.black54),
                  onSelected: (val) {
                    if (val == 'edit') onEdit();
                    if (val == 'toggle') onToggleAvailability();
                    if (val == 'delete') onDelete();
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 16),
                          SizedBox(width: 8),
                          Text('Edit Item'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Row(
                        children: [
                          Icon(
                            item.available
                                ? Icons.block
                                : Icons.check_circle_outline,
                            size: 16,
                            color: item.available ? Colors.red : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(item.available
                              ? 'Mark Unavailable'
                              : 'Mark Available'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete Item',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),

        // Item info
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                decoration: item.available ? null : TextDecoration.lineThrough,
                color: item.available ? null : ViniiColors.textMutedLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '₹${(item.priceMinor / 100).toStringAsFixed(item.priceMinor % 100 == 0 ? 0 : 2)}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: item.isVeg
                        ? ViniiColors.greenSolid
                        : ViniiColors.redSolid,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  item.isVeg ? 'Veg' : 'Non-Veg',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: item.isVeg
                        ? ViniiColors.greenSolid
                        : ViniiColors.redSolid,
                  ),
                ),
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
                      : ViniiColors.redSolid,
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
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

// -----------------------------------------------------------------
// DIALOGS: ADD / EDIT CATEGORY
// -----------------------------------------------------------------

class _AddEditCategoryDialog extends StatefulWidget {
  const _AddEditCategoryDialog({
    required this.existing,
    required this.existingCategories,
    required this.onSave,
  });

  final MenuCategory? existing;
  final List<MenuCategory> existingCategories;
  final Future<void> Function(MenuCategory) onSave;

  @override
  State<_AddEditCategoryDialog> createState() => _AddEditCategoryDialogState();
}

class _AddEditCategoryDialogState extends State<_AddEditCategoryDialog> {
  late final TextEditingController _nameController;
  String? _warningMessage;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateAndSave() async {
    final name = _nameController.text.trim();

    // Edge Case 1: Empty name
    if (name.isEmpty) {
      setState(() {
        _warningMessage = 'Warning: Category name is required and cannot be empty.';
      });
      return;
    }

    // Edge Case 2: Duplicate name check (case-insensitive)
    final duplicate = widget.existingCategories.any((c) =>
        c.name.toLowerCase() == name.toLowerCase() &&
        c.id != widget.existing?.id);
    if (duplicate) {
      setState(() {
        _warningMessage = 'Warning: A category named "$name" already exists.';
      });
      return;
    }

    setState(() {
      _warningMessage = null;
      _saving = true;
    });

    final id = widget.existing?.id ??
        name
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
            .replaceAll(RegExp(r'^-|-$'), '');
    final finalId = id.isEmpty ? 'cat_${DateTime.now().millisecondsSinceEpoch}' : id;

    final category = MenuCategory(
      id: finalId,
      name: name,
      itemCount: widget.existing?.itemCount ?? 0,
    );

    await widget.onSave(category);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return AlertDialog(
      title: Text(isNew ? 'Add Category' : 'Edit Category'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_warningMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 20, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _warningMessage!,
                        style: const TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Category Name *',
                hintText: 'e.g. Starters, Beverages, Desserts',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _validateAndSave(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ViniiColors.brandGreen,
            foregroundColor: Colors.black,
          ),
          onPressed: _saving ? null : _validateAndSave,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(isNew ? 'Create Category' : 'Save Changes'),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------
// DIALOGS: ADD / EDIT ITEM
// -----------------------------------------------------------------

class _AddEditItemDialog extends StatefulWidget {
  const _AddEditItemDialog({
    required this.existing,
    required this.categories,
    required this.defaultCategoryId,
    required this.onSave,
  });

  final MenuItem? existing;
  final List<MenuCategory> categories;
  final String defaultCategoryId;
  final Future<void> Function(MenuItem) onSave;

  @override
  State<_AddEditItemDialog> createState() => _AddEditItemDialogState();
}

class _AddEditItemDialogState extends State<_AddEditItemDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _reasonController;
  late String _categoryId;
  late bool _isVeg;
  late bool _isBestseller;
  late bool _available;
  String? _warningMessage;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
    _priceController = TextEditingController(
        text: widget.existing != null
            ? (widget.existing!.priceMinor / 100).toStringAsFixed(
                widget.existing!.priceMinor % 100 == 0 ? 0 : 2)
            : '');
    _reasonController = TextEditingController(
        text: widget.existing?.unavailableReason ?? '');
    _categoryId = widget.existing?.categoryId ?? widget.defaultCategoryId;
    _isVeg = widget.existing?.isVeg ?? true;
    _isBestseller = widget.existing?.isBestseller ?? false;
    _available = widget.existing?.available ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _validateAndSave() async {
    final name = _nameController.text.trim();
    final priceStr = _priceController.text.trim();

    // Edge Case 1: Empty item name
    if (name.isEmpty) {
      setState(() {
        _warningMessage = 'Warning: Item name is required and cannot be empty.';
      });
      return;
    }

    // Edge Case 2: Missing or invalid category
    if (_categoryId.isEmpty) {
      setState(() {
        _warningMessage = 'Warning: Please select a category for this item.';
      });
      return;
    }

    // Edge Case 3: Empty price
    if (priceStr.isEmpty) {
      setState(() {
        _warningMessage = 'Warning: Price is required.';
      });
      return;
    }

    // Edge Case 4: Invalid price format
    final price = double.tryParse(priceStr);
    if (price == null) {
      setState(() {
        _warningMessage =
            'Warning: Please enter a valid numeric price (e.g. 250 or 99.50).';
      });
      return;
    }

    // Edge Case 5: Non-positive price
    if (price <= 0) {
      setState(() {
        _warningMessage = 'Warning: Price must be greater than zero.';
      });
      return;
    }

    setState(() {
      _warningMessage = null;
      _saving = true;
    });

    final priceMinor = (price * 100).round();
    final id = widget.existing?.id ??
        'item_${DateTime.now().millisecondsSinceEpoch}';

    final item = MenuItem(
      id: id,
      categoryId: _categoryId,
      name: name,
      priceMinor: priceMinor,
      isVeg: _isVeg,
      isBestseller: _isBestseller,
      available: _available,
      unavailableReason:
          !_available && _reasonController.text.trim().isNotEmpty
              ? _reasonController.text.trim()
              : null,
    );

    await widget.onSave(item);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existing == null;
    return AlertDialog(
      title: Text(isNew ? 'Add Menu Item' : 'Edit Menu Item'),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_warningMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          size: 20, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _warningMessage!,
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Item Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name *',
                  hintText: 'e.g. Paneer Tikka, Masala Chai',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),

              // Category Selector
              DropdownButtonFormField<String>(
                value: widget.categories.any((c) => c.id == _categoryId)
                    ? _categoryId
                    : widget.categories.first.id,
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final c in widget.categories)
                    DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    ),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _categoryId = val);
                },
              ),
              const SizedBox(height: 14),

              // Price
              TextField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Price (₹) *',
                  hintText: 'e.g. 320',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),

              // Dietary Type (Veg / Non-Veg)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  const Text('Dietary Type:',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  ChoiceChip(
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 8),
                        SizedBox(width: 4),
                        Text('Veg'),
                      ],
                    ),
                    selected: _isVeg,
                    selectedColor: ViniiColors.greenTint,
                    onSelected: (v) => setState(() => _isVeg = true),
                  ),
                  ChoiceChip(
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.red, size: 8),
                        SizedBox(width: 4),
                        Text('Non-Veg'),
                      ],
                    ),
                    selected: !_isVeg,
                    selectedColor: Colors.red.withValues(alpha: 0.15),
                    onSelected: (v) => setState(() => _isVeg = false),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Best Seller Checkbox
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mark as Best Seller'),
                value: _isBestseller,
                onChanged: (val) =>
                    setState(() => _isBestseller = val ?? false),
              ),

              // Availability Switch
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Available for Order'),
                value: _available,
                onChanged: (val) => setState(() => _available = val),
              ),

              if (!_available) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Unavailable Reason (Optional)',
                    hintText: 'e.g. Out of stock, Available after 6 PM',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: ViniiColors.brandGreen,
            foregroundColor: Colors.black,
          ),
          onPressed: _saving ? null : _validateAndSave,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(isNew ? 'Create Item' : 'Save Changes'),
        ),
      ],
    );
  }
}

// Reusable application chrome — mounts PosSidebar + PosTopBar once and
// swaps only the content area beneath them. Every module (Tables, Dine
// In, and any future one) is a plain widget passed in as `content`; none
// of them own or rebuild the sidebar/top bar themselves.

import 'package:flutter/material.dart';

import 'pos_sidebar.dart';
import 'pos_top_bar.dart';
import 'vinii_theme.dart';

class PosShell extends StatelessWidget {
  const PosShell(
      {super.key,
      required this.selected,
      required this.onSelect,
      required this.onNewOrder,
      required this.onOpenKitchen,
      required this.staffName,
      required this.branchName,
      required this.content});

  final PosModule selected;
  final ValueChanged<PosModule> onSelect;
  final VoidCallback onNewOrder;
  final VoidCallback onOpenKitchen;
  final String staffName;
  final String branchName;
  final Widget content;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: ViniiColors.lightPageBg,
      body: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        PosSidebar(
            selected: selected,
            onSelect: onSelect,
            onNewOrder: onNewOrder,
            staffName: staffName,
            branchName: branchName),
        Expanded(
          child: Column(children: [
            PosTopBar(onOpenKitchen: onOpenKitchen),
            Expanded(child: content),
          ]),
        ),
      ]));
}

/// Plain "not built yet" state for sidebar modules that have no rebuilt
/// screen — a clean placeholder rather than a crash or invented UI, per
/// the same "don't invent layout for unreferenced screens" rule already
/// applied elsewhere (pos_order_screen.dart's Hold Orders note,
/// tables_screen.dart's merge/split/transfer note).
class PosModulePlaceholder extends StatelessWidget {
  const PosModulePlaceholder({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Container(
      color: ViniiColors.lightPageBg,
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.construction_outlined,
            size: 40, color: ViniiColors.textMutedLight),
        const SizedBox(height: 12),
        Text('$title is not in the approved v1/ reference set yet',
            style: const TextStyle(
                color: ViniiColors.textMutedLight, fontSize: 14)),
      ]));
}

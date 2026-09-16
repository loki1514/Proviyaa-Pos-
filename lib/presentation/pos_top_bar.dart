// Persistent top application bar — rebuilt 1:1 from v1/POS-DINE-IN-V3.png.
// Deliberately not a Material AppBar: the reference bar has no elevation,
// a plain bottom border, and a search field + compact utility buttons
// that don't match AppBar's default layout, so it's a plain Container
// instead of fighting Material defaults into looking like this.

import 'package:flutter/material.dart';

import 'vinii_theme.dart';

class PosTopBar extends StatelessWidget {
  const PosTopBar({super.key, required this.onOpenKitchen});

  final VoidCallback onOpenKitchen;

  @override
  Widget build(BuildContext context) => Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: ViniiColors.lightBg,
          border: Border(bottom: BorderSide(color: ViniiColors.lightBorder))),
      child: Row(children: [
        Expanded(
          child: Container(
            height: 36,
            constraints: const BoxConstraints(maxWidth: 320),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: ViniiColors.grayTint,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ViniiColors.lightBorder)),
            child: Row(children: [
              const Icon(Icons.search,
                  size: 16, color: ViniiColors.textMutedLight),
              const SizedBox(width: 8),
              const Expanded(
                  child: Text('Search item, SKU...',
                      style: TextStyle(
                          color: ViniiColors.textMutedLight, fontSize: 13))),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: ViniiColors.lightBg,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: ViniiColors.lightBorder)),
                  child: const Text('⌘K',
                      style: TextStyle(
                          fontSize: 11, color: ViniiColors.textMutedLight))),
            ]),
          ),
        ),
        const SizedBox(width: 16),
        _UtilityButton(icon: Icons.visibility_outlined, onTap: () {}),
        _UtilityButton(icon: Icons.remove_red_eye_outlined, onTap: () {}),
        _UtilityButton(icon: Icons.dashboard_outlined, onTap: () {}),
        _UtilityButton(
            icon: Icons.soup_kitchen_outlined,
            tooltip: 'Kitchen Display',
            onTap: onOpenKitchen),
        _UtilityButton(
            icon: Icons.notifications_none, badgeCount: 3, onTap: () {}),
        _UtilityButton(icon: Icons.help_outline, onTap: () {}),
      ]));
}

class _UtilityButton extends StatelessWidget {
  const _UtilityButton(
      {required this.icon, required this.onTap, this.badgeCount, this.tooltip});
  final IconData icon;
  final VoidCallback onTap;
  final int? badgeCount;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ViniiColors.lightBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ViniiColors.lightBorder)),
            child: Stack(clipBehavior: Clip.none, children: [
              Icon(icon, size: 17, color: ViniiColors.textSecondaryLight),
              if (badgeCount != null)
                Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                            color: ViniiColors.redSolid,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text('$badgeCount',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold)))),
            ]),
          ),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

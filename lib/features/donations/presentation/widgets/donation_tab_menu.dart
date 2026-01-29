import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/donation_tabs.dart';
import '../models/donation_tab.dart';
import '../providers/donation_tab_provider.dart';

/// Bağış sekmeleri menü widget'ı (AppBar altında kullanılabilir).
class DonationTabMenu extends StatelessWidget implements PreferredSizeWidget {
  const DonationTabMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Consumer<DonationTabProvider>(
      builder: (context, tabProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(donationTabs.length, (index) {
            final tab = donationTabs[index];
            final isSelected = tabProvider.selectedIndex == index;
            final theme = Theme.of(context);
            final color = isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface;
            final backgroundColor = isSelected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest;
            const size = 60.0;
            final circle = Material(
              color: backgroundColor,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => tabProvider.selectTab(tab, index),
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Center(
                    child: Icon(tab.icon, color: color, size: 22),
                  ),
                ),
              ),
            );
            return Expanded(
              child: Tooltip(
                message: tab.label,
                child: circle,
              ),
            );
          }),
        );
      },
    );
  }
}

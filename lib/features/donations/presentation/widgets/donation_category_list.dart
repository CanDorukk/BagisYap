import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bagisyap/core/constants/app_sizes.dart';

import '../constants/donation_tabs.dart';
import '../models/donation_tab.dart';
import '../providers/donation_category.dart';
import '../providers/donation_tab_provider.dart';

/// Bağış kategorilerini liste halinde gösteren widget.
class DonationCategoryList extends StatelessWidget {
  const DonationCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DonationTabProvider>(
      builder: (context, tabProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(donationTabs.length, (index) {
              final tab = donationTabs[index];
              final isSelected = tabProvider.selectedIndex == index;
              return Expanded(
                child: _CategoryChip(
                  tab: tab,
                  isSelected: isSelected,
                  onTap: () {
                    tabProvider.selectTab(tab, index);
                    context.read<DonationCategoryProvider>().selectCategory(tab.category);
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final DonationTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _circleSize = 60;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface;
    final backgroundColor = isSelected
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    final circle = Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: _circleSize,
          height: _circleSize,
          child: Center(
            child: Icon(tab.icon, color: color, size: 22),
          ),
        ),
      ),
    );

    return Tooltip(
      message: tab.label,
      child: circle,
    );
  }
}

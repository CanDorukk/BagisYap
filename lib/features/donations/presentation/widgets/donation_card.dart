import 'package:flutter/material.dart';

import '../../domain/donation_entity.dart';
import '../../../../core/constants/app_sizes.dart';

/// Tek bir bağışı gösteren kart widget'ı.
class DonationCard extends StatelessWidget {
  const DonationCard({
    super.key,
    required this.donation,
    this.onTap,
  });

  final DonationEntity donation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                donation.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.paddingSmall),
              Text(
                donation.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

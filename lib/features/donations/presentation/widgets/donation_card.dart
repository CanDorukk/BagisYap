import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:bagisyap/core/constants/app_sizes.dart';

import '../../domain/donation_entity.dart';

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
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 72,
                  child: Container(
                  decoration: donation.imageUrl != null && donation.imageUrl!.isNotEmpty
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                        )
                      : BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: donation.imageUrl != null && donation.imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: donation.imageUrl!,
                            fit: BoxFit.contain,
                            placeholder: (_, __) => Icon(
                              Icons.image,
                              color: theme.colorScheme.onSurfaceVariant,
                              size: 28,
                            ),
                            errorWidget: (_, __, ___) => Icon(
                              Icons.volunteer_activism,
                              color: theme.colorScheme.onSurface,
                              size: 28,
                            ),
                          )
                        : Icon(
                            Icons.volunteer_activism,
                            color: theme.colorScheme.onSurface,
                            size: 28,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      donation.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingSmall),
                    Text(
                      donation.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.paddingSmall),
                    Row(
                      children: [
                        Text(
                          'Detay',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

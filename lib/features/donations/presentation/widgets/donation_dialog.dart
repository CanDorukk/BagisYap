import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bagisyap/core/constants/app_sizes.dart';
import 'package:bagisyap/core/utils/url_launcher_helper.dart';
import 'package:bagisyap/core/widgets/custom_dialog.dart';
import 'package:bagisyap/core/widgets/info_text.dart';

import '../../domain/donation_entity.dart';

/// Bağış detayını gösteren dialog.
class DonationDialog extends StatelessWidget {
  const DonationDialog({
    super.key,
    required this.donation,
  });

  final DonationEntity donation;

  static Future<void> show(BuildContext context, DonationEntity donation) {
    return showDialog<void>(
      context: context,
      builder: (context) => DonationDialog(donation: donation),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomDialog(
      title: donation.title,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoText(text: donation.description),
            if (donation.extraInfo != null && donation.extraInfo!.isNotEmpty) ...[
              const SizedBox(height: AppSizes.paddingMedium),
              InfoText(text: donation.extraInfo!),
            ],
            if (donation.donationUrl != null) ...[
              const SizedBox(height: AppSizes.paddingMedium),
              FilledButton.icon(
                onPressed: () => UrlLauncherHelper.openUrl(donation.donationUrl!),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Bağış sayfasına git'),
              ),
            ],
            const SizedBox(height: AppSizes.paddingLarge),
            const Divider(height: 1),
            const SizedBox(height: AppSizes.paddingSmall),
            RichText(
              text: TextSpan(
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                children: [
                  const TextSpan(text: 'Bilgiler "'),
                  TextSpan(
                    text: donation.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: donation.infoUrl != null &&
                            donation.infoUrl!.isNotEmpty
                        ? (TapGestureRecognizer()
                          ..onTap = () =>
                              UrlLauncherHelper.openUrl(donation.infoUrl!))
                        : null,
                  ),
                  const TextSpan(text: '" resmi internet sitesinden alınmıştır.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

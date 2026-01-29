import 'package:flutter/material.dart';

import '../../domain/donation_entity.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/utils/url_launcher_helper.dart';

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
    return CustomDialog(
      title: donation.title,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(donation.description),
            if (donation.url != null) ...[
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => UrlLauncherHelper.openUrl(donation.url!),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Siteyi Aç'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

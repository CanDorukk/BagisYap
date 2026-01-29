import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/donation_provider.dart';
import '../widgets/donation_card.dart';
import '../widgets/donation_dialog.dart';
import '../../../../core/constants/app_sizes.dart';

/// Bağış listesi sayfası.
class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonationProvider>().loadDonations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bağışlar'),
      ),
      body: Consumer<DonationProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Text(
                  'Hata: ${provider.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (provider.donations.isEmpty) {
            return const Center(child: Text('Henüz bağış bulunmuyor.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            itemCount: provider.donations.length,
            itemBuilder: (context, index) {
              final donation = provider.donations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingSmall),
                child: DonationCard(
                  donation: donation,
                  onTap: () => DonationDialog.show(context, donation),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

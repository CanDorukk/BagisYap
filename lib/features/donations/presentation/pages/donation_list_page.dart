import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bagisyap/core/constants/app_sizes.dart';
import 'package:bagisyap/features/donations/domain/donation_entity.dart';
import 'package:bagisyap/features/donations/presentation/constants/donation_tabs.dart';
import 'package:bagisyap/features/donations/presentation/providers/donation_provider.dart';
import 'package:bagisyap/features/donations/presentation/providers/donation_tab_provider.dart';
import 'package:bagisyap/features/donations/presentation/widgets/donation_card.dart';
import 'package:bagisyap/features/donations/presentation/widgets/donation_category_list.dart';
import 'package:bagisyap/features/donations/presentation/widgets/donation_dialog.dart';

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

  void _onDonationCardTap(BuildContext context, DonationEntity donation) {
    final options = donation.donationOptions;
    if (options != null && options.isNotEmpty) {
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    child: Text(
                      'Bağış türünü seçin',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Genel'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.of(context).pop();
                      DonationDialog.show(context, donation);
                    },
                  ),
                  ...options.map((option) => ListTile(
                        title: Text(option.label),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.of(context).pop();
                          DonationDialog.show(context, donation.forOption(option));
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      DonationDialog.show(context, donation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DonationTabProvider>(
      builder: (context, tabProvider, _) {
        final index = tabProvider.selectedIndex;
        final title = index < donationTabs.length
            ? donationTabs[index].appBarTitle
            : 'Bağışlar';
        return Scaffold(
          appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 68,
                child: DonationCategoryList(),
              ),
              Expanded(
                child: Consumer2<DonationProvider, DonationTabProvider>(
                  builder: (context, provider, tabProvider, _) {
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
                    final selectedCategory = tabProvider.selectedIndex;
                    final categoryId = selectedCategory < donationTabs.length
                        ? donationTabs[selectedCategory].category.name
                        : null;
                    final filtered = categoryId != null
                        ? provider.donations
                            .where((d) => d.categoryId == null || d.categoryId == categoryId)
                            .toList()
                        : provider.donations;

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text('Bu kategoride henüz bağış bulunmuyor.'),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(AppSizes.paddingMedium),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final donation = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.paddingSmall),
                          child: DonationCard(
                            donation: donation,
                            onTap: () => _onDonationCardTap(context, donation),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

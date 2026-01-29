import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bagisyap/core/constants/app_texts.dart';
import 'package:bagisyap/core/theme/app_theme.dart';
import 'package:bagisyap/features/donations/presentation/pages/donation_list_page.dart';
import 'package:bagisyap/features/donations/presentation/providers/donation_category.dart';
import 'package:bagisyap/features/donations/presentation/providers/donation_provider.dart';
import 'package:bagisyap/features/donations/presentation/providers/donation_tab_provider.dart';

/// Uygulama kök widget'ı.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DonationProvider()),
        ChangeNotifierProvider(create: (_) => DonationTabProvider()),
        ChangeNotifierProvider(create: (_) => DonationCategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        theme: AppTheme.light,
        home: const DonationListPage(),
      ),
    );
  }
}

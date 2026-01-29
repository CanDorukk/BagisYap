import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_texts.dart';
import 'core/theme/app_theme.dart';
import 'features/donations/presentation/pages/donation_list_page.dart';
import 'features/donations/presentation/providers/donation_provider.dart';

/// Uygulama kök widget'ı.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DonationProvider()),
      ],
      child: MaterialApp(
        title: AppTexts.appName,
        theme: AppTheme.light,
        home: const DonationListPage(),
      ),
    );
  }
}

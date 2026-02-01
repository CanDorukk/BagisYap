import 'package:flutter/material.dart';

import '../models/donation_tab.dart';
import '../providers/donation_category.dart';

/// Bağış menü sekmeleri: sadece ikon, tıklanınca AppBar yazısı değişir.
const List<DonationTab> donationTabs = [
  DonationTab(
    category: DonationCategory.government,
    appBarTitle: 'Devlet Kurumları',
    label: 'Devlet Kurumları',
    description: 'Bakanlık / başkanlık statüsünde',
    icon: Icons.account_balance,
  ),
  DonationTab(
    category: DonationCategory.foundation,
    appBarTitle: 'Vakıflar',
    label: 'Vakıflar',
    description: 'Kamu yararına vakıflar',
    icon: Icons.volunteer_activism,
  ),
  DonationTab(
    category: DonationCategory.association,
    appBarTitle: 'Dernekler',
    label: 'Dernekler',
    description: 'Dernekler',
    icon: Icons.handshake,
  ),
];

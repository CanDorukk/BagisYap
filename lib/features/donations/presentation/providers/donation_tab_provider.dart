import 'package:flutter/foundation.dart';

import '../models/donation_tab.dart';

/// Seçili bağış sekmesi state yönetimi.
class DonationTabProvider with ChangeNotifier {
  DonationTab? _selectedTab;
  int _selectedIndex = 0;

  DonationTab? get selectedTab => _selectedTab;
  int get selectedIndex => _selectedIndex;

  void selectTab(DonationTab? tab, int index) {
    if (_selectedTab == tab && _selectedIndex == index) return;
    _selectedTab = tab;
    _selectedIndex = index;
    notifyListeners();
  }

  void selectIndex(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    _selectedTab = null;
    notifyListeners();
  }
}

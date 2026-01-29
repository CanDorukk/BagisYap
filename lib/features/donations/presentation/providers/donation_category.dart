import 'package:flutter/foundation.dart';

/// Bağış menü kategorileri.
enum DonationCategory {
  /// Devlet kurumları.
  government,

  /// Vakıflar (kamu yararına).
  foundation,

  /// Dernekler / yardım sandıkları.
  association,
}

/// Seçili bağış kategorisi state yönetimi.
class DonationCategoryProvider with ChangeNotifier {
  DonationCategory? _selectedCategory;

  DonationCategory? get selectedCategory => _selectedCategory;

  void selectCategory(DonationCategory? category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void clearSelection() => selectCategory(null);
}

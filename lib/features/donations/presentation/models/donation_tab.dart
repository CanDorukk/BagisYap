import 'package:bagisyap/features/donations/presentation/providers/donation_category.dart';
import 'package:flutter/material.dart';

class DonationTab {
  final DonationCategory category;
  final String appBarTitle;
  final String label;
  /// Kısa açıklama (örn. "Bakanlık / başkanlık statüsünde, vakıf değil").
  final String? description;
  final IconData icon;

  const DonationTab({
    required this.category,
    required this.appBarTitle,
    required this.label,
    this.description,
    required this.icon,
  });
}

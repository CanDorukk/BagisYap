import 'package:flutter/foundation.dart';

import '../../domain/donation_entity.dart';
import '../../data/repositories/donation_repository.dart';

/// Bağış listesi state yönetimi.
class DonationProvider with ChangeNotifier {
  DonationProvider({DonationRepository? repository})
      : _repository = repository ?? DonationRepository();

  final DonationRepository _repository;

  List<DonationEntity> _donations = [];
  bool _isLoading = false;
  String? _error;

  List<DonationEntity> get donations => List.unmodifiable(_donations);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDonations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _donations = await _repository.getDonations();
    } catch (e, st) {
      _error = e.toString();
      debugPrintStack(stackTrace: st);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

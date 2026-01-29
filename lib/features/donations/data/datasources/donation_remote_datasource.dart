import 'package:http/http.dart' as http;

import '../models/donation_model.dart';

/// Bağış verilerini uzak kaynaktan çeken datasource.
class DonationRemoteDatasource {
  DonationRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  /// Bağış listesini getirir. Örnek: API URL'i projeye göre güncellenmeli.
  Future<List<DonationModel>> getDonations() async {
    // TODO: Gerçek API endpoint'i ile değiştirilecek
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const DonationModel(
        id: '1',
        title: 'Örnek Bağış',
        description: 'Örnek bağış açıklaması',
        url: 'https://example.com',
      ),
    ];
  }
}

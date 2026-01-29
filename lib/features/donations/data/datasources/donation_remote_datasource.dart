import 'package:http/http.dart' as http;

import '../models/donation_model.dart';

/// Bağış verilerini uzak kaynaktan çeken datasource.
class DonationRemoteDatasource {
  DonationRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  /// Bağış listesini getirir. Şimdilik demo veri.
  Future<List<DonationModel>> getDonations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const DonationModel(
        id: 'mehmetcik-vakfi',
        title: 'Mehmetçik Vakfı',
        description: 'TSK Mehmetçik Vakfı – Şehit ve gazi ailelerine destek.',
        url: 'https://www.mehmetcik.org.tr/bagis',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/tr/thumb/5/50/TSK_Mehmetçik_Vakfı_logo.png/250px-TSK_Mehmetçik_Vakfı_logo.png',
        categoryId: 'foundation',
        extraInfo:
            'SMS ile bağış yapmak isterseniz:\n\n'
            '"Mesajım Mehmetçik İçin Olsun" diyen vatandaşlar, TÜRK TELEKOM, '
            'TURKCELL veya VODAFONE GSM operatörlerine ait faturalı telefonlardan '
            '2582\'ye MEHMETÇİK yazıp kısa mesaj (SMS) aracılığıyla 50 TL tutarında '
            'bağışta bulunabilirler.',
        sourceUrl: 'https://www.mehmetcik.org.tr',
        sourceLabel: 'Veriler Mehmetçik Vakfı resmi sitesinden alınmıştır',
      ),
    ];
  }
}

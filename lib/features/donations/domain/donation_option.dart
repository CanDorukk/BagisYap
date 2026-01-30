/// Bir bağış kartındaki tek bir bağış türü (örn. Kızılay aşevi, Kızılay kan).
/// Dialog'da gösterilen alanlar: label, url, description, extraInfo, infoUrl (görsel dialog'da yok).
class DonationOption {
  const DonationOption({
    required this.label,
    required this.url,
    this.description,
    this.extraInfo,
    this.infoUrl,
  });

  final String label;
  final String url;
  final String? description;
  final String? extraInfo;
  final String? infoUrl;
}

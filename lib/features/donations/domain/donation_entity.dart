/// Bağış domain varlığı.
class DonationEntity {
  const DonationEntity({
    required this.id,
    required this.title,
    required this.description,
    this.url,
    this.imageUrl,
    this.extraInfo,
    this.sourceUrl,
    this.sourceLabel,
    this.categoryId,
  });

  final String id;
  final String title;
  final String description;
  final String? url;
  final String? imageUrl;
  /// Ek bilgi metni (örn. SMS ile bağış açıklaması).
  final String? extraInfo;
  /// Kaynak site URL (örn. "Veriler ... sitesinden alınmıştır" linki).
  final String? sourceUrl;
  /// Kaynak etiket metni.
  final String? sourceLabel;
  /// Kategori (government, foundation, association).
  final String? categoryId;
}

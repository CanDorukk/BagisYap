/// Bağış domain varlığı.
class DonationEntity {
  const DonationEntity({
    required this.id,
    required this.title,
    required this.description,
    this.donationUrl,
    this.imageUrl,
    this.extraInfo,
    this.infoUrl,
    this.categoryId,
  });

  final String id;
  final String title;
  final String description;
  final String? donationUrl;
  final String? imageUrl;
  /// Ek bilgi metni (örn. SMS ile bağış açıklaması).
  final String? extraInfo;
  /// Dialog altında "Bilgiler resmi olarak X tarafından alınmıştır" altındaki linkin URL'i.
  final String? infoUrl;
  /// Kategori (government, foundation, association).
  final String? categoryId;
}

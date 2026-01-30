import 'donation_option.dart';

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
    this.donationOptions,
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
  /// Birden fazla bağış türü (örn. Kızılay: aşevi, kan). Varsa karta tıklanınca önce seçim listesi gösterilir.
  final List<DonationOption>? donationOptions;

  /// Seçilen [option] ile bu bağışı tek bir "sanal" entity olarak döndürür (dialog için).
  /// Option map'inde varsa extraInfo, infoUrl oradan; option'da yoksa null (ana extraInfo gösterilmez).
  DonationEntity forOption(DonationOption option) {
    return DonationEntity(
      id: id,
      title: option.label,
      description: option.description ?? description,
      donationUrl: option.url,
      imageUrl: imageUrl,
      extraInfo: option.extraInfo,
      infoUrl: option.infoUrl ?? infoUrl,
      categoryId: categoryId,
      donationOptions: null,
    );
  }
}

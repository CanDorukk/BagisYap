import '../../domain/donation_entity.dart';

/// Bağış veri modeli.
class DonationModel extends DonationEntity {
  const DonationModel({
    required super.id,
    required super.title,
    required super.description,
    super.url,
    super.imageUrl,
    super.extraInfo,
    super.sourceUrl,
    super.sourceLabel,
    super.categoryId,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String?,
      imageUrl: json['imageUrl'] as String?,
      extraInfo: json['extraInfo'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      sourceLabel: json['sourceLabel'] as String?,
      categoryId: json['categoryId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'url': url,
        'imageUrl': imageUrl,
        'extraInfo': extraInfo,
        'sourceUrl': sourceUrl,
        'sourceLabel': sourceLabel,
        'categoryId': categoryId,
      };
}

import '../../domain/donation_entity.dart';

/// Bağış veri modeli.
class DonationModel extends DonationEntity {
  const DonationModel({
    required super.id,
    required super.title,
    required super.description,
    super.url,
    super.imageUrl,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'url': url,
        'imageUrl': imageUrl,
      };
}

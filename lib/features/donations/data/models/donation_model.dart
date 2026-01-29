import '../../domain/donation_entity.dart';

/// Bağış veri modeli.
class DonationModel extends DonationEntity {
  const DonationModel({
    required super.id,
    required super.title,
    required super.description,
    super.donationUrl,
    super.imageUrl,
    super.extraInfo,
    super.infoUrl,
    super.categoryId,
  });

  /// Firestore doc.data() veya JSON'dan oluşturur.
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    String? _str(dynamic v) =>
        v == null ? null : (v is String ? v : v.toString());

    return DonationModel(
      id: _str(json['id']) ?? '',
      title: _str(json['title']) ?? '',
      description: _str(json['description']) ?? '',
      donationUrl: _str(json['donationUrl']),
      imageUrl: _str(json['imageUrl']),
      extraInfo: _str(json['extraInfo']),
      infoUrl: _str(json['infoUrl']),
      categoryId: _str(json['categoryId']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'donationUrl': donationUrl,
        'imageUrl': imageUrl,
        'extraInfo': extraInfo,
        'infoUrl': infoUrl,
        'categoryId': categoryId,
      };
}

import '../../domain/donation_entity.dart';
import '../../domain/donation_option.dart';

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
    super.donationOptions,
  });

  /// Firestore doc.data() veya JSON'dan oluşturur.
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    String? _str(dynamic v) =>
        v == null ? null : (v is String ? v : v.toString());

    List<DonationOption>? options;
    final rawOptions = json['donationOptions'];
    if (rawOptions is List && rawOptions.isNotEmpty) {
      options = rawOptions.map((e) {
        final m = e is Map ? Map<String, dynamic>.from(e as Map) : <String, dynamic>{};
        return DonationOption(
          label: _str(m['label']) ?? '',
          url: _str(m['url']) ?? '',
          description: _str(m['description']),
          extraInfo: _str(m['extraInfo']),
          infoUrl: _str(m['infoUrl']),
        );
      }).toList();
    }

    return DonationModel(
      id: _str(json['id']) ?? '',
      title: _str(json['title']) ?? '',
      description: _str(json['description']) ?? '',
      donationUrl: _str(json['donationUrl']),
      imageUrl: _str(json['imageUrl']),
      extraInfo: _str(json['extraInfo']),
      infoUrl: _str(json['infoUrl']),
      categoryId: _str(json['categoryId']),
      donationOptions: options,
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
        if (donationOptions != null)
          'donationOptions': donationOptions!
              .map((o) => {
                    'label': o.label,
                    'url': o.url,
                    if (o.description != null) 'description': o.description,
                    if (o.extraInfo != null) 'extraInfo': o.extraInfo,
                    if (o.infoUrl != null) 'infoUrl': o.infoUrl,
                  })
              .toList(),
      };
}

/// Bağış domain varlığı.
class DonationEntity {
  const DonationEntity({
    required this.id,
    required this.title,
    required this.description,
    this.url,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final String? url;
  final String? imageUrl;
}

import '../../domain/donation_entity.dart';
import '../datasources/donation_firestore_datasource.dart';

/// Bağış verisi için repository (Firestore).
class DonationRepository {
  DonationRepository({DonationFirestoreDatasource? datasource})
      : _datasource = datasource ?? DonationFirestoreDatasource();

  final DonationFirestoreDatasource _datasource;

  Future<List<DonationEntity>> getDonations() async {
    final models = await _datasource.getDonations();
    return models;
  }
}

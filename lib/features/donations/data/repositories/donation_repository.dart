import '../../domain/donation_entity.dart';
import '../datasources/donation_remote_datasource.dart';

/// Bağış verisi için repository.
class DonationRepository {
  DonationRepository({DonationRemoteDatasource? datasource})
      : _datasource = datasource ?? DonationRemoteDatasource();

  final DonationRemoteDatasource _datasource;

  Future<List<DonationEntity>> getDonations() async {
    final models = await _datasource.getDonations();
    return models;
  }
}

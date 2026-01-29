import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/donation_model.dart';

/// Firestore koleksiyon adı.
const String donationsCollection = 'donations';

/// Bağış verilerini Firestore'dan çeken datasource.
class DonationFirestoreDatasource {
  DonationFirestoreDatasource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// Bağış listesini Firestore'dan getirir.
  /// Koleksiyon: [donationsCollection]
  Future<List<DonationModel>> getDonations() async {
    final snapshot =
        await _firestore.collection(donationsCollection).get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return DonationModel.fromJson({
        'id': doc.id,
        ...data,
      });
    }).toList();
  }
}

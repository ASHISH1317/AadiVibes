import 'package:aadivibes/app/data/config/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Trade Provider
class MusicProvider {
  /// Get currently logged in user
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  /// USer Data
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      get userTradeData async {
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('feedMusic')
        .doc('4qFk9UNwS0InfBctVUX7')
        .get();
    logI('Data from music feed :: ${data.data()}');
    return data;
  }

  /// USer Data
  static Future<Map<String, dynamic>> get userTradeDataDynamic async {
    logI('Check - before');

    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('feedMusic')
        .doc('4qFk9UNwS0InfBctVUX7')
        .get();

    logI('Check - after ::: ${data.data()}');

    return data.data() ?? <String, dynamic>{};
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Trade Setup Data Provider
class UserDataProvider {
  /// Get currently logged in user Trade setup Data
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  /// USer Data
  static Future<DocumentSnapshot<Map<String, dynamic>>> get userData async {
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('user')
        .doc(currentUser?.uid)
        .get();
    return data;
  }
}

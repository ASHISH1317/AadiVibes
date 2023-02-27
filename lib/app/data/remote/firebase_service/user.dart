// ignore_for_file: lines_longer_than_80_chars

import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/models/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firestore instance
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

///Firebase auth instance
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

/// Collection reference
final CollectionReference<Object> collectionReference =
    fireStore.collection('user');

/// UserData
class UserData {
  /// Add user Data
  static Future<ResponseCode> addUserData({
    String? mobileNo,
    String? uid,
    String? name,
    String? profilePicture,
  }) async {
    logD('Add User Data  to Date Base is  Called');
    final ResponseCode response = ResponseCode();

    final DocumentReference<Object> documentReference =
        collectionReference.doc(firebaseAuth.currentUser?.uid);

    final Map<String, dynamic> data = <String, dynamic>{
      'uid': uid.toString(),
      'name': name.toString(),
      'mobileNo': mobileNo.toString(),
      'profilePicture': profilePicture.toString(),
    };
    await documentReference.set(data).whenComplete(() {
      response
        ..code = 200
        ..message = 'Successfully added to database';
    }).onError(
      (Object? error, StackTrace stackTrace) => logWTF(
        'Error--------$error',
      ),
    );
    return response;
  }
}

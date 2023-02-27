import 'dart:convert';

import 'package:aadivibes/app/data/config/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aadivibes/app/data/config/encryption.dart';
import 'package:aadivibes/app/data/local/storage_keys.dart';
import 'package:aadivibes/app/data/models/user_entity.dart';

/// Helper class for local stored User
class UserProvider {
  /// User Entity
  static UserEntity? userEntity;
  static String? _authToken;
  static late bool _isLoggedIn;

  /// Get currently logged in user
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  /// USer Data
  static Future<DocumentSnapshot<Map<String, dynamic>>> get userData async {
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('user')
        .doc(currentUser?.uid)
        .get();
    logI('User Data :: ${data.data()}');
    return data;
  }

  /// Get auth token of the logged in user
  static String? get authToken => _authToken;

  /// If the user is logged in or not
  static bool get isLoggedIn => _isLoggedIn;

  ///Set [currentUser] and [authToken]
  static Future<void> onLogin(UserEntity user, String userAuthToken) async {
    _isLoggedIn = true;
    userEntity = user;
    _authToken = userAuthToken;
    await GetStorage().write(StorageKeys.userDataKey,
        AppEncryption.encrypt(plainText: jsonEncode(user.toJson())));
    await GetStorage().write(StorageKeys.authTokenKey, userAuthToken);
  }

  ///Load [currentUser] and [authToken]
  static void loadUser() {
    final String? encryptedUserData =
        GetStorage().read<String>(StorageKeys.userDataKey);

    if (encryptedUserData != null) {
      _isLoggedIn = true;
      userEntity = UserEntity.fromMap(
          jsonDecode(AppEncryption.decrypt(cipherText: encryptedUserData))
              as Map<String, dynamic>);
      _authToken = GetStorage().read<String>(StorageKeys.authTokenKey)!;
    } else {
      _isLoggedIn = false;
    }
  }

  ///Remove [currentUser] and [authToken] from local storage
  static Future<void> onLogout() async {
    _isLoggedIn = false;
    userEntity = null;
    _authToken = null;
    await GetStorage().remove(StorageKeys.userDataKey);
    await GetStorage().remove(StorageKeys.authTokenKey);
  }
}

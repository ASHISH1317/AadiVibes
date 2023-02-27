import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aadivibes/app/data/local/storage_keys.dart';

/// Helper class for localization
class LocaleProvider {
  static Locale _currentLocale = const Locale('en_US');

  /// Get selected locale
  static Locale get currentLocale => _currentLocale;

  /// Load selected locate
  static void loadCurrentLocale() {
    _currentLocale = Locale(
        GetStorage().read<String>(StorageKeys.currentLocaleKey) ?? 'en_US');
  }

  /// update app language
  static Future<void> changeLocale(Locale updatedLocale) async {
    _currentLocale = updatedLocale;
    await GetStorage()
        .write(StorageKeys.currentLocaleKey, updatedLocale.languageCode);
    unawaited(Get.updateLocale(LocaleProvider.currentLocale));
  }

  /// Save Verification Id
  String getVerificationId() =>
      GetStorage().read<String>(
        StorageKeys.verificationId,
      ) ??
      '';

  /// Get Verification Id
  Future<void> saveVerificationId(String? verificationId) => GetStorage().write(
        StorageKeys.verificationId,
        verificationId,
      );

  /// Get Mobile Number
  String getMobileNumber() =>
      GetStorage().read<String>(
        StorageKeys.mobileNumber,
      ) ??
      '';

  /// Save Mobile Number
  Future<void> saveMobileNumber(String? mobileNumber) => GetStorage().write(
        StorageKeys.mobileNumber,
        mobileNumber,
      );

  /// Get Mobile Number
  String getName() =>
      GetStorage().read<String>(
        StorageKeys.name,
      ) ??
      '';

  /// Save Mobile Number
  Future<void> saveName(String? name) => GetStorage().write(
        StorageKeys.name,
        name,
      );

  /// Get Mobile Number
  Object getUserCredential() =>
      GetStorage().read<Map<String, dynamic>>(
        StorageKeys.userCredential,
      ) ??
      '';

  /// Save Mobile Number
  Future<void> saveUserCredential(User credential) => GetStorage().write(
        StorageKeys.userCredential,
        credential,
      );

  /// Get Mobile Number
  int getResendOtpToken() =>
      GetStorage().read<int>(
        StorageKeys.resendToken,
      ) ??
      0;

  /// Save Mobile Number
  Future<void> saveResendOtpToken(int? resendToken) => GetStorage().write(
        StorageKeys.resendToken,
        resendToken,
      );
}

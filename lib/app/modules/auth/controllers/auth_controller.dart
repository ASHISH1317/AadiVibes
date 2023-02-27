import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/routes/app_pages.dart';
import 'package:aadivibes/app/ui/components/app_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Authentication Controller
class AuthController extends GetxController {
  /// Is Enter Otp
  RxBool isEnterOtp = false.obs;

  /// Country Code
  RxString countryCode = '+91'.obs;

  /// Otp
  RxString otp = ''.obs;

  /// phone Controller
  TextEditingController phoneController = TextEditingController();

  /// Pin Controller
  TextEditingController pinController = TextEditingController();

  /// Authentication Firebase
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Phone Number
  RxString phoneNo = ''.obs;

  /// On Init
  @override
  void onInit() {
    super.onInit();
  }

  /// On Ready
  @override
  void onReady() {
    super.onReady();
  }

  /// On Close
  @override
  void onClose() {
    phoneController.dispose();
    pinController.dispose();
    super.onClose();
  }

  /// Validate Phone Number validate  Key
  final GlobalKey<FormState> phoneNumberValidateKey = GlobalKey<FormState>();

  /// Validate phone number
  String? validatePhoneNumber(String value) {
    if (value.length < 10) {
      appSnackbar(
        message: 'Please enter valid mobile number',
        snackbarState: SnackbarState.danger,
      );
    }
    return null;
  }

  /// Verify Phone Number
  Future<void> verifyPhone({
    required void Function(String, int?) codeSent,
    String? phone,
    int? resendToken,
  }) async {
    await LocaleProvider().saveMobileNumber(phone);
    await EasyLoading.show(
      maskType: EasyLoadingMaskType.clear,
    );
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) async {
        await EasyLoading.dismiss();
      },
      forceResendingToken: resendToken,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// Otp Verification Controller
  Future<void> verifyOtp({
    String? smsCode,
    String? verificationId,
  }) async {
    logE(smsCode);
    await EasyLoading.show();
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode!,
    );
    await auth.signInWithCredential(credential).then((UserCredential value) {
      if (value.user != null) {
        LocaleProvider().saveUserCredential(value.user!);
        EasyLoading.dismiss();
        appSnackbar(
          message: 'Otp verified successfully',
          snackbarState: SnackbarState.success,
        );
        Get.toNamed<void>(Routes.GETNAME);
      } else {
        EasyLoading.dismiss();
        appSnackbar(
          message: 'Something went wrong',
          snackbarState: SnackbarState.danger,
        );
      }
    }).catchError((dynamic error) {
      EasyLoading.dismiss();
      appSnackbar(
        message: 'Enter valid Otp',
        snackbarState: SnackbarState.danger,
      );
    });
  }
}

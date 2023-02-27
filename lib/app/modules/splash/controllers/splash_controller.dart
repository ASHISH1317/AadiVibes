import 'package:aadivibes/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// Splash Controller
class SplashController extends GetxController {
  /// Splash Time
  RxInt splashTime = 5.obs;

  /// Is Login
  RxString? isLogin = ''.obs;

  /// On Init
  @override
  void onInit() {
    Future<void>.delayed(Duration(seconds: splashTime()), () async {
      if (isLogin != null) {
        await Get.toNamed<void>(Routes.AUTH);
      } else {
        await Get.toNamed<void>(Routes.AUTH);
      }
    });
    super.onInit();
  }

  /// On Ready
  @override
  void onReady() {
    Future<void>.delayed(Duration(seconds: splashTime()), () async {
      if (isLogin != null) {
        await Get.toNamed<void>(Routes.AUTH);
      } else {
        await Get.toNamed<void>(Routes.AUTH);
      }
    });
    super.onReady();
  }

  /// On Close
  @override
  void onClose() {
    super.onClose();
  }
}

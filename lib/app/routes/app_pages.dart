import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/enter_phone_no.dart';
import '../modules/music/bindings/music_binding.dart';
import '../modules/music/views/music_view.dart';
import '../modules/getname/bindings/getname_binding.dart';
import '../modules/getname/views/getname_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const ContactNumber(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.GETNAME,
      page: () => const GetNameView(),
      binding: GetNameBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const MusicView(),
      binding: MusicBinding(),
    ),
  ];
}

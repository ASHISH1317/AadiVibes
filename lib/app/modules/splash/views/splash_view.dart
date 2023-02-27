import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/auth/views/enter_phone_no.dart';
import 'package:aadivibes/app/routes/app_pages.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

/// Splash View
class SplashView extends GetView<SplashController> {
  /// Splash View
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => AnimatedSplashScreen(
        curve: Curves.easeInOutCubicEmphasized,
        nextRoute: Routes.AUTH,
        splash: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.k1E1E1E,
          child: Center(
            child: SvgPicture.asset(
              AppImage.splash,
            ),
          ),
        ),
        backgroundColor: AppColors.k1E1E1E,
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.leftToRightWithFade,
        splashIconSize: MediaQuery.of(context).size.height,
        nextScreen: const ContactNumber(),
        // nextScreen: FirebaseAuth.instance.currentUser != null
        //     ? const DashboardView()
        //     : const ContactNumber(),
      );
}

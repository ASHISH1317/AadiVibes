import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/modules/profile/profile_controller.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Profile View
class ProfileView extends GetView<ProfileController> {
  /// Profile View
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await exitAlert(
          nope: false,
          yes: true,
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: AppColors.k000000,
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                color: AppColors.k1E1E1E,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ProfileImage(
                    radius: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    LocaleProvider().getName(),
                    style: GoogleFonts.sen(
                      fontSize: 22,
                      color: AppColors.kffffff,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

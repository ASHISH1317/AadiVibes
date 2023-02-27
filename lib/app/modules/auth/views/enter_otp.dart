import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/routes/app_pages.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/components/nav_button.dart';
import 'package:aadivibes/app/ui/components/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';

/// Otp View
class Otp extends GetView<AuthController> {
  /// Otp View
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final bool? shouldPop = await exitAlert(
            nope: false,
            yes: true,
          );
          return shouldPop!;
        },
        child: Scaffold(
          backgroundColor: AppColors.k1E1E1E,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 15,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed<void>(Routes.AUTH);
                  },
                  child: SvgPicture.asset(
                    AppImage.arrowLeft,
                    color: AppColors.kffffff,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 20,
                ),
                child: Text(
                  'Confirm your Number',
                  style: GoogleFonts.sen(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kffffff,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Enter the code we sent over SMS to',
                      style: GoogleFonts.sen(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kffffff.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${controller.phoneNo()}',
                      style: GoogleFonts.sen(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kffffff,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: OtpTextField(
                  controller: controller.pinController,
                  onCompleted: (String value) {
                    controller.otp(value);
                    controller.otp.refresh();
                  },
                  onChanged: (String val) {
                    controller.otp(val);
                    controller.otp.refresh();
                  },
                  onSubmit: (String pin) {
                    controller.otp(pin);
                    controller.otp.refresh();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Didn’t get code ?',
                      style: GoogleFonts.sen(
                        fontSize: 14,
                        color: AppColors.kffffff,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.verifyPhone(
                          codeSent: (
                            String _verificationId,
                            int? resendToken,
                          ) async {
                            await EasyLoading.dismiss();
                          },
                          resendToken: LocaleProvider().getResendOtpToken(),
                          phone: LocaleProvider().getMobileNumber(),
                        );
                      },
                      child: Text(
                        'Send Again.',
                        style: GoogleFonts.sen(
                          fontSize: 14,
                          color: AppColors.k1DB954,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: NavButton(
                  color: AppColors.k1DB954,
                  height: 0.065,
                  width: 1,
                  onTap: () {
                    controller.pinController.dispose();
                    controller
                        .verifyOtp(
                      smsCode: controller.otp(),
                      verificationId: LocaleProvider().getVerificationId(),
                      // ignore: always_specify_types
                    )
                        .then((dynamic value) {
                      controller.pinController.clear();
                    });
                  },
                  name: 'Next',
                ),
              ),
            ],
          ),
        ),
      );
}

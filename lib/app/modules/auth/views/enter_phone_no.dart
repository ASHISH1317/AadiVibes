// ignore_for_file: deprecated_member_use, lines_longer_than_80_chars

import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/modules/auth/views/enter_otp.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/auth_controller.dart';

/// Enter Phone Number screen
class ContactNumber extends GetView<AuthController> {
  /// Enter Phone Number screen
  const ContactNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Form(
        key: controller.phoneNumberValidateKey,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.k000000,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImage.auth,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    AppImage.appName,
                    color: AppColors.k1DB954,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 20,
                      ),
                      child: Text(
                        'Continue With Mobile \nNumber',
                        style: GoogleFonts.sen(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kffffff,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'By clicking on continue your are agree to',
                            style: GoogleFonts.sen(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kffffff.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'our',
                                style: GoogleFonts.sen(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kffffff.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        style: GoogleFonts.roboto(
                                          color: AppColors.kFFB905,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        text: 'Terms & Conditions',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            const String url =
                                                'https://aadivibes.com/tos/';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              logE('Could not launch $url');
                                            }
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 15,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: AppColors.kffffff,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            CountryCodePicker(
                              onChanged: (CountryCode value) {
                                controller.countryCode(value.dialCode);
                                controller.countryCode.refresh();
                              },
                              padding: const EdgeInsets.only(
                                right: 5,
                              ),
                              flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              textStyle: GoogleFonts.sen(
                                  fontSize: 25,
                                  color: const Color(0xFFC4C4C4),
                                  fontWeight: FontWeight.w500),
                              initialSelection: 'IN',
                              favorite: const <String>['+91', 'IN'],
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: controller.phoneController,
                                maxLines: 10,
                                validator: (String? value) =>
                                    controller.validatePhoneNumber(value!),
                                onChanged: (String value) {
                                  controller.phoneNo(value);
                                  controller.phoneNo.refresh();
                                },
                                onFieldSubmitted: (String value) {
                                  controller.phoneNo(value);
                                  controller.phoneNo.refresh();
                                },
                                style: GoogleFonts.sen(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F1F39),
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 12),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller
                                      .phoneNumberValidateKey.currentState!
                                      .validate()) {
                                    await controller.verifyPhone(
                                      codeSent: (
                                        String _verificationId,
                                        int? resendToken,
                                      ) async {
                                        await LocaleProvider()
                                            .saveResendOtpToken(resendToken);
                                        await LocaleProvider()
                                            .saveVerificationId(
                                                _verificationId);
                                        logI(
                                            'Verification Id $_verificationId');
                                        await EasyLoading.dismiss();
                                        await Get.to<void>(const Otp());
                                      },
                                      phone:
                                          '${controller.countryCode() + controller.phoneController.text}',
                                    );
                                    controller.phoneController.dispose();
                                  }
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8),
                                    color: AppColors.k1DB954,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.navigate_next,
                                      size: 25,
                                      color: AppColors.kffffff,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}

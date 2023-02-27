import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/data/models/response.dart';
import 'package:aadivibes/app/data/remote/firebase_service/user.dart';
import 'package:aadivibes/app/modules/auth/views/enter_otp.dart';
import 'package:aadivibes/app/modules/music/views/music_view.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/components/nav_button.dart';
import 'package:aadivibes/app/ui/components/textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/getname_controller.dart';

/// Get User Name
class GetNameView extends GetView<GetNameController> {
  /// Get User Name
  const GetNameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final bool? shouldPop = await exitAlert(
            nope: false,
            yes: true,
          );
          return shouldPop!;
        },
        child: Form(
          key: controller.nameKey,
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
                      Get.to<void>(const Otp());
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
                    'Enter your name',
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
                  child: Text(
                    'Can we Know your Name Please?',
                    style: GoogleFonts.sen(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kffffff.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 30,
                  ),
                  child: TextFieldConst(
                    controllers: controller.nameController,
                    maxLength: 7,
                    validator: (String? value) =>
                        controller.validateName(value!),
                    onChanged: (String value) {
                      controller.name(value);
                      controller.name.refresh();
                      LocaleProvider().saveName(value);
                    },
                    onFieldSubmitted: (String value) {
                      controller.name(value);
                      LocaleProvider().saveName(value);
                      controller.name.refresh();
                    },
                    hintText: 'Enter your name',
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: NavButton(
                    color: AppColors.k1DB954,
                    height: 0.065,
                    width: 1,
                    onTap: () async {
                      if (controller.nameKey.currentState!.validate()) {
                        await EasyLoading.show();
                        await UserData.addUserData(
                          mobileNo: LocaleProvider().getMobileNumber(),
                          name: controller.nameController.text,
                          profilePicture: '',
                          uid:
                              FirebaseAuth.instance.currentUser!.uid.toString(),
                        ).then((ResponseCode value) {
                          EasyLoading.dismiss();
                          Get.to<void>(() => const MusicView());
                        });
                      }
                      controller.nameController.dispose();
                    },
                    name: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

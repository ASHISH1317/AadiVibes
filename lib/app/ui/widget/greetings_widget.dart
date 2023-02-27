import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/modules/music/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Greetings Widget
Widget greetings(BuildContext context) {
  /// Height
  final double height = MediaQuery.of(context).size.height;

  /// Width
  final double width = MediaQuery.of(context).size.width;

  final MusicController controller = Get.isRegistered<MusicController>()
      ? Get.find<MusicController>()
      : Get.put(MusicController());
  return Container(
    height: height * 0.07,
    width: width * 0.43,
    child: FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      backgroundColor: AppColors.k121212,
      onPressed: () {},
      label: Container(
        height: height * 0.07,
        width: width * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.kffffff.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                controller.greeting(),
                style: GoogleFonts.sen(
                  color: AppColors.k1DB954,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                LocaleProvider().getName(),
                style: GoogleFonts.sen(
                  color: AppColors.kffffff,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

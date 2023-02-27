import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Exit alert dialogue
Future<bool?> exitAlert({bool? yes, bool? nope}) => Get.defaultDialog(
      backgroundColor: AppColors.k000000,
      title: '\nSure you want to exit ?',
      titleStyle: GoogleFonts.sen(
        color: AppColors.kffffff,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      middleText: '',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.01,
          ),
          MaterialButton(
            color: AppColors.kffffff,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Text(
              'Yes',
              style: GoogleFonts.sen(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.k000000,
              ),
            ),
            onPressed: () {
              Navigator.pop(Get.context!, yes);
            },
          ),
          MaterialButton(
            color: AppColors.k1DB954,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Text(
              'Nope',
              style: GoogleFonts.sen(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.kffffff,
              ),
            ),
            onPressed: () {
              Navigator.pop(Get.context!, nope);
            },
          ),
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.01,
          ),
        ],
      ),
    );

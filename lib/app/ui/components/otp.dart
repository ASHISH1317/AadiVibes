import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Otp View
class OtpTextField extends StatelessWidget {
  /// Otp View
  const OtpTextField({
    Key? key,
    this.onSubmit,
    this.onChanged,
    this.controller,
    this.onCompleted,
  }) : super(key: key);

  /// On Changed
  final void Function(String)? onChanged;

  /// on Submit
  final void Function(String)? onSubmit;

  /// on Completed
  final void Function(String)? onCompleted;

  /// Opt Controller
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final PinTheme defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: AppColors.kffffff),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.k1DB954),
      ),
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Pinput(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmit,
            onCompleted: onCompleted,
            length: 6,
            androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: const Color.fromRGBO(23, 171, 144, 1),
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.k1DB954),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: AppColors.k000000,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: AppColors.k1DB954),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }
}

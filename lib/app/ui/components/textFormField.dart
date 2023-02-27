// ignore_for_file: must_be_immutable, file_names

import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// App TextField Component
class TextFieldConst extends StatelessWidget {
  /// App TextField Component
  TextFieldConst({
    Key? key,
    this.onFieldSubmitted,
    this.controllers,
    this.hintText,
    this.onSaved,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixColor,
    this.prefixColor,
    this.onTapSuffixIcon,
    this.obsecure,
    this.hoverColor,
    this.onChanged,
    this.maxLength,
    this.isReadyOnly = false,
    this.onTap,
  }) : super(key: key);

  /// TextEditing Controller
  final TextEditingController? controllers;

  /// Hint Text
  final String? hintText;

  /// TextField Prefix Icon
  final String? prefixIcon;

  /// TextField Suffix Icon
  final String? suffixIcon;

  /// Suffix Icon Color
  final Color? suffixColor;

  /// Prefix Icon Color
  final Color? prefixColor;

  /// OnTap of Suffix Icon
  final Function()? onTapSuffixIcon;

  /// OnSaved Function
  final void Function(String?)? onSaved;

  /// Validator Function
  final String? Function(String?)? validator;

  /// obsecure text bool
  final bool? obsecure;

  /// hover color
  final Color? hoverColor;

  /// Max Length
  final int? maxLength;

  /// On  Filed Submitted func
  final Function(String)? onFieldSubmitted;

  /// On Tap
  void Function()? onTap;

  /// On Changed
  final void Function(String)? onChanged;

  /// Is Read Only
  bool isReadyOnly = false;
  @override
  Widget build(BuildContext context) => TextFormField(
        readOnly: isReadyOnly,
        onChanged: onChanged,
        maxLength: maxLength,
        onTap: onTap,
        autofocus: true,
        cursorColor: AppColors.kffffff.withOpacity(0.30),
        style: GoogleFonts.sen(
          fontSize: 16,
          color: AppColors.kffffff,
          fontWeight: FontWeight.w400,
        ),
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hoverColor: AppColors.kffffff,
          focusColor: AppColors.kffffff,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    prefixIcon!,
                    height: 10,
                    color: prefixColor != null ? prefixColor : null,
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: onTapSuffixIcon != null ? onTapSuffixIcon : null,
                    child: suffixIcon != null && suffixColor != null
                        ? MouseRegion(
                            cursor: MouseCursor.uncontrolled,
                            child: SvgPicture.asset(
                              suffixIcon!,
                              color: suffixColor,
                            ),
                          )
                        : Container(),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          border: InputBorder.none,
          hintText: hintText != null ? hintText : null,
          hintStyle: GoogleFonts.sen(
            fontSize: 16,
            color: AppColors.kffffff.withOpacity(0.50),
            fontWeight: FontWeight.w400,
          ),
        ),
        controller: controllers,
        onSaved: onSaved,
        validator: validator,
        obscureText: obsecure ?? false,
      );
}

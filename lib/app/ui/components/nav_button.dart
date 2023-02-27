import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation Button
class NavButton extends StatelessWidget {
  /// Navigation Button
  const NavButton({
    Key? key,
    this.height,
    this.width,
    this.name,
    this.onTap,
    this.color = AppColors.kffffff,
  }) : super(key: key);

  /// Height
  final double? height;

  /// Width
  final double? width;

  /// Button Name
  final String? name;

  /// Color
  final Color? color;

  /// On Tap Of Button
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            width:
                width == null ? 0 : MediaQuery.of(context).size.width * width!,
            height: height == null
                ? 0
                : MediaQuery.of(context).size.height * height!,
            child: Center(
              child: Text(
                name == null ? '' : name!,
                style: GoogleFonts.sen(
                  fontSize: 14,
                  color: AppColors.kffffff,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
}

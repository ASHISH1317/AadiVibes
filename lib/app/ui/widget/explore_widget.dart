import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/favourite/favourite_view.dart';
import 'package:aadivibes/app/modules/profile/profile_view.dart';
import 'package:aadivibes/app/modules/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Explore Widget
Widget exploreWidget(
  BuildContext context, {
  void Function()? onLike,
  void Function()? onSearch,
  void Function()? onProfile,
}) {
  /// Height
  final double height = MediaQuery.of(context).size.height;

  /// Width
  final double width = MediaQuery.of(context).size.width;
  return Container(
    height: height * 0.07,
    width: width * 0.3,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: onLike ??
              () {
                Get.to<void>(() => const FavouriteView());
              },
          child: SvgPicture.asset(
            AppImage.heart,
          ),
        ),
        GestureDetector(
          onTap: onSearch ??
              () {
                Get.to<void>(() => const SearchView());
              },
          child: SvgPicture.asset(
            AppImage.search,
          ),
        ),
        GestureDetector(
          onTap: onProfile ??
              () {
                Get.to<void>(() => const ProfileView());
              },
          child: SvgPicture.asset(
            AppImage.profile,
          ),
        ),
      ],
    ),
  );
}

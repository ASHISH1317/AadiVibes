import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/favourite/favourite_controller.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/components/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

/// Favourite View
class FavouriteView extends GetView<FavouriteController> {
  /// Favourite Name
  const FavouriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FavouriteController());
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await exitAlert(
          nope: false,
          yes: true,
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.k000000,
          // centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Favourite songs',
            style: GoogleFonts.sen(
              fontSize: 25,
              color: AppColors.kffffff,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: AppColors.k000000,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 25,
              ),
              child: TextFieldConst(
                controllers: controller.searchTextController,
                maxLength: 7,
                onChanged: (String value) {},
                onFieldSubmitted: (String value) {},
                prefixIcon: AppImage.search1,
                hintText: 'Search your favourite song',
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  leading: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.kffffff.withOpacity(0.5),
                      image: const DecorationImage(
                        image: AssetImage(AppImage.birdGrey),
                      ),
                    ),
                  ),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await Share.share('AadiVibes');
                          },
                          child: SvgPicture.asset(
                            AppImage.share,
                            height: 22,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            AppImage.heart,
                            color: AppColors.kffffff,
                            height: 22,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            AppImage.play,
                            height: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    'Song Title',
                    style: GoogleFonts.sen(
                      fontSize: 15,
                      color: AppColors.kffffff,
                    ),
                  ),
                  subtitle: Text(
                    'Sub title',
                    style: GoogleFonts.sen(
                      fontSize: 12,
                      color: AppColors.kffffff,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

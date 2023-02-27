import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/music/controllers/music_controller.dart';
import 'package:aadivibes/app/modules/search/search_controller.dart';
import 'package:aadivibes/app/ui/components/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

/// Search Songs Screen
class SearchSongs extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.k000000,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 45,
              ),
              child: TextFieldConst(
                //controllers: controller.nameController,
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
                  vertical: 10,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListTile(
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
            ),
          ],
        ),
      );
}

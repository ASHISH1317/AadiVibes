import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/search/search_controller.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/components/search_song_screen.dart';
import 'package:aadivibes/app/ui/components/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

/// Search View
class SearchView extends GetView<SearchController> {
  /// Search Name
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchController());

    /// Height
    final double height = MediaQuery.of(context).size.height;

    /// Width
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await exitAlert(
          nope: false,
          yes: true,
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: AppColors.k000000,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 45,
                ),
                child: TextFieldConst(
                  controllers: controller.searchTextController,
                  onTap: () {
                    Get.to<void>(() => SearchSongs());
                  },
                  maxLength: 7,
                  isReadyOnly: true,
                  prefixIcon: AppImage.search1,
                  hintText: 'Search your favourite song',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  'Artist You May Like',
                  style: GoogleFonts.sen(
                    fontSize: 20,
                    color: AppColors.kffffff,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Row(
                  children: List<Widget>.generate(
                    5,
                    (int index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kffffff.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                              image: AssetImage(AppImage.birPink),
                            ),
                          ),
                          width: width * 0.25,
                          height: height * 0.11,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            'Artist name',
                            style: GoogleFonts.sen(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kffffff,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  'Playlist You May Like',
                  style: GoogleFonts.sen(
                    fontSize: 20,
                    color: AppColors.kffffff,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Row(
                  children: List<Widget>.generate(
                    5,
                    (int index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kffffff.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/theme.png'),
                            ),
                          ),
                          width: width * 0.25,
                          height: height * 0.11,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            'Playlist name',
                            style: GoogleFonts.sen(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kffffff,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  'Categories May You Like',
                  style: GoogleFonts.sen(
                    fontSize: 20,
                    color: AppColors.kffffff,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Row(
                  children: List<Widget>.generate(
                    5,
                    (int index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kffffff.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                              image: AssetImage(AppImage.birdYellow),
                            ),
                          ),
                          width: width * 0.25,
                          height: height * 0.11,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            'Category type',
                            style: GoogleFonts.sen(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kffffff,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  'Mixed songs',
                  style: GoogleFonts.sen(
                    fontSize: 20,
                    color: AppColors.kffffff,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListTile(
                      leading: Container(
                        width: width * 0.15,
                        height: height * 0.065,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

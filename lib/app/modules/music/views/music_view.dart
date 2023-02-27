import 'dart:math';
import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/ui/components/app_snackbar.dart';
import 'package:aadivibes/app/ui/components/bottom_sheet.dart';
import 'package:aadivibes/app/ui/components/exit_confirmation.dart';
import 'package:aadivibes/app/ui/widget/explore_widget.dart';
import 'package:aadivibes/app/ui/widget/greetings_widget.dart';
import 'package:aadivibes/app/utils/time_formate.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/music_controller.dart';
import 'package:flutter/material.dart';

/// Dashboard View
class MusicView extends GetView<MusicController> {
  /// Dashboard view
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MusicController());
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final bool? shouldPop = await exitAlert(
          yes: false,
          nope: false,
        );
        return shouldPop!;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: width,
            height: height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                greetings(context),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 35,
                  ),
                  child: exploreWidget(context),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.k000000,
        body: ExpandablePageView.builder(
          physics: const BouncingScrollPhysics(),
          animationCurve: Curves.easeIn,
          scrollDirection: Axis.vertical,
          animationDuration: const Duration(milliseconds: 250),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            final int generatedColor =
                Random().nextInt(Colors.primaries.length);
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: /*AppColors.k000000,*/
                  Colors.primaries[generatedColor].withOpacity(0.15),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Column(
                    children: <Widget>[
                      Container(
                        height: height * 0.32,
                        width: width * 0.72,
                        decoration: BoxDecoration(
                          color: /*AppColors.k121212,*/
                              Colors.primaries[generatedColor].withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(
                          //   color: AppColors.k1DB954,
                          //   width: 2,
                          // ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: <Widget>[
                          Text(
                            'Song Name',
                            style: GoogleFonts.sen(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kffffff,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Artist name ',
                            style: GoogleFonts.sen(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kffffff,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 70,
                      ),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              controller.isVolume(
                                !controller.isVolume(),
                              );
                            },
                            child: SvgPicture.asset(
                              controller.isVolume()
                                  ? AppImage.volumeSlash
                                  : AppImage.volumeHigh,
                              color: controller.isVolume()
                                  ? Colors.red
                                  : AppColors.kffffff,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.isShuffle(
                                !controller.isShuffle(),
                              );
                              if (controller.isShuffle()) {
                                appSnackbar(message: 'Shuffle mode on');
                              }
                            },
                            child: SvgPicture.asset(
                              AppImage.suffule,
                              color: controller.isShuffle()
                                  ? AppColors.k1DB954
                                  : AppColors.kffffff,
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              controller.isRepeat(
                                !controller.isRepeat(),
                              );
                              if (controller.isRepeat()) {
                                appSnackbar(message: 'Repeat mode on');
                              }
                            },
                            child: SvgPicture.asset(
                              controller.isRepeat()
                                  ? AppImage.repeatActive
                                  : AppImage.repeat,
                              color: controller.isRepeat()
                                  ? AppColors.k1DB954
                                  : AppColors.kffffff,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 35,
                      ),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              controller.isPlay(
                                !controller.isPlay(),
                              );
                            },
                            child: SvgPicture.asset(
                              controller.isPlay()
                                  ? AppImage.pause
                                  : AppImage.play,
                              height: 35,
                              color: AppColors.kffffff,
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () async {
                              await Share.share('AadiVibes');
                            },
                            child: SvgPicture.asset(
                              AppImage.share,
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              controller.isLiked(
                                !controller.isLiked(),
                              );
                              if (controller.isLiked()) {
                                appSnackbar(
                                  snackbarState: SnackbarState.success,
                                  message: 'Added to favourite songs',
                                );
                              }
                            },
                            child: SvgPicture.asset(
                              AppImage.heart,
                              color: controller.isLiked()
                                  ? Colors.red
                                  : AppColors.kffffff,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                  )),
                                  builder: (BuildContext context) =>
                                      const DashBoardBottomSheet());
                            },
                            child: SvgPicture.asset(
                              AppImage.more,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${timeFormat(
                                      controller.currentSongDuration(),
                                    )}',
                                    style: GoogleFonts.sen(
                                      color: AppColors.kffffff.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${timeFormat(
                                      controller.currentSongDuration() -
                                          controller.totalSongDuration(),
                                    )}',
                                    style: GoogleFonts.sen(
                                      color: AppColors.kffffff.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SfSliderTheme(
                            data: SfSliderThemeData(
                              inactiveTrackHeight: 1.5,
                              activeTrackHeight: 2,
                              thumbStrokeWidth: 2,
                              thumbRadius: 4,
                            ),
                            child: SfSlider(
                              onChanged: (dynamic value) {
                                controller.sliderVal(value);
                              },
                              value: controller.sliderVal(),
                              showTicks: true,
                              min: controller.minValue(),
                              max: controller.maxValue(),
                              activeColor: AppColors.kffffff,
                              inactiveColor: AppColors.kffffff.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: AppColors.k1E1E1E,
//         body: Obx(
//           () => <Widget>[
//             Music(),
//             Search(),
//             Profile(),
//           ][controller.selectedIndex()],
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       );
//   Container _buildBottomBar(BuildContext context) => Container(
//         height: MediaQuery.of(context).size.height * 0.08,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           color: AppColors.k1DB954,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Obx(
//           () => BottomNavigationBar(
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             type: BottomNavigationBarType.fixed,
//             unselectedItemColor: const Color(0xFF26556F).withOpacity(0.25),
//             selectedItemColor: const Color(0xFF26556F),
//             backgroundColor: AppColors.k000000,
//             elevation: 0,
//             currentIndex: controller.selectedIndex(),
//             onTap: (int index) {
//               controller.selectedIndex(index);
//             },
//             items: <BottomNavigationBarItem>[
//               _buildBottomNavigationBarItem(
//                 context,
//                 icon: AppImage.music,
//               ),
//               _buildBottomNavigationBarItem(
//                 context,
//                 icon: AppImage.search,
//               ),
//               _buildBottomNavigationBarItem(
//                 context,
//                 icon: AppImage.profile,
//               ),
//             ],
//           ),
//         ),
//       );
//   BottomNavigationBarItem _buildBottomNavigationBarItem(BuildContext context,
//           {required String icon}) =>
//       BottomNavigationBarItem(
//         backgroundColor: Colors.transparent,
//         activeIcon: SvgPicture.asset(
//           icon,
//           height: 25,
//           color: AppColors.k1DB954,
//         ),
//         icon: SvgPicture.asset(
//           icon,
//           height: 25,
//           width: 25,
//           color: AppColors.kffffff,
//         ),
//         label: '',
//       );
// }
}

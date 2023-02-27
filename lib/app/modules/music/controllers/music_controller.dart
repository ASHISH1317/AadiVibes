// ignore_for_file: avoid_catches_without_on_clauses, unnecessary_null_comparison, lines_longer_than_80_chars

import 'dart:io';

import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/local/user_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Dashboard Controller
class MusicController extends GetxController {
  /// DashBoard Controller

  /// On Init
  @override
  void onInit() {
    UserProvider.userData;

    super.onInit();
  }

  /// On Ready
  @override
  void onReady() {
    super.onReady();
  }

  /// On Close
  @override
  void onClose() {
    super.onClose();
  }

  /// User Name
  RxString name = ''.obs;

  /// Selected index of bottom navbar
  RxInt selectedIndex = 0.obs;

  /// Slider min val
  RxDouble minValue = 0.0.obs;

  /// Slider max val
  RxDouble maxValue = 10.0.obs;

  /// Slider val
  RxDouble sliderVal = 0.0.obs;

  /// Total Duration
  Rx<Duration> totalSongDuration = Duration.zero.obs;

  /// Current Duration
  Rx<Duration> currentSongDuration = Duration.zero.obs;

  /// Is Song is played bool
  RxBool isPlay = false.obs;

  /// Is Liked the song bool
  RxBool isLiked = false.obs;

  /// Is Shuffle song
  RxBool isShuffle = false.obs;

  /// Is Repeat
  RxBool isRepeat = false.obs;

  /// Is Volume Active or not
  RxBool isVolume = false.obs;

  /// Play Tapped in Search View
  RxBool isPlayInSearch = false.obs;

  /// Is Liked Tapped in Search Button
  RxBool isLikedInSearch = false.obs;

  /// Greetings
  String greeting() {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning ❤';
    }
    if (hour < 17) {
      return 'Good Afternoon ❤';
    }
    return 'Good Evening ❤';
  }

  /// image Picker Instance
  ImagePicker picker = ImagePicker();

  /// File
  File? file;

  /// Profile Image Picker
  Future<void> profileImagePicker(ImageSource source) async {
    try {
      // ignore: deprecated_member_use
      final PickedFile? path = await picker.getImage(source: source);
      file = File(path!.path);
      update();
      if (path == null) {
        Get.back<void>();
      } else {
        Get.back<void>();
      }
    } catch (e) {
      logE(e.toString());
    }
  }
}

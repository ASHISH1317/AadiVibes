import 'package:get/get.dart';

import '../controllers/music_controller.dart';

/// Dashboard binding
class MusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicController>(
      () => MusicController(),
    );
  }
}

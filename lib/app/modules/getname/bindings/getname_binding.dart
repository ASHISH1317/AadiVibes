import 'package:get/get.dart';

import '../controllers/getname_controller.dart';

/// Get name binding
class GetNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetNameController>(
      () => GetNameController(),
    );
  }
}

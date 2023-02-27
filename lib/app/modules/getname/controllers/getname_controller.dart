import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// Get Name Controller
class GetNameController extends GetxController {
  /// On Init
  @override
  void onInit() {
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
    nameController.dispose();
    super.onClose();
  }

  /// Validate Name Key
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  /// User Name
  RxString name = ''.obs;

  /// Name controller
  TextEditingController nameController = TextEditingController();

  /// Validate Password Function
  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter name';
    }
    return null;
  }
}

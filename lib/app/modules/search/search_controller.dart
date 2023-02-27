import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Search Controller
class SearchController extends GetxController {
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
    searchTextController.dispose();
    super.onClose();
  }

  /// Search Text Controller
  TextEditingController searchTextController = TextEditingController();
}

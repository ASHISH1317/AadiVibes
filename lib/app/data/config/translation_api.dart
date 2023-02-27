import 'package:get/get.dart';
import 'package:aadivibes/generated/locales.g.dart';

// ignore_for_file: public_member_api_docs

class AppTranslations extends Translations {
  late Map<String, Map<String, String>> map;

  @override
  Map<String, Map<String, String>> get keys => map;
}

class TranslationApi {
  static void loadTranslations() {
    final Map<String, Map<String, String>> map = AppTranslation.translations;
    Get.find<AppTranslations>().map = map;
  }
}

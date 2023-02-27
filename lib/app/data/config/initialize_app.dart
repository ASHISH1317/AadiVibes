import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:aadivibes/app/data/config/logger.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';
import 'package:aadivibes/app/data/local/theme_provider.dart';
import 'package:aadivibes/app/data/local/user_provider.dart';
import 'package:aadivibes/app/data/remote/api_service/init_api_service.dart';
import 'package:aadivibes/app/data/remote/notifications/firebase_notifications.dart';
import 'package:aadivibes/app/data/remote/notifications/notification_actions.dart';

/*late String kDevelopmentApiBaseUrl;
late String kProductionApiBaseUrl;*/

/// Initialize all core functionalities
Future<void> initializeCoreApp({
  required String? developmentApiBaseUrl,
  required String? productionApiBaseUrl,
  bool firebaseApp = true,
  bool setupLocalNotifications = false,
  bool encryption = false,
}) async {
  //Activate logger
  initLogger();

  //Firebase products initializations
  if (firebaseApp) {
    await Firebase.initializeApp();
    notificationActions(
      action: notificationAction,
      localNotification: setupLocalNotifications,
      localNotificationAction: localNotificationAction,
    );
  }
  /*if (developmentApiBaseUrl != null) {
    kDevelopmentApiBaseUrl = developmentApiBaseUrl;
  }
  if (productionApiBaseUrl != null) {
    kProductionApiBaseUrl = productionApiBaseUrl;
  }*/

  await GetStorage.init();
  UserProvider.loadUser();
  LocaleProvider.loadCurrentLocale();
  await ThemeProvider.getThemeModeFromStore();

  if (productionApiBaseUrl != null && developmentApiBaseUrl != null) {
    APIService.initializeAPIService(
      encryptData: encryption,
      devBaseUrl: developmentApiBaseUrl,
      prodBaseUrl: productionApiBaseUrl,
    );
  }
}

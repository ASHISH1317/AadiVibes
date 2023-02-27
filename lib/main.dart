import 'dart:async';

import 'package:aadivibes/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:aadivibes/app/data/config/app_themes.dart';
import 'package:aadivibes/app/data/config/design_config.dart';
import 'package:aadivibes/app/data/config/error_handling.dart';
import 'package:aadivibes/app/data/config/initialize_app.dart';
import 'package:aadivibes/app/utils/app_utils.dart';

import 'package:catcher/catcher.dart';
import 'package:aadivibes/app/data/config/translation_api.dart';
import 'package:aadivibes/app/data/local/locale_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Debug configuration with dialog report mode and console handler.
  /// It will show dialog and once user accepts it, error will be shown
  /// in console.
  final CatcherOptions debugOptions = CatcherOptions(
    SilentReportMode(),
    //PageReportMode(),
    <ReportHandler>[
      ConsoleHandler(),
    ],
    handleSilentError: false,
  );

  /// Release configuration. Same as above, but once user accepts dialog,
  /// user will be prompted to send email with crash to support.
  final CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    <ReportHandler>[
      DiscordHandler(
        'https://ptb.discord.com/api/webhooks/850803931922956296/ntypKkhc1XnGLxy01FZLmwCecy0VE3xZQH_5phYR3zb9Izs4aosSfcJ74_IED3BbdHDP',
        printLogs: true,
        enableApplicationParameters: true,
        enableDeviceParameters: true,
        enableStackTrace: true,
      ),
    ],
    handleSilentError: false,
  );

  Catcher(
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    ensureInitialized: true,
    navigatorKey: GlobalKey<NavigatorState>(),
    runAppFunction: () async {
      await runZonedGuarded(
        () async {
          Get.put(AppTranslations());
          TranslationApi.loadTranslations();
          await initializeCoreApp(
            // Set it to true when including firebase app
            firebaseApp: false,
            developmentApiBaseUrl: 'developmentApiBaseUrl',
            productionApiBaseUrl: 'productionApiBaseUrl',
          );
          runApp(
            const StartTheApp(),
          );
        },
        (Object error, StackTrace trace) {
          letMeHandleAllErrors(error, trace);
          Catcher.reportCheckedError(error, trace);
        },
      );
    },
  );

  //Restrict orientation to Portrait
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  ///To catch widget errors
  /*FlutterError.onError = (errorDetails) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      letMeHandleAllErrors(errorDetails.exception, errorDetails.stack);
      Catcher.reportCheckedError(errorDetails.exception, errorDetails.stack);
    });
  };*/
}

/// App starter
class StartTheApp extends StatelessWidget {
  /// Constructor
  const StartTheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: ScreenUtilInit(
          designSize: const Size(
            DesignConfig.kDesignWidth,
            DesignConfig.kDesignHeight,
          ),
          builder: (BuildContext context, Widget? widget) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: Catcher.navigatorKey,
            title: 'AadiVibes',
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            translationsKeys: Get.find<AppTranslations>().keys,
            translations: Get.find<AppTranslations>(),
            locale: LocaleProvider.currentLocale,
            fallbackLocale: const Locale('en_US'),
            defaultTransition: Transition.cupertino,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            builder: EasyLoading.init(),
          ),
        ),
      );
}

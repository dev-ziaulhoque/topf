import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tophf0_app/app/modules/chatbot/views/chatbot_view.dart';
import 'package:tophf0_app/app/modules/notification_setting/views/notification_setting_view.dart';

import 'app/app_config/app_config.dart';
import 'app/data/services/notificaiton_manager.dart';
import 'app/modules/travelbooking/views/travelbooking_view.dart';
import 'app/routes/app_pages.dart';

// DevicePreview import
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationManager().initialize();

  /// init local storage
  await GetStorage.init();

  /// dotenv
  await dotenv.load(fileName: ".env");
  AppConfig.init();

  runApp(
    DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => GetMaterialApp(
        title: "Application",
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        // initialRoute: AppPages.INITIAL,
        // getPages: AppPages.routes,
        // home: NotificationSettingView(),
        home: TravelbookingView(),
      ),
    ),
  );
}

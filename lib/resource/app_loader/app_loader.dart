// app_loader.dart
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

class AppLoader {
  AppLoader._();

  static void configure() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..indicatorSize = 45.0
      ..radius = 12.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black87
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black.withOpacity(0.3)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void show({String? message}) {
    EasyLoading.show(
      status: message ?? 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void success(String message, {int duration = 2}) {
    EasyLoading.showSuccess(
      message,
      duration: Duration(seconds: duration),
      maskType: EasyLoadingMaskType.none,
    );
  }

  static void error(String message, {int duration = 3}) {
    EasyLoading.showError(
      message,
      duration: Duration(seconds: duration),
      maskType: EasyLoadingMaskType.none,
    );
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
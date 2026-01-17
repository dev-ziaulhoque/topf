// lib/utils/logger_helper.dart

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: kDebugMode ? Level.trace : Level.off, // Only log in debug mode
    output: MultiOutput([
      ConsoleOutput(),          // Default console output
      // FileOutput(file: File('logs/app_log.txt')), // Uncomment for file logging
    ]),
  );

  // Private constructor
  Log._();

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  // Helper to log with class context automatically
  static void auto(Object context, dynamic message) {
    final className = context.runtimeType.toString();
    _logger.i("[$className] $message");
  }
}

/*
Feature                          | How It Works                                      | Why It’s Useful
---------------------------------------------------------------------------------------------------------------
Logs only in Debug mode          | level: kDebugMode ? Level.trace : Level.off        | No logs printed in release builds → better performance & security
Colorful + Emoji + Timestamp     | Using PrettyPrinter                                | Logs become clean, readable, and easier to understand with emojis
Different log levels             | "v, d, i, w, e, wtf"                               | Verbose → Debug → Info → Warning → Error → WTF (fatal)
Automatic StackTrace for errors  | e() and wtf() auto-include StackTrace.current       | Helps find the exact crash line without extra code
.auto() method                   | Log.auto(this, "User logged in") adds class name   | No need to manually write class names → cleaner, maintainable code
*/

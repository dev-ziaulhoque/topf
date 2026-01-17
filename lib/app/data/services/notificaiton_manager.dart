import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  // Available notification sounds
  final Map<String, String> availableSounds = {
    'love_it_heart_1': 'Love It Heart',
    'notification_tone_2': 'Notification Tone 2',
    'notification_tone_3': 'Notification Tone 3',
    'notification_tone_4': 'Notification Tone 4',
  };

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  // Save selected sound to preferences
  Future<void> saveNotificationSound(String soundKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notification_sound', soundKey);
  }

  // Get current notification sound
  Future<String> getNotificationSound() async {
    final prefs = await SharedPreferences.getInstance();
    // Use first sound as default instead of 'default'
    return prefs.getString('notification_sound') ?? 'love_it_heart_1';
  }

  // Show notification with custom sound
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? customSound,
  }) async {
    final soundKey = customSound ?? await getNotificationSound();

    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'Main notification channel',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(soundKey),
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: '$soundKey.mp3',
    );

    final NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      id,
      title,
      body,
      platformDetails,
    );
  }
}
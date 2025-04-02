// // services/notification_service.dart
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   // static final _notifications = FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iOS = DarwinInitializationSettings();
//     const settings = InitializationSettings(android: android, iOS: iOS);

//     await _notifications.initialize(settings);
//   }

//   static Future<void> scheduleDailyReminder() async {
//     const android = AndroidNotificationDetails(
//       'daily_highlight_channel',
//       'Daily Highlights',
//       importance: Importance.high,
//     );
//     const iOS = DarwinNotificationDetails();
//     const details = NotificationDetails(android: android, iOS: iOS);

//     await _notifications.periodicallyShow(
//       0,
//       'Daily Highlight',
//       'What\'s your highlight for today?',
//       RepeatInterval.daily,
//       details,
//     );
//   }
// }

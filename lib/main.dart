import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:call_poc_2/pages/AgoraCall.dart';
import 'package:call_poc_2/pages/httpUtils.dart';
import 'package:call_poc_2/pages/login.dart';
import 'package:call_poc_2/settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        _processMessage(remoteMessage, context);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        _processMessage(remoteMessage, context);
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then(
          (remoteMessage) => setState(
            () {
              if (remoteMessage != null) {
                _processMessage(remoteMessage, context);
              }
            },
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage());
  }
}

Future<void> _processMessage(
  RemoteMessage? remoteMessage,
  BuildContext context,
) async {
  var data = json.decode(remoteMessage?.data['payload']);
  Map<String, String> params = {};
  params["order_id"] = data['order_id'];
  params["status"] = "1";
  String url = baseUrl + "order_controller/call_status";
  HttpUtils().post(url, params);
  navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (ctx) => AgoraCall(
            channelName: data['channel_name'],
            role: ClientRole.Audience,
          )));
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('launch_background');
  var initSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: null);

  flutterLocalNotificationsPlugin.initialize(initSettings,
      onDidReceiveNotificationResponse: _processMessage2,
      onDidReceiveBackgroundNotificationResponse: _processMessage2);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

int id = 0;
void showFlutterNotification(RemoteMessage message) {
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // if (notification != null && android != null) {
  flutterLocalNotificationsPlugin.show(
      id++,
      "Calling",
      "You got a call from NH app",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
            timeoutAfter: 10000,
            actions: [
              const AndroidNotificationAction("ok", "Accept",
                  cancelNotification: false, showsUserInterface: true),
              const AndroidNotificationAction("cancel", "Reject",
                  cancelNotification: true, showsUserInterface: false)
            ]),
      ),
      payload: message.data['payload']);
  //}
}

@pragma('vm:entry-point')
void _processMessage2(NotificationResponse remoteMessage) {
  var data = json.decode(remoteMessage.payload!);
  Map<String, String> params = {};
  params["order_id"] = data['order_id'];
  params["status"] = "1";
  String url = baseUrl + "order_controller/call_status";
  HttpUtils().post(url, params);
  navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (ctx) => AgoraCall(
            channelName: data['channel_name'],
            role: ClientRole.Audience,
          )));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

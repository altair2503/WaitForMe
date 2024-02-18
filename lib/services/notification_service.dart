import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:wait_for_me/models/bus_model.dart';

class NotificationService {
  static NotificationService? _instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final cloudMessagingAPI =
      'AAAAVz_7iFQ:APA91bGhwz3gGn3l4kLl1jqxWYxzDJC4uRLFun4IRi5_OU1f6f6gng37pKTSFZ1WzLGFW4ox6s_ozW2cs7xp1J5YdNjMtrWqNydnFlvA0FuAWWzMKR-WfEWFbuv904DXCR0qdCs1o2vj';

  static NotificationService? get instance {
    if (_instance == null) {
      _instance = NotificationService._();
      return _instance;
    }
    return _instance;
  }

  NotificationService._();

  initialize() {
    _instance = NotificationService._();
  }

  Future<void> getAllBusDriverDeviceTokens(List<Bus> busNumbers) async {
    final List<String> driverDeviceTokens = [];
    for (int i = 0; i < busNumbers.length; i++) {
      print('Number: ${busNumbers[i].number}');
      final buses = FirebaseFirestore.instance.collection('buses');
      QuerySnapshot querySnapshot = await buses.get();
      List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (int i = 0; i < dataList.length; i++) {
        if (busNumbers
            .map((bus) => bus.number)
            .contains(dataList[i]['number'])) {
          print("contains ${busNumbers[i].number}");
          for (int j = 0; j < dataList[i]['drivers_id'].length; j++) {
            print(dataList[i]['drivers_id'][j]);
            driverDeviceTokens
                .add(dataList[i]['drivers_id'][j]['device_token']);
            sendNotification(dataList[i]['drivers_id'][j]['device_token']);
          }
        } else {
          print("not contains ${busNumbers[i].number}");
        }
      }
    }
  }

  void sendNotification(String driverDeviceToken) async {
    print(driverDeviceToken);
    var data = {
      'to': driverDeviceToken,
      'notification': {
        'title': 'Wait for me',
        'body': 'One person waiting for you',
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': 'Asif Taj'}
    };

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$cloudMessagingAPI'
        }).then((value) {
      if (kDebugMode) {
        print(value.body.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('pn-sound')
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(), channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      // sound: channel.sound
      // sound: const RawResourceAndroidNotificationSound('pn-sound')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      print('Message data: ${message.data['id']}');
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => MessageScreen(
      //       id: message.data['id'] ,
      //     )));
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}


  // Future<void> sendNotification() async {
  //   print("sendNotification");
  //   final data = {
  //     'to': await getDeviceToken(),
  //     'priority': 'high',
  //     'notification': {
  //       'title': 'Wait for me',
  //       'body': 'One person waiting for you'
  //     },
  //   };

  //   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       body: jsonEncode(data),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'key=$cloudMessagingAPI'
  //       });
  // }

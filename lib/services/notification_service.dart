import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wait_for_me/auth/auth_service.dart';

import 'package:wait_for_me/models/bus_model.dart';


class NotificationService {

  static NotificationService? _instance;
  
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final cloudMessagingAPI = 'AAAAVz_7iFQ:APA91bGhwz3gGn3l4kLl1jqxWYxzDJC4uRLFun4IRi5_OU1f6f6gng37pKTSFZ1WzLGFW4ox6s_ozW2cs7xp1J5YdNjMtrWqNydnFlvA0FuAWWzMKR-WfEWFbuv904DXCR0qdCs1o2vj';

  static NotificationService? get instance {
    if(_instance == null) {
      _instance = NotificationService._();
      return _instance;
    }
    return _instance;
  }

  NotificationService._();

  initialize() {
    _instance = NotificationService._();
  }

  Future<void> sendNotificationToDrivers(List<Bus> busNumbers, String text) async {
    for(int i = 0; i < busNumbers.length; i++) {
      print('Number: ${busNumbers[i].number}');
      
      final buses = FirebaseFirestore.instance.collection('buses');
      
      QuerySnapshot querySnapshot = await buses.get();
      
      List<Map<String, dynamic>> dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

      for(int i = 0; i < dataList.length; i++) {
        print('getAllBusDriverDeviceTokens ${dataList[i]['number']}');
        if(busNumbers.map((bus) => bus.number).contains(dataList[i]['number'])) {
          // print("getAllBusDriverDeviceTokens contains ${busNumbers[i].number}");
          for(int j = 0; j < dataList[i]['drivers_id'].length; j++) {
            print('getAllBusDriverDeviceTokens ${dataList[i]['drivers_id'][j]}');
            
            final docRef = FirebaseFirestore.instance.collection("users").doc(dataList[i]['drivers_id'][j]);
            docRef.get().then(
              (DocumentSnapshot doc) {
                final data = doc.data() as Map<String, dynamic>;
                notificationSender(data['device_token'],
                'Wait for me', text);
              },
              onError: (e) => print("Error getting document: $e"),
            );
          }
        } 
        else {
          print("getAllBusDriverDeviceTokens not contains");
        }
      }
    }
  }

  void notificationSender(
    String deviceToken, 
    String title, 
    String bodyText
  ) async {
    print('-> sendNotification');
    print('-> sendNotification $deviceToken');
    print('-> sendNotification $title');
    print('-> sendNotification $bodyText');

    var data = {
      'to': deviceToken,
      'notification': {
        'title': title,
        'body': bodyText,
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': ''}
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$cloudMessagingAPI'
      }
    )
    .then((value) {
      if(kDebugMode) {
        print(value.body.toString());
      }
    })
    .onError((error, stackTrace) {
      if(kDebugMode) {
        print(error);
      }
    });
  }

  void initLocalNotifications(
    BuildContext context, 
    RemoteMessage message
  ) async {
    var androidInitializationSettings =  const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if(kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if(Platform.isIOS) {
        forgroundMessage();
      }

      if(Platform.isAndroid) {
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

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      if(kDebugMode) {
        print('user granted permission');
      }
    } 
    else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
      if(kDebugMode) {
        print('user granted provisional permission');
      }
    } 
    else {
      if(kDebugMode) {
        print('user denied permission');
      }
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

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

  // Handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // When app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if(message.data['type'] == 'msj') {
      print('Message data: ${message.data['id']}');
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<bool> addUserDevice(String userDeviceToken) async {
    try {
      final user = await AuthService.firebase().getCurrentUser();
      if(user != null) {
        final userRef = FirebaseFirestore.instance.collection("users").doc(user.id);
        userRef.update({"device_token": userDeviceToken});
        return true;
      }
    } 
    catch(e) {
      print("Error updating document: $e");
    }

    return false;
  }

}
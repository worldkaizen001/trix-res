import 'package:restaurant/services/local_notiti.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// late final LocalNotificationService service;

// LocalNotificationService localNotificationService = LocalNotificationService();

// final firebaseInstance = FirebaseMessaging.instance;

class FirebaseHandler {
  final firebaseInstance = FirebaseMessaging.instance;

  static Future<void> init() async {
    
    Future backgroundMsgHandler(RemoteMessage message) async {
      var title = message.notification?.title;
      var body = message.notification?.body;
      await LocalNoti.showJustNotification(id: 2, title: title ?? "", body: body ?? "");
    }

    // //Background
    FirebaseMessaging.onBackgroundMessage(backgroundMsgHandler);

    //onLaunch
    /**
       * When the app is completely closed (not in the background) 
       * and opened directly from the push notification
       */
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      // handleNotification(event?.data);
    });

    //onMessage
    /**
       * When the app is open and it receives a push notification
       */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var title = message.notification?.title;
      var body = message.notification?.body;
      await LocalNoti.showJustNotification(id: 2, title: title ?? "", body: body ?? "");

     

      print('bckground2 called ----------');

      // localNotificationService.showNotificationWithPayload(
      //     id: 3, title: 'pay', body: message.data.toString(), payload: '');
    });

    //onResume
    /**
       * When the app is in the background and is opened directly 
       * from the push notification.
       */
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // handleNotification(message.data);
    });
  }

  void grantPermission() async {
    NotificationSettings settings = await firebaseInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String?> getToken() async {
    var token = await firebaseInstance.getToken().then((token) {
      return token;
    });

    print("this is your fcm token: $token");

    return token;
  }
}

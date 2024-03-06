import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/controllers/providers/notification_provider.dart';
import 'package:restaurant/controllers/providers/stores_provider.dart';

import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/services/firebase_handler.dart';
import 'package:restaurant/services/local_notiti.dart';
import 'package:restaurant/views/delivery_details.dart';
import 'package:restaurant/views/forget_password/view/create_new_password.dart';
import 'package:restaurant/views/forget_password/view/forget_password.dart';
import 'package:restaurant/views/forget_password/view/forget_password_otp.dart';
import 'package:restaurant/views/homepage/view/homepage.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/views/notification/view/notification_screen.dart';
import 'package:restaurant/views/onboarding/view/onboarding.dart';
import 'package:restaurant/views/orders/view/order_details.dart';
import 'package:restaurant/views/orders/view/orders.dart';
import 'package:restaurant/views/register/view/otp_screen.dart';
import 'package:restaurant/views/register/view/register_screen.dart';
import 'package:restaurant/views/rewards/view/reward.dart';
import 'package:restaurant/views/splash_screen/splash_screen.dart';
import 'package:restaurant/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 
//   await Firebase.initializeApp();

// }

// final firebaseInstance = FirebaseMessaging.instance;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await Firebase.initializeApp();
  // FirebaseHandler.init();

  // void grantPermission() async {
  //   NotificationSettings settings = await firebaseInstance.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => StoreProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),

  ], child: const MyApp()));
}

//  runApp(
//  DevicePreview(
//   enabled: true,
//   builder: (context) => MyApp(), // Wrap your app
// ),

//  );
 

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // LocalNoti.initialize(LocalNoti.localNotificationService);

    
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        // builder: (context, child) {
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //     child: child!,
        //   );
        // },
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Vita Fruity',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorManager.primaryColor),
          useMaterial3: true,
        ),
        home: const 
         SplashScreen(),
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

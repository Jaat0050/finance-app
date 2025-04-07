import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/offers.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/upload_doc.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/onboarding_screen.dart';
import 'package:mitra_fintech_agent/app/controller/commission_controller.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:uni_links/uni_links.dart';

import 'app/utils/constants.dart';

var box;
bool? isLoggedIn = false;
bool? isFirstTime = true;
bool? isAccountDeleted = false;
List homeProducts = [];
String deviceType = '';
String appVersion = '';

Future<void> version() async {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    appVersion = packageInfo.version;
    if (defaultTargetPlatform == TargetPlatform.android) {
      deviceType = "android";
    } else {
      deviceType = "ios";
    }
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 11,
    channelKey: 'basic_channel',
    title: message.notification!.title,
    body: message.notification!.body,
    notificationLayout: NotificationLayout.BigPicture,
    bigPicture: message.notification!.android!.imageUrl,
  ));
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    try {
      await _initializePrefs();
    } catch (e) {
      log(e.toString());
    }
    await Hive.initFlutter().then((value) async {
      await Hive.openBox('myBox').then((value) => box = Hive.box('myBox'));
    });
    try {
      await Firebase.initializeApp().then((value) async {
        version();
        final fcmToken = await FirebaseMessaging.instance.getToken();
      

        if (SharedPreferencesHelper.getIsLoggedIn()) {
          apiValue.registerToken(fcmToken!, deviceType);
          apiValue.registerAppVersion(appVersion, deviceType);
        }
      });
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    } catch (e) {
      log(e.toString());
    }
    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

Future<void> _requestSmsPermission() async {
  var status = await Permission.sms.request();
  if (status.isGranted) {
    SmsAutoFill().listenForCode;
  }
}

Future<void> _initializePrefs() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: MyColors.blue,
    statusBarIconBrightness: Brightness.light,
  ));
  await SharedPreferencesHelper.init();
  isFirstTime = SharedPreferencesHelper.getisFirstTime();
  isLoggedIn = SharedPreferencesHelper.getIsLoggedIn();
  isAccountDeleted = SharedPreferencesHelper.getisAccountDeleted();

  if (Platform.isAndroid) WebView.platform = AndroidWebView();
  if (SharedPreferencesHelper.getIsLoggedIn()) {
    await apiValue.agentActivity();
  }
  late CommissionController commissionController;
  commissionController = Get.put(CommissionController());
  await Future.wait([
    commissionController.getCommissionDetails(),
  ]);

  var loansData = await apiValue.getLoansTypeDetails();
  if (loansData != null) {
    homeProducts = loansData;
  }

  _requestSmsPermission();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deepLink = "No deep link";

  @override
  void initState() {
    initUniLinks();
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Got a message while in the foreground!');
      log('Message data: ${message.notification}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification!.body}');
        await FlutterLocalNotificationsPlugin().show(
          1,
          message.notification!.title,
          message.notification!.body,
          platformChannel,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Mitra Fintech - Agent',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: false,
          ),
          home: child,
        );
      },
      child: Scaffold(
        body: DoubleBackToCloseApp(
          // snackBar: const SnackBar(content: Text('double tap to exit app')),
          snackBar: SnackBar(
            backgroundColor: const Color(0xffF3F5F7),
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0), // Starting shape
              ),
              const StadiumBorder(), // Ending shape
              0.2, // Interpolation factor (0.0 to 1.0)
            )!,
            width: 200,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'double tap to exit app',
              style: TextStyle(
                color: MyColors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(seconds: 1),
          ),
          child:
              // SharedPreferencesHelper.getisFirstTime() == true
              //     ? const OnBoardingScreen()
              //     :
              BottomNav(
            currentIndex: 0,
          ),
          // UploadDocScreen(isfromInside: false),
        ),
      ),
    );
  }

  // Initialize deep link handling
  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      handleDeepLink(initialLink);

      linkStream.listen((String? link) {
        handleDeepLink(link);
      });
    } on PlatformException {
      // handleDeferredDeepLinking();
    }
  }

  // Handle the deep link
  void handleDeepLink(String? link) {
    if (link != null) {
      setState(() {
        deepLink = link;
      });
      if (link.contains("/agent/offers")) {
        Get.to(BottomNav(currentIndex: 2));
      } else {
        Get.to(BottomNav(currentIndex: 0));
      }
    }
  }

  // habdle deffered deep linking
  // void handleDeferredDeepLinking() async {
  //   try {
  //     String playStoreLink =
  //         'https://play.google.com/store/apps/details?id=com.mitra_fintech.agent.app';
  //     await launch(playStoreLink);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}

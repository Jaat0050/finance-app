import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyColors {
  static Color primaryColor = Colors.white;
  static Color secondaryColor = Colors.black;
  static Color blue = const Color.fromRGBO(47, 93, 172, 1);
  static Color lightBlue = const Color(0xff6495ED);
  static Color veryLightBlue = const Color(0xff91C4F2);
  static Color dullBlue = const Color(0xffE2ECFF);
  static Color greyShadow = const Color(0x668E8E8E);
  static Color mediumGrey = const Color(0xff939393);
  static Color mediumLightGrey = const Color(0xffE8E8E8);
  static Color lightGrey = const Color(0x66E7E7E7);
  // static Color dullWhite = Colors.white;

  static Color dullWhite = const Color.fromRGBO(250, 250, 250, 1);
  static Color white = Colors.white;
  static Color black = Colors.black;
}

class MyGradients {
  static LinearGradient linearGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(47, 93, 172, 1),
      Color.fromRGBO(47, 93, 172, 1),
      Color.fromRGBO(47, 93, 172, 0.9),
      Color.fromRGBO(47, 93, 172, 0.86),
    ],
  );
}

AndroidNotificationDetails androidChannel = AndroidNotificationDetails(
    '1', 'Events',
    importance: Importance.high,
    icon: '@mipmap/ic_launcher',
    color: MyColors.blue,
    styleInformation: const BigTextStyleInformation(''));

NotificationDetails platformChannel =
    NotificationDetails(android: androidChannel);

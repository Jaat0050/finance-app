// import 'dart:developer';

// import 'package:app_version_update/app_version_update.dart';
// import 'package:app_version_update/data/models/app_version_result.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// Future<void> checkForUpdate(BuildContext context) async {
//   try {
//     const appleId = '6478277083';
//     const playStoreId = 'com.mitra_fintech.agent.app';
//     const country = 'in';
//     await AppVersionUpdate.checkForUpdates(
//             appleId: appleId, playStoreId: playStoreId, country: country)
//         .then((data) async {
//       log(data.storeUrl.toString());
//       log(data.storeVersion.toString());

//       if (data.canUpdate!) {
//         showUpdateAlert(
//             mandatory: true, appVersionResult: data, context: context);
//       }
//     });
//   } catch (e, s) {
//     log(e.toString());
//     log(s.toString());
//   }
// }

// showUpdateAlert(
//     {BuildContext? context,
//     AppVersionResult? appVersionResult,
//     bool? mandatory = false,
//     String? title = 'New version available',
//     TextStyle? titleTextStyle = const TextStyle(
//         fontSize: 24.0,
//         fontWeight: FontWeight.bold,
//         color: Color.fromRGBO(47, 93, 172, 1)),
//     String? content = 'Please update to continue using this application',
//     TextStyle? contentTextStyle = const TextStyle(
//         fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
//     ButtonStyle? cancelButtonStyle = const ButtonStyle(
//         backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
//     ButtonStyle? updateButtonStyle = const ButtonStyle(
//         backgroundColor:
//             MaterialStatePropertyAll(Color.fromRGBO(47, 93, 172, 1))),
//     String? cancelButtonText = 'UPDATE LATER',
//     String? updateButtonText = 'UPDATE',
//     TextStyle? cancelTextStyle = const TextStyle(color: Colors.white),
//     TextStyle? updateTextStyle =
//         const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//     Color? backgroundColor = Colors.white}) async {
//   await showDialog(
//     barrierDismissible: !mandatory!,
//     context: context!,
//     builder: (context) => UpdateVersionPopup(
//       appVersionResult: appVersionResult,
//       backgroundColor: backgroundColor,
//       cancelButtonStyle: cancelButtonStyle,
//       cancelButtonText: cancelButtonText,
//       cancelTextStyle: cancelTextStyle,
//       content: content,
//       contentTextStyle: contentTextStyle,
//       title: title,
//       titleTextStyle: titleTextStyle,
//       mandatory: mandatory,
//       updateButtonStyle: updateButtonStyle,
//       updateButtonText: updateButtonText,
//       updateTextStyle: updateTextStyle,
//     ),
//   );
// }

// // ignore: must_be_immutable
// class UpdateVersionPopup extends Container {
//   String? title;
//   String? content;
//   bool? mandatory;
//   String? updateButtonText;
//   String? cancelButtonText;
//   ButtonStyle? updateButtonStyle;
//   ButtonStyle? cancelButtonStyle;
//   AppVersionResult? appVersionResult;
//   Color? backgroundColor;
//   TextStyle? titleTextStyle;
//   TextStyle? contentTextStyle;
//   TextStyle? cancelTextStyle;
//   TextStyle? updateTextStyle;

//   UpdateVersionPopup(
//       {this.title,
//       this.content,
//       this.mandatory,
//       this.updateButtonText,
//       this.cancelButtonText,
//       this.updateButtonStyle,
//       this.updateTextStyle,
//       this.appVersionResult,
//       this.backgroundColor,
//       this.cancelButtonStyle,
//       this.cancelTextStyle,
//       this.contentTextStyle,
//       this.titleTextStyle,
//       Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: AlertDialog(
//         backgroundColor: backgroundColor!,
//         title: Text(
//           title!,
//           style: titleTextStyle ??
//               const TextStyle(
//                 color: Color.fromRGBO(47, 93, 172, 1),
//                 fontSize: 17.0,
//                 fontWeight: FontWeight.w700,
//               ),
//         ),
//         content: Text(
//           content!,
//           style: contentTextStyle ??
//               const TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w400,
//               ),
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: TextButton(
//                   style: updateButtonStyle,
//                   onPressed: () => launchUrl(
//                       Uri.parse(appVersionResult!.storeUrl!),
//                       mode: LaunchMode.externalApplication),
//                   child: Text(
//                     updateButtonText!,
//                     style: updateTextStyle,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GetUserData {
  GetUserData();

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

  APIvalue apIvalue = APIvalue();
  // UserProfile userProfile = UserProfile();

  Future<dynamic> getUserDetails() async {
    try {
      var response = await apiValue.getAgentProfile();
      if (response != null) {
        SharedPreferencesHelper.setFirstName(
            firstName: response['agentId']["first_name"] ?? '');
        SharedPreferencesHelper.setLastName(
            lastName: response['agentId']["last_name"] ?? '');
        SharedPreferencesHelper.setUserPhone(
            userPhone: response['agentId']["phoneno"] ?? '');
        SharedPreferencesHelper.setUserEmail(
            userEmail: response['agentId']['email'] ?? '');
        SharedPreferencesHelper.setNewUserId(
            userId: response['agentId']["_id"] ?? '');
        SharedPreferencesHelper.setUsertempId(
            usertempId: response['agentId']["agent_id"] ?? '');
        SharedPreferencesHelper.setUserDob(
            userDob: response['agentId']['dob'] ?? '');
        SharedPreferencesHelper.setUserGST(
            userGST: response['agentId']['gst_no'] ?? '');
        SharedPreferencesHelper.setUserGender(
            userGender: response['agentId']['gender'] ?? '');
        SharedPreferencesHelper.setAadharNumber(
            aadharNumber: response['aadhaar'] ?? '');
        SharedPreferencesHelper.setPanNumber(panNumber: response['pan'] ?? '');
        SharedPreferencesHelper.setTotalCommission(
            totalcommission:
                response['agentId']['commission_earned'].toString());
        // ---------------------------------------------------------------------------------//
        SharedPreferencesHelper.setAadhaar(
            isAadhaar:
                response['aadhaar'] != null && response['aadhaar'].isNotEmpty);
        SharedPreferencesHelper.setPan(
            isPan: response['pan'] != null && response['pan'].isNotEmpty);
        SharedPreferencesHelper.setVisiting(
            isVisiting: response['visiting_card'] != null &&
                response['visiting_card'].isNotEmpty);
        SharedPreferencesHelper.setAggrement(
            isAggrement: response['agentId']['aggrement_accepted'] ?? false);
        //-----------------------------------------------------------------------------------//
        SharedPreferencesHelper.setUserProfilePic(
            userPic: response['agentId']['image'] ?? '');

        SharedPreferencesHelper.setCustomerCount(
            customerCount: int.parse(response['agentId']['customer_ids'][0]));

        SharedPreferencesHelper.setCases(
            cases: response['agentId']['cases'] ?? 0);

        SharedPreferencesHelper.setUserCity(
            userCity: response['agentId']['city'] ?? '');
        SharedPreferencesHelper.setUserState(
            userState: response['agentId']['state'] ?? '');
        SharedPreferencesHelper.setReferalCode(
            referalCode: response['agentId']['referralCode'] ?? '');

        try {
          await Firebase.initializeApp().then((value) async {
            version();
            final fcmToken = await FirebaseMessaging.instance.getToken();

            if (SharedPreferencesHelper.getIsLoggedIn()) {
              apiValue.registerToken(fcmToken!, deviceType);
              apiValue.registerAppVersion(appVersion, deviceType);
              await apiValue.agentActivity();
            }
          });
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterFatalError;
        } catch (e) {
          log(e.toString());
        }

        // print(' ${SharedPreferencesHelper.getFirstName()}');
        // print(' ${SharedPreferencesHelper.getLastName()}');
        // print(' ${SharedPreferencesHelper.getUserPhone()}');
        // print(' ${SharedPreferencesHelper.getUserEmail()}');
        // print('${SharedPreferencesHelper.getUserId()}');
        // print(' ${SharedPreferencesHelper.getUsertempId()}');
        // print(' ${SharedPreferencesHelper.getUserDob()}');
        // print(' ${SharedPreferencesHelper.getUserGST()}');
        // print(' ${SharedPreferencesHelper.getUserGender()}');
        // print(' ${SharedPreferencesHelper.getaadharNumber()}');
        // print(' ${SharedPreferencesHelper.getPanNumber()}');
        // print(' ${SharedPreferencesHelper.getTotalCommission()}');
        // print(' ${SharedPreferencesHelper.getAadhaar()}');
        // print(' ${SharedPreferencesHelper.getPan()}');
        // print(' ${SharedPreferencesHelper.getVisiting()}');
        // print(' ${SharedPreferencesHelper.getAggrement()}');
        // print(' ${SharedPreferencesHelper.getUserProfilePic()}');
        // print(' ${SharedPreferencesHelper.getcustomerCount()}');
        // print(' ${SharedPreferencesHelper.getCases()}');
        // print(' ${SharedPreferencesHelper.getUserCity()}');
        // print(' ${SharedPreferencesHelper.getUserState()}');
        // print(' ${SharedPreferencesHelper.getReferalCode()}');
        // print(' ${SharedPreferencesHelper.getToken()}');
      } else {
        toastMsg('Something went wrong plzz login again');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.toString());
      // print(e.toString());
    }
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:path/path.dart' as path;

class APIvalue {
  static List<String> url = [
    'https://mitra-fintech-beta.vercel.app/'
  ];

  static int isbeta = 0;

  //==========================================Login And register==================================================

  String sendOTPURL = "${url[isbeta]}api/v1/auth/send-otp";

  String verifyOTPURL = "${url[isbeta]}api/v1/auth/verify-otp";

  String userExistanceURL = "${url[isbeta]}api/v1/agent/check-existance";

  String registrationURL = "${url[isbeta]}api/v1/agent/register";

  //==========================================KYC Verification==================================================

  String panVerificationUrl =
      "${url[isbeta]}api/v1/agent/pan-verification-status"; //done

  String aadhaarOtpUrl = "${url[isbeta]}api/v1/agent/aadhaar/send-otp"; //done

  String verifyAadhaarOtpUrl =
      "${url[isbeta]}api/v1/agent/aadhaar/verify-otp"; //done

  String addKYCDetailsURL = "${url[isbeta]}api/v1/agent/upload-doc"; //done

  //=================================================================products, leads, offers, broadcast and lenders================================================//

  String getLoansTypeDetailsURL =
      "${url[isbeta]}api/v1/product/get-product-v2"; //

  String getAllCasesURL = "${url[isbeta]}api/v1/agent/fetch-all-cases"; //done

  String getCreditCardCasesURL =
      "${url[isbeta]}api/v1/agent/get-credit-card"; //done

  String fetchOffersLanguageURL =
      "${url[isbeta]}api/v1/agent/fetch-offers-language"; //done

  String fetchOffersURL = "${url[isbeta]}api/v1/agent/fetch-offers-v2"; //done

  String getPosterURL = "${url[isbeta]}api/v1/agent/fetch/poster-v2"; // done

  String fetchProductWiselendersURL =
      "${url[isbeta]}api/v1/product/get-product-wise-lenders"; //

//==============================================Profile===================================================================

  String getAgentProfileURL = "${url[isbeta]}api/v1/agent/detail"; //done

  String updateAgentProfileURL =
      "${url[isbeta]}api/v1/agent/update-agent"; //done

  String updateProfilePicURL =
      "${url[isbeta]}api/v1/agent/update-profile-picture"; //done

//================================================wallet and transaction=================================================================

  String getCommissionURL = "${url[isbeta]}api/v1/agent/get-commission"; //done

  String withdrawalURL = "${url[isbeta]}api/v1/admin/create-withdrawl"; //done

  String getAllTransactionURL =
      "${url[isbeta]}api/v1/agent/get-all-transactions"; //done

  String fetchWithdrawalRequestURL =
      "${url[isbeta]}api/v1/agent/fetch/withdrawl-request"; //done

  //================================================= UPI ================================================================================//

  String getUpiIdURL = "${url[isbeta]}api/v1/bank/get-agents-upi"; //done

  String addUpiIdURL = "${url[isbeta]}api/v1/bank/add-upi"; //done

  String checkUpiIdURL = "${url[isbeta]}api/v1/agent/upi-verification"; //done

  String deleteUpiIdURL = "${url[isbeta]}api/v1/bank/delete-upi"; //done

//================================================================= Engine API ================================================//

  String loanEligibilityURL =
      "${url[isbeta]}api/v1/bank/get-loans-eligibility"; //done

//==================================================App Details like version activity and token===============================================================

  String registerAppVersionURL =
      '${url[isbeta]}api/v1/user/register-app-version'; //done

  String agentActivityURL =
      "${url[isbeta]}api/v1/agent/update-app-activity"; //done

  String registerTokenURL = "${url[isbeta]}api/v1/user/register-token"; //done

  //============================================= lenders concent verification apis ============================================================//

  String emailSendRequestURL =
      "${url[isbeta]}api/v1/admin/email/vendor-link"; //done

  String sendConsentOTPURL =
      "${url[isbeta]}api/v1/agent/send-consent-otp"; //done

  String verifyConsentOTPURL =
      "${url[isbeta]}api/v1/agent/verify-consent-otp"; //done

  //===================================================lenders==============================================================

  String credilioLinkURL =
      "${url[isbeta]}api/v1/product/create-credilio-token"; //done

  String moneyTapURL = "${url[isbeta]}api/v1/moneytap/lead-create"; //done

  String moneyTapCustomerStatusURL =
      "${url[isbeta]}api/v1/moneytap/lead-status"; //done

  String fatakPayURL = "${url[isbeta]}api/v1/fatakpay/loan-eligibility"; //done

  String fibeURL =
      "${url[isbeta]}api/v1/fibe/customer-profile-ingestion"; //done

  String ftCashURL = "${url[isbeta]}api/v1/agent/pan-verification"; //done

  Dio dio = Dio();

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> sendOTP(String mobile, String sig) async {
    try {
      dynamic data = {
        'mobile': mobile,
        'signature': sig,
      };

      Response response = await dio.get(sendOTPURL, queryParameters: data);
      var data1 = response.data['status'].toString();

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> verifyOTP(String otp, String phoneNumber) async {
    try {
      dynamic data = {
        // 'apikey': SharedPreferencesHelper.getApiKey(),
        'mobile': phoneNumber,
        'otp': otp,
      };
      Response response = await dio.post(verifyOTPURL, queryParameters: data);
      var data1 = response.data['status'].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> checkUserExistance() async {
    try {
      dynamic data = {
        'phoneno': SharedPreferencesHelper.getUserPhone(),
      };

      Response response =
          await dio.post(userExistanceURL, queryParameters: data);
      var data1 = response.data;

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> registerUser(
    String firstName,
    String lastName,
    String dob,
    String gender,
    String email,
    String city,
    String state,
    String code,
  ) async {
    try {
      dynamic data = {
        // 'apikey': SharedPreferencesHelper.getApiKey(),
        'first_name': firstName,
        'last_name': lastName,
        'dob': dob,
        'gender': gender,
        'email': email,
        'phoneno': SharedPreferencesHelper.getUserPhone(),
        'city': city,
        'state': state,
        'referral': code == ' ' ? '' : code,
      };
      Response response = await dio.post(registrationURL, data: data);
      var data1 = response.data;
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> checkPanVerification(String panNumber) async {
    try {
      dynamic data = {
        'pan': panNumber,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(panVerificationUrl,
          queryParameters: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data['status'].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------------
  Future<dynamic> sendAadhaarOTP(String aadhaarNumber) async {
    try {
      dynamic data = {
        'aadhaar_number': aadhaarNumber,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.get(aadhaarOtpUrl,
          queryParameters: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;
        return output;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------------
  Future<dynamic> checkAadhaarOTP(String otp, String refId) async {
    try {
      dynamic data = {
        'otp': otp,
        'ref_id': refId,
      };
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.get(verifyAadhaarOtpUrl,
          queryParameters: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data["status"].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> addKYCDetails(
    String? aadhaar,
    String? pan,
    String? visitingCard,
    String? aggrement,
    String? gst,
  ) async {
    try {
      dynamic data = {
        "aadhaar": aadhaar,
        "pan": pan,
        "visiting_card": visitingCard,
        "aggrement_accepted": aggrement,
        "gst_no": gst,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(
        addKYCDetailsURL,
        // queryParameters: {
        //   'agentId': SharedPreferencesHelper.getUserId(),
        // },
        data: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['status'];

      return data1;
    } catch (e) {
      log('Error: ${e.toString()}');
      return null;
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> getLoansTypeDetails() async {
    try {
      // dynamic data = {
      //   'agent_id': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getLoansTypeDetailsURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['adminProducts'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getAllCases() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(getAllCasesURL,
          // queryParameters: data,
          options: Options(headers: {
            "Authorization": SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data['data'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getCreditCardCases() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUsertempId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getCreditCardCasesURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['data'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getOffers() async {
    // dynamic data = {"agent_id": SharedPreferencesHelper.getUserId()};
    try {
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        fetchOffersURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data["adminProducts"];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getOffersLanguage() async {
    try {
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        fetchOffersLanguageURL,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['data'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getPosters() async {
    // dynamic data = {
    //   'agent_id': SharedPreferencesHelper.getUserId(),
    // };
    try {
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getPosterURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data["adminProducts"];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> getProductWiseLenders() async {
    try {
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        fetchProductWiselendersURL,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['data'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> getAgentProfile() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUserId(),
      // };
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getAgentProfileURL,
        // queryParameters: data,
        options: Options(headers: {
          "Authorization": SharedPreferencesHelper.getToken(),
          'Proxy-Authorization': ipAddress,
        }),
      );
      var data1 = response.data['data'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> updateAgentProfile(
      String firstName,
      String lastName,
      String email,
      String dob,
      String gender,
      String state,
      String city) async {
    try {
      dynamic data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'dob': dob,
        'gender': gender,
        'state': state,
        'city': city
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.patch(
        updateAgentProfileURL,
        // queryParameters: {'phoneno': SharedPreferencesHelper.getUserPhone()},
        data: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );

      var data1 = response.data['status'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> updateProfilePic(
    File? image,
  ) async {
    try {
      FormData formData = FormData();

      if (image != null) {
        String fileName =
            path.basename(image.path); // To get the file name with extension
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(image.path, filename: fileName),
          ),
        );
      }

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      // Making the request
      Response response = await dio.patch(
        updateProfilePicURL,
        // queryParameters: {
        //   'agentId': SharedPreferencesHelper.getUserId(),
        // },
        data: formData,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data;

      return data1;
    } catch (e) {
      log('Error: ${e.toString()}');
      return null;
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> getCommission() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getCommissionURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['commission'].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> withdrawal(String upiID, String amount) async {
    try {
      dynamic data = {
        "agentId": SharedPreferencesHelper.getUserId(),
        "amount": amount,
        "type": "upi",
        "bank_type_id": upiID,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(
        withdrawalURL,
        data: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['status'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> getAllTransaction() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getAllTransactionURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['data'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> fetchWithdrawalRequest() async {
    try {
      // dynamic data = {
      //   'id': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        fetchWithdrawalRequestURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['data'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> getUPI() async {
    try {
      // dynamic data = {
      //   'id': SharedPreferencesHelper.getUserId(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        getUpiIdURL,
        // queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['upis'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> addUPI(String upi, String name) async {
    try {
      dynamic data = {
        'upi': upi,
        'agentId': SharedPreferencesHelper.getUserId(),
        'name': name,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(
        addUpiIdURL,
        data: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['status'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> deleteUPI(String id) async {
    try {
      dynamic data = {
        'id': id,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        deleteUpiIdURL,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );
      var data1 = response.data['status'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> checkUpiId(String id) async {
    try {
      dynamic data = {
        'vpa': id,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.get(
        checkUpiIdURL,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          },
        ),
      );

      if (response.statusCode == 200) {
        var output = response.data;

        return output;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> loanEligibility(
    String amount,
    String age,
    String salary,
    String loanType,
  ) async {
    try {
      dynamic data = {
        'amount': int.parse(amount),
        'age': int.parse(age),
        'salary': int.parse(salary),
        'type': loanType,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.post(loanEligibilityURL,
          data: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));

      var data1 = response.data;

      return data1['plans'];
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  void registerToken(String token, String deviceType) async {
    try {
      dynamic data = {
        'user_id': SharedPreferencesHelper.getUserId().toString(),
        'token_id': token,
        'device_type': deviceType,
        'user_type': 'agent',
      };
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      await dio.post(registerTokenURL,
          data: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> registerAppVersion(String version, deviceType) async {
    try {
      dynamic data = {
        'user_id': SharedPreferencesHelper.getUserId().toString(),
        "user_type": "agent",
        "app_version": version,
        "device_type": deviceType,
      };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(registerAppVersionURL,
          data: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));

      var data1 = response.data['status'];
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------//
  Future<dynamic> agentActivity() async {
    try {
      // dynamic data = {
      //   'agentId': SharedPreferencesHelper.getUserId().toString(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.post(agentActivityURL,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data;
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> emailSendRequest(
    String email,
    String vendor,
    // String? fibeUrl,
    String? url,
  ) async {
    try {
      dynamic data = {
        "email_id": email,
        "vendor": vendor,
        "agent_id": SharedPreferencesHelper.getUsertempId(),
        "moneytap_url": url,
      };

      String jsonData = json.encode(data);

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(emailSendRequestURL,
          data: jsonData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data;
      return data1['status'];
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> sendConsentOTP(String mobile, String email) async {
    try {
      dynamic data = {
        'mobile': mobile,
        'email': email,
      };
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.get(sendConsentOTPURL,
          queryParameters: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data['status'].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------
  Future<dynamic> verifyConsentOTP(String otp, String phoneNumber) async {
    try {
      dynamic data = {
        'mobile': phoneNumber,
        'otp': otp,
      };
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.get(verifyConsentOTPURL,
          queryParameters: data,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      var data1 = response.data['status'].toString();
      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> getAddress(String pincode) async {
    try {
      String url = "https://api.postalpincode.in/pincode/$pincode";
      Response response = await dio.get(url);
      var data1 = response.data[0]['PostOffice'];

      return data1;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getInternalIPAddress() async {
    try {
      var ipAddress = IpAddress(type: RequestType.json);
      dynamic data = await ipAddress.getIpAddress();
      return data;
    } on IpAddressException catch (exception) {
      return null;
    }
  }

//=====================================================================================================================================================================================================
//=====================================================================================================================================================================================================

  Future<dynamic> credilioLink() async {
    try {
      // dynamic data = {
      //   'agent_id': SharedPreferencesHelper.getUserId().toString(),
      // };

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.get(credilioLinkURL,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //----------------------------------------Money Tap -----------------------------------------------//
  Future<dynamic> moneyTap(
    String customerPhone,
    String customerName,
    String customerPan,
    String customerDob,
    String customerGender,
    String customerPin,
    String customerAddress,
    // String customerResidenceType,
    String customerOfficePincode,
    String customerSalary,
  ) async {
    try {
      dynamic data = {
        "phone": customerPhone,
        "name": customerName,
        "panNumber": customerPan,
        "dateOfBirth": customerDob, //"1984-08-20"
        "gender": customerGender, //"MALE"
        "jobType": "SALARIED",
        "homeAddressPincode": customerPin,
        "homeAddress": customerAddress,
        "residenceType": "OWNED_BY_SELF_SPOUSE",
        "officeAddressPincode": customerOfficePincode,
        "monthlyIncome": int.parse(customerSalary),
        "agent_id": SharedPreferencesHelper.getUserId(),
        "email": "",
        "type": "",
        "loanRequired": "",
      };
      String jsonData = json.encode(data);

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();
      Response response = await dio.post(moneyTapURL,
          data: jsonData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;
        return output;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          return e.response?.data;
        }
      }
      log(e.toString());
    }
  }

  Future<dynamic> moneyTapCustomerSatus(
    String customerId,
  ) async {
    try {
      dynamic data = {
        'customerId': customerId,
      };
      String jsonData = json.encode(data);

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(moneyTapCustomerStatusURL,
          data: jsonData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;
        return output;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          return e.response?.data;
        }
      }
      log(e.toString());
    }
  }

  //-------------------------------------fatak pay ------------------------------------//
  Future<dynamic> fatakPay(
    String firstName,
    String lastName,
    String phone,
    String email,
    String dob,
    String gender,
    String employmentType,
    String pan,
    String pin,
    String amount,
    String type,
  ) async {
    String formatDate(DateTime dateTime) {
      String formattedDateTime = '${dateTime.year.toString().padLeft(4, '0')}-'
          '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}:'
          '${dateTime.second.toString().padLeft(2, '0')}';
      return formattedDateTime;
    }

    try {
      dynamic data = {
        "mobile": int.parse(phone),
        "first_name": firstName,
        "last_name": lastName,
        "pan": pan,
        "dob": dob,
        "pincode": int.parse(pin),
        "consent": true,
        "consent_timestamp": formatDate(DateTime.now()),
        "employment_type_id": employmentType,
        "email": email,
        "agentId": SharedPreferencesHelper.getUsertempId(),
        "type": type,
        "gender": gender,
        "loanRequired": amount
      };

      String jsonData = json.encode(data);


      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(fatakPayURL,
          data: jsonData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;
        return output;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          return e.response?.data;
        }
      }
      log(e.toString());
    }
  }

  //------------------------------------- Fibe ------------------------------------//
  Future<dynamic> fibePay(
    String customerPhone,
    String customerFirstName,
    String customerLastName,
    String customerPan,
    String customerDob,
    String customerPin,
    String customerOfficePincode,
    String customerSalary,
    String profession,
    bool consent,
    String loanRequired,
    String gender,
    String email,
    String type,
  ) async {
    String formatDate(DateTime dateTime) {
      String formattedDateTime = '${dateTime.year.toString().padLeft(4, '0')}-'
          '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}:'
          '${dateTime.second.toString().padLeft(2, '0')}';
      return formattedDateTime;
    }

    try {
      dynamic data = {
        "mobilenumber": customerPhone,
        "consent": consent,
        "consentDatetime": formatDate(DateTime.now()),
        "campaignsource": "APP",
        "firstname": customerFirstName,
        "lastname": customerLastName,
        "profession": profession, //"salaried",
        "pincode": int.parse(customerPin),
        "dob": customerDob,
        "pan": customerPan,
        "officepincode": int.parse(customerOfficePincode),
        "salary": int.parse(customerSalary),
        "agentId": SharedPreferencesHelper.getUsertempId(),
        "agentName":
            '${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}',
        "agentMobileNo": SharedPreferencesHelper.getUserPhone(),
        "agentEmailId": SharedPreferencesHelper.getUserEmail(),
        "loanRequired": loanRequired,
        "gender": gender,
        "email": email,
        "type": type,
      };

      String jsonData = json.encode(data);

      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      Response response = await dio.post(fibeURL,
          data: jsonData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;

        return output;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          return e.response?.data;
        }
      }
      log(e.toString());
    }
  }

  //------------------------------------- FT Cash ------------------------------------//
  Future<dynamic> ftCash(
    String firstName,
    String lastName,
    String phone,
    String dob,
    String gender,
    String aadharNumber,
    String panNumber,
    String loanAmount,
    //
    String merchantName,
    String merchantEmail,
    String residenceOwnership,
    String merchantAddress,
    String merchantCity,
    String merchantState,
    String merchantPincode,
    String residenceIncorporationDate,
    //
    String merchantStoreName,
    String companyType,
    String categoryName,
    String productName, //timestamp
    String storeOwnership, //ip
    String shopAddress,
    String shopLocality,
    String shopState,
    String shopPincode,
    String businessIncorporationDate,
    //
    File? panPhoto,
    File? aadharCardFront,
    File? aadharCardBack,
    File? merchantPhoto,
    File? residenceAddressProof,
    File? shopAddressProof,
    File? gstPhoto,
    File? udyamCertificate,
    //
    String bankName,
    String accountNumber,
    String ifscCode,
    String branch,
    File? bankStatement,
    String password,
    //
    String type,
  ) async {
    try {
      dynamic ipData = await getInternalIPAddress();
      String ipAddress = ipData["ip"].toString();

      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('first_name', firstName),
        MapEntry('last_name', lastName),
        MapEntry('mobile', phone),
        MapEntry('dateOfBirth', dob),
        MapEntry('merchantGender', gender),
        MapEntry('aadhar_card', aadharNumber),
        MapEntry('pan_number', panNumber),
        MapEntry('loanAmount', loanAmount),
        MapEntry('merchant_name', merchantName),
        MapEntry('merchantEmail', merchantEmail),
        MapEntry('residenceOwnership', residenceOwnership),
        MapEntry('merchantAddress', merchantAddress),
        MapEntry('merchantCity', merchantCity),
        MapEntry('merchantState', merchantState),
        MapEntry('merchantPincode', merchantPincode),
        MapEntry('residenceIncorporationDate', residenceIncorporationDate),
        MapEntry('merchantStoreName', merchantStoreName),
        MapEntry('companyType', companyType),
        MapEntry('category_name', categoryName),
        MapEntry('product_name', productName),
        MapEntry('storeOwnership', storeOwnership),
        MapEntry('shopAddress', shopAddress),
        MapEntry('shopLocality', shopLocality),
        MapEntry('shopState', shopState),
        MapEntry('shopPincode', shopPincode),
        MapEntry('businessIncorporationDate', businessIncorporationDate),
        MapEntry('bank_name', bankName),
        MapEntry('account_number', accountNumber),
        MapEntry('IFSC_code', ifscCode),
        MapEntry('branch', branch),
        MapEntry('password', password),
        MapEntry('timestamp', '${DateTime.now()}'),
        MapEntry('ip', ipAddress),
        MapEntry('agentId', SharedPreferencesHelper.getUsertempId()),
        MapEntry('type', type),
      ]);

      if (panPhoto != null) {
        formData.files.add(
            MapEntry('pan_photo', await MultipartFile.fromFile(panPhoto.path)));
      }

      if (aadharCardFront != null) {
        formData.files.add(MapEntry('aadhar_card_front',
            await MultipartFile.fromFile(aadharCardFront.path)));
      }

      if (aadharCardBack != null) {
        formData.files.add(MapEntry('aadhar_card_back',
            await MultipartFile.fromFile(aadharCardBack.path)));
      }

      if (merchantPhoto != null) {
        formData.files.add(MapEntry('merchant_photo',
            await MultipartFile.fromFile(merchantPhoto.path)));
      }

      if (residenceAddressProof != null) {
        formData.files.add(MapEntry('residence_address_proof',
            await MultipartFile.fromFile(residenceAddressProof.path)));
      }

      if (shopAddressProof != null) {
        formData.files.add(MapEntry('shop_address_proof',
            await MultipartFile.fromFile(shopAddressProof.path)));
      }

      if (gstPhoto != null) {
        formData.files.add(
            MapEntry('gst_photo', await MultipartFile.fromFile(gstPhoto.path)));
      }

      if (udyamCertificate != null) {
        formData.files.add(MapEntry('udyam_certificate',
            await MultipartFile.fromFile(udyamCertificate.path)));
      }

      if (bankStatement != null) {
        formData.files.add(MapEntry('bank_statement',
            await MultipartFile.fromFile(bankStatement.path)));
      }

      Response response = await dio.post(ftCashURL,
          data: formData,
          options: Options(headers: {
            'Authorization': SharedPreferencesHelper.getToken(),
            'Proxy-Authorization': ipAddress,
          }));
      if (response.statusCode == 200) {
        var output = response.data;
        return output;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          return e.response?.data;
        }
      }
      return null;
    }
  }
}

APIvalue apiValue = APIvalue();

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/congratulations.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/term_conditionc.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// ignore: must_be_immutable
class UploadDocScreen extends StatefulWidget {
  bool isfromInside;
  UploadDocScreen({required this.isfromInside, Key? key}) : super(key: key);

  @override
  State<UploadDocScreen> createState() => _UploadDocScreenState();
}

class _UploadDocScreenState extends State<UploadDocScreen> {
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  bool isLoading = false;
  bool isValid = false;

  bool isOTP = false;

  bool isOtpSend = false;
  bool isResendOtp = false;
  bool isFirstTime = true;
  bool blockMultipleTap = false;
  bool isSendingConsentOTP = false;
  bool isConsentOTPValid = false;
  int _countdown = 15;
  late Timer _timer;
  bool isPanVerified = false;
  bool isAadhaarVerified = false;
  String refID = '';

  void toastMsg(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: MyColors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_countdown < 1) {
          timer.cancel();
          isResendOtp = false;
          blockMultipleTap = false;
        } else {
          _countdown -= 1;
        }
      });
    });
  }

  Future<void> verifyOTP(String otp) async {
    try {
      if (otp.length == 6) {
        setState(() {
          isSendingConsentOTP = true;
        });
        if (refID != '') {
          dynamic response = await apiValue.checkAadhaarOTP(otp, refID);
          if (response == 'success') {
            setState(() {
              isConsentOTPValid = true;
              isSendingConsentOTP = false;
              isOTP = false;
              isAadhaarVerified = true;
            });
            toastMsg("Verification Successful");
          } else {
            setState(() {
              isConsentOTPValid = false;
              isSendingConsentOTP = false;
            });
            toastMsg("Please enter otp correctly!");
          }
        }
      } else {
        setState(() {
          isConsentOTPValid = false;
          isSendingConsentOTP = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload files',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                  fontSize: 19,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Please upload the required documents to continue',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(103, 103, 103, 0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        actions: widget.isfromInside
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CongratScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      'Skip',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(77, 77, 77, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                  ),
                ),
              ],

        // centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            color: const Color.fromRGBO(250, 250, 250, 1),
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //----------------------------------road map indicator-------------------------------//

                Container(
                  height: 30,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: MyColors.blue,
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Divider(
                          color: MyColors.blue,
                          thickness: 3,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromRGBO(100, 149, 237, 0.1),
                            width: 5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: MyColors.blue,
                        ),
                      ),
                      const Flexible(
                        child: Divider(
                          color: Color.fromRGBO(217, 217, 217, 0.4),
                          thickness: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const TermAndCondition(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromRGBO(142, 142, 142, 0.4),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //--------------------------------road map text-------------------------------------//

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'Personal\ndetails',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: MyColors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'KYC\nDetails',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: MyColors.blue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Terms &\nConditions',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(142, 142, 142, 0.4),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //-----------------------------------aadhar no.-----------------------------------------//

                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      fieldNameForUploadDoc('AADHAR card no.'),
                      if (isAadhaarVerified)
                        Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Colors.green,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Verified',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          enabled: !isAadhaarVerified,
                          decoration: textfieldDecoration('Enter aadhar no.'),
                          textAlign: TextAlign.start,
                          controller: _aadhaarController,
                          cursorColor: MyColors.blue,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    if (!isAadhaarVerified)
                      GestureDetector(
                        onTap: blockMultipleTap
                            ? null
                            : () async {
                                if (_aadhaarController.text.isEmpty) {
                                  toastMsg("Please Enter Your Aadhaar Number");
                                } else if (_aadhaarController.text.length !=
                                    12) {
                                  toastMsg(
                                      "Please Enter a valid Aadhaar Number");
                                } else {
                                  setState(() {
                                    isOtpSend = true;
                                    blockMultipleTap = true;
                                  });

                                  var response = await apiValue
                                      .sendAadhaarOTP(_aadhaarController.text);
                                  if (response != null) {
                                    if (response["status"] == "success") {
                                      toastMsg("OTP sent successfully");
                                      _otpController.clear();
                                      setState(() {
                                        refID = response["data"][0]["ref_id"];
                                        isOTP = true;
                                        isOtpSend = false;
                                      });
                                    } else {
                                      toastMsg(response['message']);
                                      setState(() {
                                        isResendOtp = true;
                                        _countdown = 15;
                                        isOtpSend = false;
                                      });
                                      startTimer();
                                    }
                                  } else {
                                    toastMsg("Something Went Wrong");
                                    setState(() {
                                      isResendOtp = true;
                                      _countdown = 15;
                                      isOtpSend = false;
                                    });
                                    startTimer();
                                  }
                                  setState(() {
                                    isResendOtp = true;
                                    _countdown = 15;
                                  });
                                  startTimer();
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Text(
                            isOtpSend
                                ? 'Sending'
                                : isResendOtp && !isOtpSend
                                    ? 'Resend ($_countdown)'
                                    : !isFirstTime
                                        ? 'Resend'
                                        : 'Send OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isOtpSend
                                  ? MyColors.veryLightBlue
                                  : isResendOtp
                                      ? MyColors.veryLightBlue
                                      : MyColors.blue,
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              decorationColor: isOtpSend
                                  ? MyColors.veryLightBlue
                                  : isResendOtp
                                      ? MyColors.veryLightBlue
                                      : MyColors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                  ],
                ),

                //---------------------------------------otp------------------------------------------------//

                if (isOTP)
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, bottom: 10, top: 25),
                          child: fieldNameForUploadDoc('Enter OTP'),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: TextField(
                          onChanged: (inputValue) async {
                            if (inputValue.length == 6) {
                              await verifyOTP(inputValue);
                            } else {
                              setState(() {
                                isConsentOTPValid = false;
                              });
                            }
                          },
                          decoration: textfieldDecoration('Enter OTP'),
                          textAlign: TextAlign.start,
                          controller: _otpController,
                          cursorColor: MyColors.blue,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.blue,
                              disabledBackgroundColor: MyColors.blue,
                              minimumSize: const Size(120, 35),
                              maximumSize: const Size(120, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_otpController.text.isEmpty) {
                                      toastMsg('Enter OTP');
                                    } else if (_otpController.text.length !=
                                        6) {
                                      toastMsg('Invalid OTP');
                                    } else {
                                      await verifyOTP(_otpController.text);
                                    }
                                  },
                            child: isLoading
                                ? const Align(
                                    alignment: Alignment.center,
                                    child: SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : Text(
                                    'Submit OTP',
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),

                //--------------------------------------pan no.----------------------------------------------//

                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 25, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      fieldNameForUploadDoc('PAN card no.'),
                      if (isPanVerified)
                        Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Colors.green,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Verified',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    enabled: !isPanVerified,
                    controller: _panController,
                    decoration: textfieldDecoration('Enter pan no.'),
                    textAlign: TextAlign.start,
                    cursorColor: MyColors.blue,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) async {
                      _panController.value = _panController.value.copyWith(
                        text: value.toUpperCase(),
                      );
                      if (value.length == 10) {
                        if (await apiValue.checkPanVerification(value) ==
                            'success') {
                          setState(() {
                            isPanVerified = true;
                          });
                        } else {
                          toastMsg("Please Enter a valid Pan Number");
                        }
                      }
                    },
                  ),
                ),

                //--------------------------------------GST no.---------------------------------------------//

                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 25, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      fieldNameForUploadDoc('GST no.'),
                      Text(
                        ' (Optional)',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(54, 54, 54, 0.4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: textfieldDecoration('enter GST no.'),
                    textAlign: TextAlign.start,
                    controller: _gstController,
                    cursorColor: MyColors.blue,
                  ),
                ),

                //-------------------------proceed button---------------------------//

                Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: size.height * 0.1),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue,
                      disabledBackgroundColor: MyColors.blue,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_aadhaarController.text.isEmpty) {
                              toastMsg("Please Enter AADHAR no.");
                            } else if (_panController.text.isEmpty) {
                              toastMsg("Please Enter PAN no.");
                            } else if (_aadhaarController.text.length != 12) {
                              toastMsg("Please nter valid AADHAR no.");
                            } else if (_panController.text.length != 10) {
                              toastMsg("Please nter valid PAN no.");
                            } else if (!isConsentOTPValid ||
                                _otpController.text.isEmpty) {
                              toastMsg("Invalid OTP");
                            } else if (_aadhaarController.text != '' ||
                                _panController.text != '') {
                              setState(() {
                                isLoading = true;
                              });
                              var response = await apiValue.addKYCDetails(
                                _aadhaarController.text,
                                _panController.text,
                                null,
                                SharedPreferencesHelper.getAggrement()
                                    .toString(),
                                _gstController.text,
                              );
                              if (response != null) {
                                setState(() {
                                  isLoading = false;
                                  isValid = false;
                                });

                                await GetUserData().getUserDetails(
                                    );

                                if (SharedPreferencesHelper.getAggrement()) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNav(
                                                currentIndex: 0,
                                              )),
                                      (route) => false);
                                  setState(() {
                                    isValid = false;
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TermAndCondition(),
                                    ),
                                  );
                                  setState(() {
                                    isValid = false;
                                  });
                                }
                              } else {
                                toastMsg('"Something Went Wrong"');
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                            setState(() {
                              isValid = true;
                              isLoading = false;
                            });
                          },
                    child: isLoading
                        ? const Align(
                            alignment: Alignment.center,
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : Text(
                            'Continue',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

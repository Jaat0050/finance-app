// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/register.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../utils/constants.dart';

class OtpVerify extends StatefulWidget {
  final String phoneNumber;

  const OtpVerify({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with CodeAutoFill {
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;
  bool invalidText = false;

  dynamic verificationApi, checkUserExistenceApi;
  bool resendOtpButtonEnabled = false;
  int seconds = 15;
  bool timerRemaining = true;
  // late SharedPreferences _sharedPreferences;
  String resendText = '';
  late StopWatchTimer stopWatchTimer;
  String otptimeRemaining = '';
  String otp1 = '';

  // initializePrefs() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   // await apiValue.store();
  // }

  void startOTPTimer() {
    stopWatchTimer.onStartTimer();
  }

  void resetOTPTimer() {
    stopWatchTimer.onResetTimer();
    // Seconds = 15;
    timerRemaining = true;
  }

  void stopOTPTimer() {
    setState(() {
      timerRemaining = false;
      resendOtpButtonEnabled = true;
    });
    stopWatchTimer.onStopTimer();
  }

  @override
  void codeUpdated() {
    setState(() {
      otp1 = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode();
    // initializePrefs();

    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(15),
      // millisecond => minute.
      onChange: (value) => {},
      onChangeRawSecond: (value) => {
        if (mounted)
          {
            setState(() {
              // otptimeRemaining = (value != null) ? value.toString() : '';
              otptimeRemaining = value.toString();
              resendText = '($otptimeRemaining)';
              if (value == 0) {
                resendOtpButtonEnabled = true;
                stopOTPTimer();
              }
            }),
          }
      },
      onChangeRawMinute: (value) => {},
    );
    startOTPTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();

    SmsAutoFill().unregisterListener();
    stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.45,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Image.asset(
                        'assets/icon2.png',
                        width: size.width * 0.4,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Image.asset(
                        'assets/onboarding/otps.png',
                        width: size.width * 0.5,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: size.height * 0.55,
                  decoration: BoxDecoration(
                      color: MyColors.dullBlue,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.08),
                      Text(
                        "Enter the OTP sent to your number.",
                        style: TextStyle(
                          fontSize: 11,
                          color: MyColors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "+91 ${widget.phoneNumber}",
                              style: TextStyle(
                                fontSize: 13,
                                color: MyColors.black,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.edit_outlined,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      SizedBox(
                        height: 58,
                        child: PinFieldAutoFill(
                          autoFocus: false,
                          currentCode: otp1,
                          codeLength: 4,
                          decoration: BoxLooseDecoration(
                            textStyle: GoogleFonts.roboto(
                              color: MyColors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            gapSpace: 20,
                            strokeColorBuilder: PinListenColorBuilder(
                              MyColors.blue,
                              Colors.grey,
                            ),
                            bgColorBuilder: PinListenColorBuilder(
                              Colors.transparent,
                              Colors.transparent,
                            ),
                            // lineHeight: 2.0,
                          ),
                          controller: _otpController,
                          onCodeChanged: (otp) async {
                            otp1 = otp!;
                            if (otp.length == 4) {
                              setState(() {
                                isLoading = true;
                              });

                              if (await apiValue.verifyOTP(
                                    otp,
                                    SharedPreferencesHelper.getUserPhone(),
                                  ) ==
                                  'success') {
                                var userExistenceResponse =
                                    await apiValue.checkUserExistance();

                                if (userExistenceResponse != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  String userId = userExistenceResponse['data']
                                          ['_id']
                                      .toString();
                                  String userToken =
                                      userExistenceResponse['token'];

                                  // _sharedPreferences.setBool('isLoggedIn', true);
                                  SharedPreferencesHelper.setIsLoggedIn(
                                      isLoggedIn: true);
                                  SharedPreferencesHelper.setNewUserId(
                                      userId: userId);
                                  SharedPreferencesHelper.setToken(
                                      token: userToken);
                                  await GetUserData().getUserDetails();

                                  Navigator.popUntil(context, (route) => false);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: BottomNav(currentIndex: 0),
                                      duration:
                                          const Duration(milliseconds: 900),
                                      reverseDuration:
                                          const Duration(milliseconds: 400),
                                      childCurrent: widget,
                                    ),
                                  );

                                  stopOTPTimer();
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: const RegisterScreen(),
                                      // duration: Duration(milliseconds: 400),
                                      // reverseDuration:
                                      //     Duration(milliseconds: 400),
                                      childCurrent: widget,
                                    ),
                                  );
                                  stopOTPTimer();
                                }
                              } else {
                                setState(() {
                                  _otpController.clear();
                                  isLoading = false;
                                  invalidText = true;
                                });
                                Fluttertoast.showToast(
                                  msg:
                                      "Invalid code, please enter the correct OTP",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          onCodeSubmitted: (otp) async {
                            otp1 = otp;

                            if (otp.length == 4) {
                              setState(() {
                                isLoading = true;
                              });
                              if (await apiValue.verifyOTP(
                                    otp,
                                    SharedPreferencesHelper.getUserPhone(),
                                  ) ==
                                  'success') {
                                var userExistenceResponse =
                                    await apiValue.checkUserExistance();

                                if (userExistenceResponse != null) {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  // Extracting the user ID from the API response
                                  String userId = userExistenceResponse['data']
                                          ['_id']
                                      .toString();
                                  String userToken =
                                      userExistenceResponse['token'];

                                  // _sharedPreferences.setBool('isLoggedIn', true);
                                  SharedPreferencesHelper.setIsLoggedIn(
                                      isLoggedIn: true);
                                  SharedPreferencesHelper.setNewUserId(
                                      userId: userId);
                                  SharedPreferencesHelper.setToken(
                                      token: userToken);
                                  await GetUserData().getUserDetails();

                                  Navigator.popUntil(context, (route) => false);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: BottomNav(currentIndex: 0),
                                      duration:
                                          const Duration(milliseconds: 900),
                                      reverseDuration:
                                          const Duration(milliseconds: 400),
                                      childCurrent: widget,
                                    ),
                                  );
                                  stopOTPTimer();
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: const RegisterScreen(),
                                      childCurrent: widget,
                                    ),
                                  );
                                  stopOTPTimer();
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Invalid code, please enter the correct OTP",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                                setState(() {
                                  _otpController.clear();
                                  invalidText = true;
                                  isLoading = false;
                                });
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        "Didn’t receive the code?",
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (!resendOtpButtonEnabled)
                                ? () {}
                                : () async {
                                    resetOTPTimer();
                                    setState(() {
                                      resendOtpButtonEnabled = false;
                                      _otpController.clear();
                                    });
                                    startOTPTimer();

                                    await apiValue.sendOTP(
                                      // _sharedPreferences
                                      //     .getString('userMobNum')
                                      //     .toString(),
                                      SharedPreferencesHelper.getUserPhone(),
                                      await SmsAutoFill().getAppSignature,
                                    );
                                  },
                            child: Text(
                              'Resend OTP',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: MyColors.lightBlue,
                                decoration: TextDecoration.underline,
                                decorationColor: MyColors.lightBlue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          !resendOtpButtonEnabled
                              ? Text(
                                  resendText,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(53, 53, 53, 1),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      if (invalidText)
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            'Invalid code, please enter the correct OTP',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(255, 0, 0, 1),
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.blue,
                            disabledBackgroundColor: MyColors.blue,
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (_otpController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: " Enter OTP",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else if (_otpController.text.length != 4) {
                                    Fluttertoast.showToast(
                                      msg: " Enter Full OTP",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    verificationApi = await apiValue.verifyOTP(
                                      otp1,
                                      SharedPreferencesHelper.getUserPhone(),
                                    );
                                    if (verificationApi == 'success') {
                                      var userExistenceResponse =
                                          await apiValue.checkUserExistance();

                                      if (userExistenceResponse != null) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        // Extracting the user ID from the API response
                                        String userId =
                                            userExistenceResponse['data']['_id']
                                                .toString();

                                        // _sharedPreferences.setBool('isLoggedIn', true);
                                        SharedPreferencesHelper.setIsLoggedIn(
                                            isLoggedIn: true);
                                        SharedPreferencesHelper.setNewUserId(
                                            userId: userId);
                                        await GetUserData()
                                            .getUserDetails();

                                        Navigator.popUntil(
                                            context, (route) => false);
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftJoined,
                                            child: BottomNav(currentIndex: 0),
                                            duration: const Duration(
                                                milliseconds: 900),
                                            reverseDuration: const Duration(
                                                milliseconds: 400),
                                            childCurrent: widget,
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftJoined,
                                            child: const RegisterScreen(),
                                            childCurrent: widget,
                                          ),
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Invalid code, please enter the correct OTP",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: MyColors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                          child: isLoading
                              ? const Align(
                                  alignment: Alignment.center,
                                  child: SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                        ),
                      ),
                    ],
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

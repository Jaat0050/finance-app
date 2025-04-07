// ignore_for_file: use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/otp_verify.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/web_screen.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobNumController = TextEditingController();
  // SharedPreferences? _sharedPreferences;
  bool isLoading = false;
  bool isWhatsapp = false;

  // Future<void> initializePrefs() async {
  //   // _auth = FirebaseAuth.instance;
  //   _sharedPreferences = await SharedPreferences.getInstance();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initializePrefs();
  // }

  @override
  void dispose() {
    super.dispose();
    mobNumController.dispose();
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
                        'assets/onboarding/logintop.png',
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login/Signup",
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColors.blue,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Stack(
                        children: [
                          IntlPhoneField(
                            keyboardType: TextInputType.number,
                            cursorColor: MyColors.blue,
                            controller: mobNumController,
                            showCountryFlag: false,
                            showDropdownIcon: false,
                            initialCountryCode: 'IN',
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.justify,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: MyColors.white,
                              contentPadding: const EdgeInsets.all(10),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColors.mediumGrey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.lightBlue,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 42,
                            child: Container(
                              width: 1,
                              height: 46,
                              color: MyColors.mediumGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.08),
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
                                  if (mobNumController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: "Please Enter Your Mobile Number",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else if (mobNumController.text.length !=
                                      10) {
                                    Fluttertoast.showToast(
                                      msg: "Please Enter a valid Mobile Number",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    SharedPreferencesHelper.setUserPhone(
                                      userPhone:
                                          mobNumController.text.toString(),
                                    );
                                    setState(() {
                                      isLoading = true;
                                    });

                                    if (await apiValue.sendOTP(
                                            mobNumController.text.toString(),
                                            await SmsAutoFill()
                                                .getAppSignature) ==
                                        'success') {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftJoined,
                                          child: OtpVerify(
                                            phoneNumber: mobNumController.text,
                                          ),
                                          duration:
                                              const Duration(milliseconds: 900),
                                          reverseDuration:
                                              const Duration(milliseconds: 400),
                                          childCurrent: widget,
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Something Went Wrong",
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
                                      // }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
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
                                  'Request OTP',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 11),
                            children: [
                              const TextSpan(
                                  text: "By continuing, you agree to our"),
                              TextSpan(
                                text: " Terms of Use ",
                                style: TextStyle(color: MyColors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebScreen(
                                          titleText: 'Terms & Conditions',
                                          initialUrl:
                                              'https://mitrafintech.com/terms&condition.html',
                                        ),
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(text: "and"),
                              TextSpan(
                                text: " Privacy Policy.",
                                style: TextStyle(color: MyColors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebScreen(
                                          titleText: 'Privacy Policy',
                                          initialUrl:
                                              'https://mitrafintech.com/privacy-policy.html',
                                        ),
                                      ),
                                    );
                                  },
                              ),
                            ]),
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

// SizedBox(
//               child: Stack(
//                 children: [
//                   Container(
//                     height: size.height * 0.1,
//                     width: size.width,
//                     color: MyColors.blue,
//                   ),
//                   Positioned(
//                     top: size.height * 0.02,
//                     left: (size.width - size.width * 0.9) / 2,
//                     child: Container(
//                       height: size.height * 0.7,
//                       width: size.width * 0.9,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                         boxShadow: const [
//                           BoxShadow(
//                             blurRadius: 2.0,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: size.height * 0.4,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: size.height * 0.02),
//                                 Text(
//                                   " Login/Signup",
//                                   style: TextStyle(
//                                     color: MyColors.blue,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(height: size.height * 0.013),
//                                 //-------------------------------------field---------------------------------------------------//
//                                 IntlPhoneField(
//                                   keyboardType: TextInputType.number,
//                                   cursorColor: MyColors.blue,
//                                   controller: mobNumController,
//                                   showCountryFlag: false,
//                                   showDropdownIcon: false,
//                                   initialCountryCode: 'IN',
//                                   textAlignVertical: TextAlignVertical.center,
//                                   textAlign: TextAlign.justify,
//                                   decoration: InputDecoration(
//                                     contentPadding: const EdgeInsets.all(0),
//                                     counterText: '',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           const BorderSide(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: MyColors.lightBlue,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: size.height * 0.07),
//                                 //---------------------------------------button-------------------------------------------//
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: MyColors.blue,
//                                     disabledBackgroundColor: MyColors.blue,
//                                     minimumSize:
//                                         const Size(double.infinity, 45),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: isLoading
//                                       ? null
//                                       : () async {
//                                           if (mobNumController.text.isEmpty) {
//                                             Fluttertoast.showToast(
//                                               msg:
//                                                   "Please Enter Your Mobile Number",
//                                               toastLength: Toast.LENGTH_LONG,
//                                               gravity: ToastGravity.BOTTOM,
//                                               timeInSecForIosWeb: 1,
//                                               backgroundColor: MyColors.blue,
//                                               textColor: Colors.white,
//                                               fontSize: 16.0,
//                                             );
//                                           } else if (mobNumController
//                                                   .text.length !=
//                                               10) {
//                                             Fluttertoast.showToast(
//                                               msg:
//                                                   "Please Enter a valid Mobile Number",
//                                               toastLength: Toast.LENGTH_LONG,
//                                               gravity: ToastGravity.BOTTOM,
//                                               timeInSecForIosWeb: 1,
//                                               backgroundColor: MyColors.blue,
//                                               textColor: Colors.white,
//                                               fontSize: 16.0,
//                                             );
//                                           } else {
//                                             SharedPreferencesHelper
//                                                 .setUserPhone(
//                                               userPhone: mobNumController.text
//                                                   .toString(),
//                                             );
//                                             setState(() {
//                                               isLoading = true;
//                                             });

//                                             if (await apiValue.sendOTP(
//                                                     mobNumController.text
//                                                         .toString(),
//                                                     await SmsAutoFill()
//                                                         .getAppSignature) ==
//                                                 'success') {
//                                               setState(() {
//                                                 isLoading = false;
//                                               });
//                                               Navigator.push(
//                                                 context,
//                                                 PageTransition(
//                                                   type: PageTransitionType
//                                                       .rightToLeftJoined,
//                                                   child: OtpVerify(
//                                                     phoneNumber:
//                                                         mobNumController.text,
//                                                   ),
//                                                   duration: const Duration(
//                                                       milliseconds: 900),
//                                                   reverseDuration:
//                                                       const Duration(
//                                                           milliseconds: 400),
//                                                   childCurrent: widget,
//                                                 ),
//                                               );
//                                             } else {
//                                               Fluttertoast.showToast(
//                                                 msg: "Something Went Wrong",
//                                                 toastLength: Toast.LENGTH_LONG,
//                                                 gravity: ToastGravity.BOTTOM,
//                                                 timeInSecForIosWeb: 1,
//                                                 backgroundColor: MyColors.blue,
//                                                 textColor: Colors.white,
//                                                 fontSize: 16.0,
//                                               );
//                                               setState(() {
//                                                 isLoading = false;
//                                               });
//                                               // }
//                                             }
//                                             setState(() {
//                                               isLoading = false;
//                                             });
//                                           }
//                                         },
//                                   child: isLoading
//                                       ? const Align(
//                                           alignment: Alignment.center,
//                                           child: SpinKitThreeBounce(
//                                             color: Colors.white,
//                                             size: 20,
//                                           ),
//                                         )
//                                       : const Text(
//                                           'Request OTP',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w700,
//                                             fontFamily: 'Nunito',
//                                           ),
//                                         ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 //---------------------------------t/c and pp-----------------------------------------//
//                                 RichText(
//                                   text: TextSpan(
//                                     text: 'By continuing, you agree to our',
//                                     style: TextStyle(
//                                       color: MyColors.black,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: ' Terms of Use',
//                                         style: TextStyle(
//                                           color: MyColors.blue,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14,
//                                         ),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => WebScreen(
//                                                   titleText:
//                                                       'Terms & Conditions',
//                                                   initialUrl:
//                                                       'https://mitrafintech.com/terms&condition.html',
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                       ),
//                                       TextSpan(
//                                         text: ' and',
//                                         style: TextStyle(
//                                           color: MyColors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: ' Privacy Policy.',
//                                         style: TextStyle(
//                                           color: MyColors.blue,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14,
//                                         ),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => WebScreen(
//                                                   titleText: 'Privacy Policy',
//                                                   initialUrl:
//                                                       'https://mitrafintech.com/privacy-policy.html',
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'loan_result.dart';

// ignore: must_be_immutable
class FibeFieldsScreen extends StatefulWidget {
  String pin;
  String amount;
  String imgUrl;
  String mail;
  String customerSalary;
  String loanType;

  FibeFieldsScreen({
    super.key,
    required this.pin,
    required this.amount,
    required this.imgUrl,
    required this.mail,
    required this.customerSalary,
    required this.loanType,
  });

  @override
  State<FibeFieldsScreen> createState() => _FibeFieldsScreenState();
}

class _FibeFieldsScreenState extends State<FibeFieldsScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _customerOfficePincodeController =
      TextEditingController();
  final TextEditingController _customerSalaryController =
      TextEditingController();
  final TextEditingController _professionTypeController =
      TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  List<String> professionType = [
    'salaried',
    'self-employed',
    'student',
    'others'
  ];
  String? professionValue;

  List<String> genderType = ['Male', 'Female', 'others'];
  String? genderValue;

  bool isLoading = false;
  bool isPrivacyTick = false;
  bool isPincodeValid = false;

  bool isOtpSend = false;
  bool isFirstTime = true;
  bool isResendOtp = false;
  bool blockMultipleTap = false;
  bool isSendingConsentOTP = false;

  bool isConsentOTPValid = false;
  int _countdown = 15;
  late Timer _timer;

  List<dynamic> fullAddress = [];

  @override
  void initState() {
    super.initState();
    _pincodeController.text = widget.pin;
    _customerSalaryController.text = widget.customerSalary;
    _customerOfficePincodeController.addListener(() {
      getAddress(_customerOfficePincodeController.text);
    });

    _timer = Timer(const Duration(seconds: 1), () {});
  }

  Future<void> getAddress(String pincode) async {
    try {
      if (pincode.length == 6) {
        fullAddress = await apiValue.getAddress(pincode);

        if (fullAddress.isNotEmpty) {
          setState(() {
            isPincodeValid = true;
          });
        }
      } else {
        setState(() {
          isPincodeValid = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
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
      if (otp.length == 4) {
        setState(() {
          isSendingConsentOTP = true;
        });
        dynamic response =
            await apiValue.verifyConsentOTP(otp, _mobileNumberController.text);

        if (response == 'success') {
          setState(() {
            isConsentOTPValid = true;
            isSendingConsentOTP = false;
          });
        } else {
          setState(() {
            isConsentOTPValid = false;
            isSendingConsentOTP = false;
          });
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
  void dispose() {
    _mobileNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _panController.dispose();
    _pincodeController.dispose();
    _dobController.dispose();
    _customerOfficePincodeController.dispose();
    _customerSalaryController.dispose();
    _professionTypeController.dispose();
    _otpController.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Customer Details',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: MyColors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 70,
              width: 80,
              child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                  errorWidget: (context, url, error) => const SizedBox()),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: const Color.fromRGBO(250, 250, 250, 1),
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //----------------------------------Personal Details----------------------------------------------------
                fieldName('Customer First Name'),
                textField(_firstNameController, 'Enter Customer first name',
                    false, false, false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Customer Last Name'),
                textField(_lastNameController, 'Enter Customer Last name',
                    false, false, false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Customer Mobile Number'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          decoration: textfieldDecoration(
                              hintText: 'Please enter mobile number'),
                          textAlign: TextAlign.start,
                          controller: _mobileNumberController,
                          cursorColor: MyColors.blue,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: blockMultipleTap
                          ? null
                          : () async {
                              if (_mobileNumberController.text.isEmpty) {
                                toastMsg("Please Enter Your Mobile Number");
                              } else if (_mobileNumberController.text.length !=
                                  10) {
                                toastMsg("Please Enter a valid Mobile Number");
                              } else {
                                setState(() {
                                  isOtpSend = true;
                                  isFirstTime = false;
                                  blockMultipleTap = true;
                                });
                                if (await apiValue.sendConsentOTP(
                                        _mobileNumberController.text.toString(),
                                        widget.mail) ==
                                    'success') {
                                  _otpController.clear();
                                  toastMsg("OTP Sent");
                                  setState(() {
                                    isOtpSend = false;
                                  });
                                } else {
                                  toastMsg("Something Went Wrong");
                                  setState(() {
                                    isOtpSend = false;
                                  });
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

                //--------------------------------otp---------------------------------//

                fieldName(' Enter OTP'),

                Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (inputValue) async {
                      if (inputValue.length == 4) {
                        await verifyOTP(inputValue);
                      } else {
                        setState(() {
                          isConsentOTPValid = false;
                        });
                      }
                    },
                    enabled: !isFirstTime,
                    decoration:
                        textfieldDecoration(hintText: 'Please enter OTP'),
                    textAlign: TextAlign.start,
                    controller: _otpController,
                    cursorColor: MyColors.blue,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),

                if (_otpController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      _otpController.text.length < 4
                          ? 'Enter a Valid OTP'
                          : isSendingConsentOTP
                              ? 'Verifying'
                              : isConsentOTPValid
                                  ? 'OTP Verified'
                                  : 'Wrong OTP',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: isConsentOTPValid ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                //--------------------------------------------------------------------------------------
                fieldName('DOB'),
                textField(_dobController, 'yyyy-mm-dd', true, false, false,
                    false, true),

                //------------------------profession-----------------------=//
                fieldName('Gender'),
                dropDownBuilder(
                    'Select one', _genderController, genderType, genderValue),

                //------------------------profession-----------------------=//
                fieldName('Profession Type'),
                dropDownBuilder('Select one', _professionTypeController,
                    professionType, professionValue),

                //--------------------------------------------------------------------------------------
                fieldName('Monthly Salary'),
                textField(_customerSalaryController, 'Salary per month', false,
                    false, true, false, true),

                //--------------------------------------------------------------------------------------
                fieldName('Customer Pan Card Number'),
                textField(_panController, 'Enter Customer Pan', false, true,
                    false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Residence Pincode'),
                textField(_pincodeController, 'Enter Pincode', false, false,
                    true, false, true),

                //--------------------------------------------------------------------------------------
                fieldName('Office Pincode'),
                textField(
                    _customerOfficePincodeController,
                    'Enter Customer Office Pincode',
                    false,
                    false,
                    true,
                    true,
                    false),

                if (_customerOfficePincodeController.text.isNotEmpty &&
                    !isPincodeValid)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      isPincodeValid
                          ? 'Pincode is Valid'
                          : 'Pincode is Invalid',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: isPincodeValid ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: MyColors.blue,
                      value: isPrivacyTick,
                      onChanged: (value) {
                        setState(() {
                          isPrivacyTick = !isPrivacyTick;
                        });
                      },
                    ),
                    SizedBox(width: size.width * 0.01),
                    Expanded(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  'I hereby give my consent to Social Worth Technologies Private Limited to collect and share my credit report from credit bureaus and KYC details for the processing of my loan application by entities registered with RBI and agree to the',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(77, 77, 77, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: ' Terms & Conditions',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      color: MyColors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            contentPadding: (EdgeInsets.zero),
                                            content: webViewDialog(
                                              "https://www.fibe.in/terms-conditions/",
                                            ),
                                          );
                                        },
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: ' and',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(77, 77, 77, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: ' Privacy Policy',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      color: MyColors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            contentPadding: (EdgeInsets.zero),
                                            content: webViewDialog(
                                              'https://www.fibe.in/privacy-policy/',
                                            ),
                                          );
                                        },
                                      );
                                    },
                                ),
                                TextSpan(
                                  text:
                                      ' of Social Worth Technologies Private Limited.',
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(77, 77, 77, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                //-------------------------------- button -------------------------------//
                Padding(
                  padding: const EdgeInsets.only(
                      right: 45, left: 45, top: 10, bottom: 10),
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
                            //-------------------------------------------//
                            if (_firstNameController.text.isEmpty) {
                              toastMsg("Please Enter First Name");
                            } else if (_lastNameController.text.isEmpty) {
                              toastMsg("Please Enter Last Name");
                            } else if (_mobileNumberController.text.isEmpty) {
                              toastMsg("Please Enter Mobile no.");
                            } else if (_mobileNumberController.text.length !=
                                10) {
                              toastMsg("Enter full Mobile Number");
                            } else if (!isConsentOTPValid ||
                                _otpController.text.isEmpty) {
                              toastMsg("Invalid OTP");
                            } else if (_dobController.text.isEmpty) {
                              toastMsg("Please Select Date of Birth");
                            } else if (_genderController.text.isEmpty) {
                              toastMsg("Please Select Gender");
                            } else if (_professionTypeController.text.isEmpty) {
                              toastMsg("Please Select Profession type");
                            } else if (_customerSalaryController.text.isEmpty) {
                              toastMsg("Please Enter Salary");
                            } else if (_panController.text.isEmpty) {
                              toastMsg("Please Enter Pan no.");
                            } else if (_panController.text.length != 10) {
                              toastMsg("Enter full Pan no.");
                            } else if (_pincodeController.text.isEmpty) {
                              toastMsg("Please Enter Pincode");
                            } else if (_pincodeController.text.length != 6) {
                              toastMsg("Enter full Residence Pincode");
                            } else if (_customerOfficePincodeController
                                .text.isEmpty) {
                              toastMsg("Please Enter Office pincode");
                            } else if (_customerOfficePincodeController
                                    .text.length !=
                                6) {
                              toastMsg("Enter full Office Pincode");
                            } else if (!isPrivacyTick) {
                              toastMsg("Please check the box first");
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              var profileCreationResponse =
                                  await apiValue.fibePay(
                                _mobileNumberController.text,
                                _firstNameController.text,
                                _lastNameController.text,
                                _panController.text,
                                _dobController.text,
                                _pincodeController.text,
                                _customerOfficePincodeController.text,
                                _customerSalaryController.text,
                                _professionTypeController.text,
                                isPrivacyTick,
                                widget.amount,
                                _genderController.text,
                                widget.mail,
                                widget.loanType,
                              );

                              if (profileCreationResponse != null) {
                                if (profileCreationResponse['status'] ==
                                    'success') {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  String responseStatus =
                                      profileCreationResponse['data']['status'];

                                  String maintext1;
                                  String maintext2;
                                  String maintext3;

                                  if (responseStatus == 'Accepted') {
                                    maintext1 =
                                        "Congratulation! Your approved limit is Rs. ${profileCreationResponse['data']['sanctionLimit']} and tenure ${profileCreationResponse['data']['highestTenure']}";
                                    maintext2 = '';
                                    maintext3 = '';
                                  } else if (responseStatus == 'Suspended') {
                                    maintext2 =
                                        "Congratulation! You are eligible to get loan upto Rs. ${profileCreationResponse['data']['inPrincipleLimit']} and tenure ${profileCreationResponse['data']['inPrincipleTenure']} year";
                                    maintext1 = '';
                                    maintext3 = '';
                                  } else if (responseStatus == 'Rejected') {
                                    maintext3 =
                                        "You are not approved, due to internal criteria\nPlease reapply after 90 days";
                                    maintext1 = '';
                                    maintext2 = '';
                                  } else {
                                    maintext1 = '';
                                    maintext2 = '';
                                    maintext3 = '';
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FibeLoanResult(
                                        logoUrl: widget.imgUrl,
                                        mailId: widget.mail,
                                        text2: responseStatus == 'Accepted'
                                            ? maintext1
                                            : responseStatus == 'Suspended'
                                                ? maintext2
                                                : maintext3,
                                        assetUrl: responseStatus == 'Accepted'
                                            ? 'assets/home/loanApproved.png'
                                            : responseStatus == 'Suspended'
                                                ? 'assets/home/loanPending.png'
                                                : 'assets/home/loanRejected.png',
                                        status: responseStatus,
                                      ),
                                    ),
                                  );
                                } else {
                                  // toastMsg(profileCreationResponse['message']);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var tempText =
                                          'service is not available at given pincodes ${_customerOfficePincodeController.text}(Office), ${widget.pin}(Home)';

                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: (EdgeInsets.zero),
                                        content: popupDialog(
                                            widget.imgUrl,
                                            profileCreationResponse['message']
                                                    .toString()
                                                    .contains('pincodes')
                                                ? tempText
                                                : profileCreationResponse[
                                                    'message']),
                                      );
                                    },
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                toastMsg("Server Timeout! try again");
                                setState(() {
                                  isLoading = false;
                                });
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
                              size: 20,
                            ),
                          )
                        : const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito',
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget fieldName(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 5, bottom: 10, top: 25),
  //     child: Text(
  //       text,
  //       style: GoogleFonts.roboto(
  //         textStyle: const TextStyle(
  //           fontSize: 14,
  //           color: Color.fromRGBO(54, 54, 54, 0.8),
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget textField(controller, String hintText, bool isDateSelection,
      bool ispan, bool isNumber, bool isOfficePincode, bool isReadOnly) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        decoration: textfieldDecoration(hintText: hintText),
        textAlign: TextAlign.start,
        controller: controller,
        cursorColor: MyColors.blue,
        keyboardType: isDateSelection
            ? TextInputType.none
            : isNumber
                ? TextInputType.number
                : TextInputType.text,
        showCursor: isReadOnly ? false : true,
        readOnly: isReadOnly ? true : false,
        inputFormatters: ispan
            ? [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ]
            : isOfficePincode
                ? [
                    LengthLimitingTextInputFormatter(6),
                  ]
                : [],
        onChanged: ispan
            ? (text) {
                controller.value = controller.value.copyWith(
                  text: text.toUpperCase(),
                );
              }
            : isOfficePincode
                ? (text) async {
                    if (text.length == 6) {
                      await getAddress(text);
                    }
                  }
                : null,
        onTap: !isDateSelection
            ? () {}
            : () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1901),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: MyColors.blue,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then(
                  (value) {
                    if (value != null) {
                      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
                      setState(
                        () {
                          _dobController.text =
                              outputFormat.format(value).toString();
                        },
                      );
                    }
                  },
                );
              },
      ),
    );
  }

  Widget dropDownBuilder(
      String hintText, controller, List<String> type, String? value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonFormField(
        value: value,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromRGBO(142, 142, 142, 1),
          size: 17,
        ),
        onChanged: (value) {
          setState(() {
            value = value!;
            controller.text = value!;
          });
        },
        items: type.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child:
                Text(type, style: const TextStyle(fontWeight: FontWeight.w400)),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 0,
            borderSide: const BorderSide(
              color: Color.fromRGBO(142, 142, 142, 1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 0,
            borderSide: BorderSide(
              color: MyColors.blue,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget popupDialog(String url, String text) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(url),
                  fit: BoxFit.contain,
                  onError: (exception, stackTrace) => const SizedBox(),
                ),
              ),
            ),
          ),
          Text(
            text == "Case already exists"
                ? "Customer already exists. Please try another lead."
                : text == "customer already exists"
                    ? "Customer already exists. Please try another lead."
                    : text,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.blue,
                disabledBackgroundColor: MyColors.veryLightBlue,
                minimumSize: const Size(100, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget webViewDialog(String url) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10, top: 10),
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration textfieldDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(224, 224, 224, 1),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
      ),
      contentPadding: const EdgeInsets.all(11),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        gapPadding: 0,
        borderSide: const BorderSide(
          color: Color.fromRGBO(142, 142, 142, 1),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        gapPadding: 0,
        borderSide: BorderSide(
          color: MyColors.blue,
          width: 1,
        ),
      ),
    );
  }

  //toast
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
}

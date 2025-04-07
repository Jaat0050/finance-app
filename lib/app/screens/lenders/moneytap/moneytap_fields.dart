// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/moneytap/money_tap_result.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';



// ignore: must_be_immutable
class MoneyTapFieldsScreen extends StatefulWidget {
  // String phone;
  String pin;
  String amount;
  String imgUrl;
  String mail;
  String customerSalary;

  MoneyTapFieldsScreen({
    super.key,
    // required this.phone,
    required this.pin,
    required this.amount,
    required this.imgUrl,
    required this.mail,
    required this.customerSalary,
  });

  @override
  State<MoneyTapFieldsScreen> createState() => _MoneyTapFieldsScreenState();
}

class _MoneyTapFieldsScreenState extends State<MoneyTapFieldsScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _homePincodeController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _customerOfficePincodeController =
      TextEditingController();
  final TextEditingController _customerSalaryController =
      TextEditingController();

  bool isLoading = false;
  bool isPrivacyTick = false;
  bool isPincodeValid = false;

  List<dynamic> fullAddress = [];

  List<String> genderType = ['MALE', 'FEMALE', 'OTHERS'];

  String? genderValue;

  @override
  void initState() {
    super.initState();
    // _mobileNumberController.text = widget.phone;
    _homePincodeController.text = widget.pin;
    _customerSalaryController.text = widget.customerSalary;
    _homePincodeController.text = widget.pin;
    _customerOfficePincodeController.addListener(() {
      getAddress(_customerOfficePincodeController.text);
    });
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

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _fullNameController.dispose();
    _panController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _homePincodeController.dispose();
    _homeAddressController.dispose();
    _customerOfficePincodeController.dispose();
    _customerSalaryController.dispose();
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
                // sectionText(' Customer Personal Details '),

                //----------------------------------Personal Details----------------------------------------------------
                fieldName('Customer Full Name'),
                textField(_fullNameController, 'Enter Customer Full name',
                    false, false, false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Customer Mobile Number'),
                textField(
                    _mobileNumberController,
                    'Enter Customer Mobile number',
                    false,
                    false,
                    true,
                    true,
                    false),

                //--------------------------------------------------------------------------------------
                fieldName('DOB'),
                textField(_dobController, 'yyyy-mm-dd', true, false, false,
                    true, false),

                //--------------------------------------------------------------------------------------
                fieldName('Gender'),
                dropDownBuilder('Select one'),

                //--------------------------------------------------------------------------------------
                fieldName('Salary'),
                textField(_customerSalaryController, 'Salary per month', false,
                    false, true, true, false),
                //--------------------------------------------------------------------------------------
                fieldName('Customer Pan Card Number'),
                textField(_panController, 'Enter Customer Pan', false, true,
                    false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Address'),
                textField(_homeAddressController, 'Enter Address', false, false,
                    false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Residence Pincode'),
                textField(_homePincodeController, 'Enter Pincode', false, false,
                    true, true, false),

                //--------------------------------------------------------------------------------------
                GestureDetector(
                    onTap: () {}, child: fieldName('Office Pincode')),
                textField(
                    _customerOfficePincodeController,
                    'Enter Customer Office Pincode',
                    false,
                    false,
                    true,
                    false,
                    true),

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

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      "Terms And Condition",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(77, 77, 77, 1),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          decorationThickness:
                              1.5, // You can adjust the thickness
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),
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
                            if (_fullNameController.text.isEmpty) {
                              toastMsg("Please Enter Full Name");
                            } else if (_mobileNumberController.text.isEmpty) {
                              toastMsg("Please Enter Mobile no.");
                            } else if (_mobileNumberController.text.length !=
                                10) {
                              toastMsg("Enter full Mobile Number");
                            } else if (_dobController.text.isEmpty) {
                              toastMsg("Please Select Date of Birth");
                            } else if (_genderController.text.isEmpty) {
                              toastMsg("Please Select Gender");
                            } else if (_customerSalaryController.text.isEmpty) {
                              toastMsg("Please Enter Salary");
                            } else if (_panController.text.isEmpty) {
                              toastMsg("Please Enter Pan no.");
                            } else if (_panController.text.length != 10) {
                              toastMsg("Enter full Pan number");
                            } else if (_homeAddressController.text.isEmpty) {
                              toastMsg("Please Enter Address");
                            } else if (_homePincodeController.text.isEmpty) {
                              toastMsg("Please Enter Home pincode");
                            } else if (_homePincodeController.text.length !=
                                6) {
                              toastMsg("Enter full Residence Pincode");
                            } else if (_customerOfficePincodeController
                                .text.isEmpty) {
                              toastMsg("Please Enter Office pincode");
                            } else if (_customerOfficePincodeController
                                    .text.length !=
                                6) {
                              toastMsg("Enter full Office Pincode");
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              var eligibilityResponse = await apiValue.moneyTap(
                                _mobileNumberController.text,
                                _fullNameController.text,
                                _panController.text,
                                _dobController.text,
                                _genderController.text,
                                _homePincodeController.text,
                                _homeAddressController.text,
                                _customerOfficePincodeController.text,
                                _customerSalaryController.text,
                              );
                              if (eligibilityResponse != null) {
                                if (eligibilityResponse['status'] ==
                                    'success') {
                                  String customerID =
                                      eligibilityResponse['data'][0];

                                  await Future.delayed(
                                      const Duration(seconds: 5));

                                  var customerStatus =
                                      await apiValue.moneyTapCustomerSatus(
                                    customerID,
                                  );

                                  if (customerStatus['statuscode'] == 200) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MoneyTapResult(
                                          askedAmount: widget.amount,
                                          imgUrl: widget.imgUrl,
                                          mailID: widget.mail,
                                          maxEligibilityAmount:
                                              customerStatus['data']['amount']
                                                  .toString(),
                                          satus: customerStatus['data']
                                              ['status'],
                                          link: customerStatus['data']
                                                      ['status'] ==
                                                  "REJECTED"
                                              ? ''
                                              : customerStatus['data']
                                                  ['pendingStepsUrl'],
                                        ),
                                      ),
                                    );
                                  } else {
                                    toastMsg("Server Error");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } else {
                                  // toastMsg(eligibilityResponse['message']);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: (EdgeInsets.zero),
                                        content: popupDialog(widget.imgUrl,
                                            eligibilityResponse['message']),
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
  //     padding: const EdgeInsets.only(left: 5, top: 25),
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
      bool ispan, bool isNumber, bool isReadOnly, bool isOfficePincode) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextField(
          decoration: InputDecoration(
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
          ),
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
                        final DateFormat outputFormat =
                            DateFormat('yyyy-MM-dd');
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
      ),
    );
  }

  Widget dropDownBuilder(String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: DropdownButtonFormField(
          value: genderValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromRGBO(142, 142, 142, 1),
            size: 17,
          ),
          onChanged: (value) {
            setState(() {
              genderValue = value!;
              _genderController.text = genderValue!;
            });
          },
          items: genderType.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type,
                  style: const TextStyle(fontWeight: FontWeight.w400)),
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
            text,
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
}

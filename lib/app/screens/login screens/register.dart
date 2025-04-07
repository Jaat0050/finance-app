// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/login_screen.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/upload_doc.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  bool isLoading = false;
  List<int> daysList = List.generate(31, (index) => index + 1);
  List<int> monthsList = List.generate(12, (index) => index + 1);
  List<int> yearsList =
      List.generate(100, (index) => DateTime.now().year - index);

  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  List<String> gender = ['Male', 'Female'];
  String? genderValue;
  bool isPincodeValid = false;
  // bool isReferralValid = false;

  List<dynamic> fullAddress = [];

  @override
  void initState() {
    super.initState();
    _pincodeController.addListener(() {
      getAddress(_pincodeController.text);
    });
  }

  Future<void> getAddress(String pincode) async {
    try {
      if (pincode.length == 6) {
        fullAddress = await apiValue.getAddress(pincode);

        if (fullAddress.isNotEmpty) {
          setState(() {
            _cityController.text = fullAddress[0]['District'];
            _stateController.text = fullAddress[0]['State'];
            isPincodeValid = true;
          });
        }
      } else {
        setState(() {
          _cityController.text = '';
          _stateController.text = '';
          isPincodeValid = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal details',
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
              'Please fill the below details to continue',
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
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: MyColors.dullWhite,
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //----------------------------------road map indicator-------------------------------//
                const SizedBox(height: 20),
                Container(
                  height: 30,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Container(
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
                      const Flexible(
                        child: Divider(
                          color: Color.fromRGBO(217, 217, 217, 0.4),
                          thickness: 3,
                        ),
                      ),
                      Container(
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //--------------------------------road map text-------------------------------------//
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            textStyle: const TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(142, 142, 142, 0.4),
                              fontWeight: FontWeight.w500,
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

                const SizedBox(height: 10),
                //---------------------------------first name-------------------------------//

                fieldName('First name'),
                textFieldBuilder(_firstNameController,
                    'Please enter first name', false, false),

                //---------------------------------Last name-------------------------------//

                fieldName('Last name'),
                textFieldBuilder(_lastNameController, 'Please enter Last name',
                    false, false),

                //---------------------------------Email Address-------------------------------//

                fieldName('Email Address'),
                textFieldBuilder(_emailController, 'Please enter Email address',
                    false, false),

                //---------------------------------D O B-------------------------------//

                fieldName('Date of Birth (DOB)'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.dullWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //------------------------------//
                        dobDropDownBuilder(size.width * 0.25, _dayController,
                            'DD', selectedDay, daysList),

                        //------------------------------//
                        dobDropDownBuilder(size.width * 0.25, _monthController,
                            'MM', selectedMonth, monthsList),

                        //------------------------------//
                        dobDropDownBuilder(size.width * 0.30, _yearController,
                            'YYYY', selectedYear, yearsList)
                      ],
                    ),
                  ),
                ),

                //---------------------------------Gender-------------------------------//

                fieldName('Gender'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.dullWhite,
                    ),
                    child: Row(
                      children: gender.map((String type) {
                        return Container(
                          color: MyColors.dullWhite,
                          width: size.width * 0.40,
                          child: RadioListTile<String>(
                            dense: true,
                            activeColor: MyColors.blue,
                            title: Text(
                              type,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: MyColors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            value: type,
                            groupValue: genderValue,
                            onChanged: (value) {
                              setState(() {
                                genderValue = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                //---------------------------------Pincode-------------------------------//

                fieldName('Pincode'),
                textFieldBuilder(_pincodeController, 'Enter pin', true, false),

                if (_pincodeController.text.isNotEmpty && !isPincodeValid)
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

                //---------------------------------Invitation Code-------------------------------//

                fieldName('Invitation Code (Optional)'),
                textFieldBuilder(_codeController, 'Enter code', false, true),

                // if (_codeController.text.isNotEmpty && !isReferralValid)
                //   Padding(
                //     padding: const EdgeInsets.only(left: 5, top: 5),
                //     child: Text(
                //       isReferralValid ? 'Code is Valid' : 'Code is Invalid',
                //       style: GoogleFonts.rubik(
                //         textStyle: TextStyle(
                //           fontSize: 12,
                //           color: isReferralValid ? Colors.green : Colors.red,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ),

                SizedBox(height: size.height * 0.05),
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
                            if (_firstNameController.text.isEmpty) {
                              toastMsg("Please Enter Your First Name");
                            } else if (_lastNameController.text.isEmpty) {
                              toastMsg("Please Enter Your Last Name");
                            } else if (_emailController.text.isEmpty) {
                              toastMsg("Please Enter Your Email address");
                            } else if (_dayController.text.isEmpty ||
                                _monthController.text.isEmpty ||
                                _yearController.text.isEmpty) {
                              toastMsg("Please Select Date of Birth");
                            } else if (genderValue == null) {
                              toastMsg("Please Select Your Gender");
                            } else if (_pincodeController.text.isEmpty) {
                              toastMsg("Please Enter Your pincode");
                            } else if (_pincodeController.text.length != 6) {
                              toastMsg("Please Enter correct pincode");
                            } else if (_cityController.text.isEmpty ||
                                _stateController.text.isEmpty) {
                              toastMsg("Please Enter a Valid Pin code");
                            } else if (_codeController.text.isEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.zero,
                                    content: popupDialog(),
                                  );
                                },
                              ).then(
                                (value) {
                                  if (value == 'Yes') {
                                    _codeController.text = ' ';
                                  } else {
                                    _codeController.clear();
                                  }
                                },
                              );
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              var registrationResponse =
                                  await apiValue.registerUser(
                                _firstNameController.text.toString(),
                                _lastNameController.text.toString(),
                                '${_dayController.text}-${_monthController.text}-${_yearController.text}',
                                genderValue!,
                                _emailController.text.toString(),
                                _cityController.text.toString(),
                                _stateController.text.toString(),
                                _codeController.text.toString(),
                              );
                              if (registrationResponse != null) {
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

                                  SharedPreferencesHelper.setIsLoggedIn(
                                      isLoggedIn: true);
                                  SharedPreferencesHelper.setNewUserId(
                                      userId: userId);
                                  SharedPreferencesHelper.setToken(
                                      token: userToken);

                                  await GetUserData().getUserDetails();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UploadDocScreen(isfromInside: false),
                                    ),
                                  );
                                } else {
                                  toastMsg('Error: Login again');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.rightToLeftJoined,
                                      child: const LoginScreen(),
                                      childCurrent: widget,
                                    ),
                                  );
                                }
                              } else {
                                toastMsg("Incorrect details");
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
                            'Continue',
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

  Widget fieldName(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 25),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(54, 54, 54, 0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget textFieldBuilder(
      controller, String hintText, bool ispin, bool isInvitationCode) {
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
            hintStyle: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: Color.fromRGBO(224, 224, 224, 1),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
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
          onChanged: ispin
              ? (inputValue) async {
                  if (inputValue.length == 6) {
                    await getAddress(inputValue);
                  }
                }
              : isInvitationCode
                  ? (text) async {
                      controller.value = controller.value.copyWith(
                        text: text.toUpperCase(),
                      );
                    }
                  : null,
          textAlign: TextAlign.start,
          controller: controller,
          cursorColor: MyColors.blue,
          inputFormatters: ispin
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ]
              : [],
          keyboardType: ispin ? TextInputType.number : TextInputType.text,
        ),
      ),
    );
  }

  Widget dobDropDownBuilder(
      width, controller, String hintText, selectOne, List<int> valueList) {
    return Container(
      color: MyColors.white,
      width: width,
      child: DropdownButtonFormField(
        value: selectOne,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromRGBO(142, 142, 142, 1),
          size: 17,
        ),
        onChanged: (value) {
          setState(() {
            controller.text = value.toString();
          });
        },
        items: valueList.map((int year) {
          return DropdownMenuItem<int>(
            value: year,
            child: Text(year.toString(),
                style: const TextStyle(fontWeight: FontWeight.w400)),
          );
        }).toList(),
        decoration: InputDecoration(
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 0,
            borderSide: const BorderSide(
              color: Color.fromRGBO(142, 142, 142, 1),
              width: 0.6,
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
          hintText: hintText,
          hintStyle: GoogleFonts.mulish(
            textStyle: const TextStyle(
              color: Color.fromRGBO(224, 224, 224, 1),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget popupDialog() {
    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Confirmation",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Would you like to Register without Invitation code",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue,
                  disabledBackgroundColor: MyColors.veryLightBlue,
                  minimumSize: const Size(70, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue,
                  disabledBackgroundColor: MyColors.veryLightBlue,
                  minimumSize: const Size(70, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, 'Yes');
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ],
          ),
        ],
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

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/lenders_screen.dart';

import '../../utils/constants.dart';

// ignore: must_be_immutable
class EmiLoanDetails extends StatefulWidget {
  String loanType;
  EmiLoanDetails({super.key, required this.loanType});

  @override
  State<EmiLoanDetails> createState() => _EmiLoanDetailsState();
}

class _EmiLoanDetailsState extends State<EmiLoanDetails> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  bool isPincodeValid = false;

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
    _loanAmountController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _pincodeController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Customer Details',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: size.height,
          width: size.width,
          color: MyColors.dullWhite,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--------------------------------loan amount-------------------------//

                fieldName(' Loan Amount'),
                TextField(
                  decoration:
                      textfieldDecoration(hintText: 'Please enter amount'),
                  textAlign: TextAlign.start,
                  controller: _loanAmountController,
                  cursorColor: MyColors.blue,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),

                //--------------------------------age---------------------------------//

                fieldName(' Age'),

                TextField(
                  decoration: textfieldDecoration(hintText: 'Please enter age'),
                  textAlign: TextAlign.start,
                  controller: _ageController,
                  cursorColor: MyColors.blue,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),

                //--------------------------------salary---------------------------------//

                fieldName(
                    widget.loanType == "Business Loan" ? ' Income' : ' Salary'),

                TextField(
                  decoration:
                      textfieldDecoration(hintText: 'Please enter salary'),
                  textAlign: TextAlign.start,
                  controller: _salaryController,
                  cursorColor: MyColors.blue,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),

                //--------------------------------Pincode---------------------------------//

                fieldName(' Pincode'),

                TextField(
                  decoration:
                      textfieldDecoration(hintText: 'Please enter pincode'),
                  onChanged: (inputValue) async {
                    if (inputValue.length == 6) {
                      await getAddress(inputValue);
                    }
                  },
                  textAlign: TextAlign.start,
                  controller: _pincodeController,
                  cursorColor: MyColors.blue,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),

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

                //-------------------------------email id----------------------------------//

                fieldName(' Email'),

                TextField(
                  decoration:
                      textfieldDecoration(hintText: 'Please enter email'),
                  textAlign: TextAlign.start,
                  controller: _mailController,
                  cursorColor: MyColors.blue,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                            if (_loanAmountController.text.isEmpty) {
                              toastMsg("Please Enter loan amount");
                            } else if (_ageController.text.isEmpty) {
                              toastMsg("Please Enter customer age");
                            } else if (_ageController.text.length != 2) {
                              toastMsg("Not Eligible for the age you enter");
                            } else if (_salaryController.text.isEmpty) {
                              toastMsg("Please Enter salary");
                            } else if (_pincodeController.text.isEmpty) {
                              toastMsg("Please enter pincode");
                            } else if (_pincodeController.text.length != 6) {
                              toastMsg("Please enter full pincode");
                            } else if (!isPincodeValid) {
                              toastMsg("Invalid pincode");
                            } else if (_mailController.text.isEmpty) {
                              toastMsg("Please enter email id");
                            } else if (_mailController.text.isEmpty) {
                              toastMsg("Please enter email id");
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              var eligibilityResponse =
                                  await apiValue.loanEligibility(
                                _loanAmountController.text.toString(),
                                _ageController.text.toString(),
                                _salaryController.text.toString(),
                                widget.loanType,
                              );
                              if (eligibilityResponse != null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OffersScreen(
                                      amount:
                                          _loanAmountController.text.toString(),
                                      data: eligibilityResponse,
                                      pinCode: _pincodeController.text,
                                      mail: _mailController.text,
                                      salary: _salaryController.text,
                                      loanType: widget.loanType,
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                  // isOtpSend = false;
                                });
                                toastMsg(
                                  "No plans in eligible range",
                                );
                              }
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
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Nunito',
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  Widget fieldName(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10, top: 20),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/congratulations.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/upload_doc.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// ignore: must_be_immutable
class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  bool isLoading = false;
  bool ischecked = false;
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
              'Terms & Conditions',
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
              'Please read the below document carefully',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: const Color.fromRGBO(250, 250, 250, 1),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                UploadDocScreen(isfromInside: false),
                          ),
                        );
                      },
                      child: Container(
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

              const SizedBox(
                height: 40,
              ),
              //------------------------------indemnification clause--------------------//
              Text(
                'Indemnification Clause:',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(50, 50, 50, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                "In consideration of the banking institution engaging the Business Associate for KYC services, the Business Associate hereby agrees to indemnify and hold harmless the banking institution, its officers, directors, employees, and affiliates from and against any and all claims, demands, suits, actions, losses, damages, liabilities, costs, and expenses (including reasonable attorney's fees) arising out of or in connection with:",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(50, 50, 50, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                softWrap: true,
              ),

              const SizedBox(height: 30),

              //---------------------------------- 4 points--------------------------------//

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. ',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(50, 50, 50, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.81,
                    child: Text(
                      'Any breach of the terms and conditions outlined in this agreement by the Business Associate.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(50, 50, 50, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. ',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(50, 50, 50, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.81,
                    child: Text(
                      'Non-compliance with local, state, or federal laws and regulations governing KYC procedures.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(50, 50, 50, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. ',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(50, 50, 50, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.81,
                    child: Text(
                      'Any errors, inaccuracies, or omissions in the KYC documentation provided by the Business Associate.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(50, 50, 50, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4. ',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(50, 50, 50, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.81,
                    child: Text(
                      'Unauthorized disclosure or sharing of KYC information by the Business Associate.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(50, 50, 50, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              //-----------------------------check point------------------------------------//
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(-15, -12),
                    child: Checkbox(
                      activeColor: MyColors.blue,
                      // fillColor: MaterialStatePropertyAll(
                      //     MyColors.blue),
                      value: ischecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          ischecked = newValue ??
                              ischecked; // Update 'ischecked' with the new value
                        });
                      },
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-18, 0),
                    child: SizedBox(
                      width: size.width * 0.74,
                      child: Text(
                        "The Business Associate further agrees to cooperate fully in the defense of any such claims and to promptly reimburse the banking institution for any damages or costs incurred as a result of the Business Associate actions or omissions in providing KYC services.",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(77, 77, 77, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (ischecked) {
                            setState(() {
                              isLoading = true;
                            });
                            var response = await apiValue.addKYCDetails(
                              null,
                              null,
                              null,
                              ischecked.toString(),
                              null,
                            );

                            if (response != null) {
                              await GetUserData().getUserDetails(
                                  );

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CongratScreen(),
                                  ),
                                  (route) => false);
                              // }
                            } else {
                              toastMsg("Something went wrong");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            toastMsg("Please check the box first...");
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
                          'Next',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(250, 250, 250, 1),
                              fontWeight: FontWeight.w700,
                            ),
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
    );
  }
}

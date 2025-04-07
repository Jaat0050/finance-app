import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/my_case/tabs/loan_tab_content.dart';

//---------------------------------------------------- Credit Card Tab Content -------------------------------------------//

Widget creditCardTabContent(size, dynamic caseData) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //---------------------------------------completed and pending icon-----------------------//
      Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image(
                width: size.width * 0.15,
                image: AssetImage(
                  caseData['Status'].toString() == 'Customer Not Eligible'
                      ? 'assets/mycases/rejected.png'
                      : 'assets/mycases/pending.png',
                )),
          )
        ],
      ),
      const SizedBox(height: 10),
      Text(
        caseData['Status'].toString() == "null"
            ? "--"
            : caseData['Status'].toString(),
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),

      const Divider(
        color: Color.fromRGBO(142, 142, 142, 1),
        thickness: 1,
      ),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/mycases/trackComplete.png",
                    width: size.width * 0.08,
                  ),
                  Flexible(
                    child: Divider(
                      color: caseData['Status'].toString() ==
                              'Customer Not Eligible'
                          ? Colors.red
                          : Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  // Image.asset(
                  //   caseData['Status'].toString() == 'Customer Not Eligible'
                  //       ? "assets/mycases/trackRejected.png"
                  //       : "assets/mycases/trackPending.png",
                  //   width: size.width * 0.08,
                  // ),
                  // const Flexible(
                  //   child: Divider(
                  //     color: Colors.grey,
                  //     thickness: 2,
                  //   ),
                  // ),
                  // Image.asset(
                  //   "assets/mycases/trackPending.png",
                  //   width: size.width * 0.08,
                  // ),
                  Image.asset(
                    caseData['Status'].toString() == 'Customer Not Eligible'
                        ? "assets/mycases/trackRejected.png"
                        : "assets/mycases/trackPending.png",
                    width: size.width * 0.08,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caseData['LeadCreationDate'].toString() == "null"
                              ? "--"
                              : caseData['LeadCreationDate'].toString(),
                          style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter'),
                        ),
                        const Text(
                          "Lead Login",
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        caseData['Status'].toString() == 'Customer Not Eligible'
                            ? Text(
                                caseData['LastStatusChangedOn'].toString() ==
                                        "null"
                                    ? "--"
                                    : caseData['LastStatusChangedOn']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 8,
                                    color: caseData['Status'].toString() ==
                                            'Customer Not Eligible'
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              )
                            : const SizedBox(),
                        Text(
                          caseData['Status'].toString() ==
                                  'Customer Not Eligible'
                              ? 'Rejected'
                              : 'Card delivered',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                              color:
                                  caseData['Status'] == 'Customer Not Eligible'
                                      ? Colors.red
                                      : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: size.width * 0.2,
                  //   child: const Column(
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         'Card delivered',
                  //         style: TextStyle(
                  //             fontSize: 9,
                  //             fontWeight: FontWeight.w700,
                  //             fontFamily: 'Inter',
                  //             color: Colors.grey),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 15),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(2, 0),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Customer Name',
                '${caseData['CustomerName']}',
              ),
            ),
            infoRow(
              'Mobile Number',
              '${caseData['CustomerMobile']}',
            ),
            SizedBox(
              height: 30,
              width: size.width,
              child: Center(
                child: Dash(
                  dashColor: Colors.black,
                  dashGap: 1,
                  length: size.width - 125,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow('Product Type', caseData['Product'].toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                  'Bank',
                  caseData['Lender'] == ""
                      ? 'NA'
                      : caseData['Lender'].toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow('Card Name', 'NA'),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: infoRow('Card Type', 'NA'),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: infoRow('Customer Type', 'NA'),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: infoRow('Card Limit', 'NA'),
            // ),
            if (caseData['Status'].toString() == 'Customer Not Eligible')
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Definition',
                caseData['SubStatus'].toString() == ""
                    ? "NA"
                    : caseData['SubStatus'].toString(),
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: size.height * 0.01)
    ],
  );
}

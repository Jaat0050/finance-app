import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';

//---------------------------------------------------------- Date Formatter -------------------------------------------------------//

String dateFormatter(String date) {
  try {
    date = '${date.split(' ')[1]} ${date.split(' ')[2]} ${date.split(' ')[3]}';

    DateTime dateTime = DateFormat('MMM dd yyyy').parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    return '';
  }
}

//---------------------------------------------------- Info Row -------------------------------------------//

Widget infoRow(String text1, String text2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          text1,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ),
      Expanded(
        child: Text(
          text2,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.right,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}

//---------------------------------------------------- Personal Loan Tab Content -------------------------------------------//

Widget loanTabContent(size, dynamic caseData) {
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
                  caseData['caseStatusId']['sanctionedAt'].toString() != "null"
                      ? 'assets/mycases/complete.png'
                      : caseData['caseStatusId']['rejectedAt'].toString() !=
                              "null"
                          ? 'assets/mycases/rejected.png'
                          : 'assets/mycases/pending.png',
                )),
          )
        ],
      ),
      const SizedBox(height: 10),
      Text(
        caseData['status'] == 'Suspended'
            ? 'Bank Statement Pending'
            : caseData['status'] ?? '',
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/mycases/trackComplete.png",
                    width: size.width * 0.08,
                  ),
                  Flexible(
                    child: Divider(
                      color: caseData['caseStatusId']['sanctionedAt']
                                  .toString() !=
                              "null"
                          ? MyColors.blue
                          : caseData['caseStatusId']['rejectedAt'].toString() !=
                                  "null"
                              ? Colors.red.shade400
                              : Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  Image.asset(
                    caseData['caseStatusId']['sanctionedAt'].toString() !=
                            "null"
                        ? "assets/mycases/trackComplete.png"
                        : caseData['caseStatusId']['rejectedAt'].toString() !=
                                "null"
                            ? "assets/mycases/trackRejected.png"
                            : "assets/mycases/trackPending.png",
                    width: size.width * 0.08,
                  ),
                  Flexible(
                    child: Divider(
                      color: caseData['agentCommission'] > 0
                          ? MyColors.blue
                          : Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  Image.asset(
                    caseData['caseStatusId']['disbursedAt'].toString() != "null"
                        ? "assets/mycases/trackComplete.png"
                        : "assets/mycases/trackPending.png",
                    width: size.width * 0.08,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(
                            caseData['createdAt'],
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                      const Text(
                        "Case Login",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      caseData['caseStatusId']['sanctionedAt'].toString() !=
                              "null"
                          ? Text(
                              dateFormatter(caseData['caseStatusId']
                                      ['sanctionedAt']
                                  .toString()),
                              style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            )
                          : caseData['caseStatusId']['rejectedAt'].toString() !=
                                  "null"
                              ? Text(
                                  dateFormatter(caseData['caseStatusId']
                                          ['rejectedAt']
                                      .toString()),
                                  style: const TextStyle(
                                      fontSize: 8,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter'),
                                )
                              : Text(
                                  '--',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontFamily: 'Inter'),
                                ),
                      Text(
                        caseData['caseStatusId']['rejectedAt'].toString() !=
                                "null"
                            ? "Rejected"
                            : 'Amount Sanctioned',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          color: caseData['caseStatusId']['rejectedAt']
                                      .toString() !=
                                  "null"
                              ? Colors.red
                              : caseData['caseStatusId']['sanctionedAt']
                                          .toString() !=
                                      "null"
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // if (caseData['caseStatusId']['rejectedAt'].toString() == "null")
                SizedBox(
                  width: size.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      caseData['caseStatusId']['disbursedAt'].toString() !=
                              "null"
                          ? SizedBox(
                              width: size.width * 0.15,
                              child: Text(
                                dateFormatter(
                                  caseData['caseStatusId']['disbursedAt']
                                      .toString(),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            )
                          : Container(
                              width: size.width * 0.15,
                              child: Text(
                                '--',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                      SizedBox(
                        width: size.width * 0.14,
                        child: Text(
                          'Amount Disbursed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            color: caseData['caseStatusId']['disbursedAt']
                                        .toString() ==
                                    "null"
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // if (caseData['caseStatusId']['rejectedAt'].toString() != "null")
                //   SizedBox(width: size.width * 0.2)
              ],
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
                '${caseData['customer_id']['full_name']}',
              ),
            ),
            infoRow(
              'Mobile Number',
              '${caseData['customer_id']['phoneno']}',
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
            if (caseData['caseStatusId']['rejectedAt'].toString() != "null")
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: infoRow(
                  'Status message ',
                  caseData['status'] == 'Suspended'
                      ? 'Bank Statement Pending'
                      : caseData['caseStatusId'] != null &&
                              caseData['caseStatusId']['statusDefinition'] !=
                                  null
                          ? caseData['caseStatusId']['statusDefinition']
                          : 'Waiting...',
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Product Type',
                caseData['type'],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Loan Required',
                '₹${caseData['loan_required'].toString() == "null" ? "0" : caseData['loan_required'].toString()}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Loan Eligibe for',
                '₹${caseData['loan_amount'].toString() == "null" ? "0" : caseData['loan_amount'].toString()}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Loan Sanction',
                '₹${caseData['loanSanction'].toString() == "null" ? "0" : caseData['loanSanction'].toString()}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: infoRow(
                'Lender',
                caseData['partner'] == 'CREDILIO'
                    ? 'Other'
                    : caseData['partner'],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: size.height * 0.01)
    ],
  );
}

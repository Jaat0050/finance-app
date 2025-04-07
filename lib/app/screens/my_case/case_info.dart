import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../utils/constants.dart';

// ignore: must_be_immutable
class CaseInformation extends StatefulWidget {
  String loanType;
  String customerName;
  String amountRecieved;
  String date;
  String commisssion;
  CaseInformation(
      {required this.loanType,
      required this.customerName,
      required this.amountRecieved,
      required this.date,
      required this.commisssion,
      super.key});

  @override
  State<CaseInformation> createState() => _CaseInformationState();
}

class _CaseInformationState extends State<CaseInformation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Lead Information',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              size: 20,
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //------------------------------dash--------------------------------//
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: MyColors.blue,
                      ),
                      Dash(
                        direction: Axis.vertical,
                        length: size.height / 6,
                        dashLength: 8,
                        dashColor: MyColors.blue,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: MyColors.blue,
                      ),
                      Dash(
                        direction: Axis.vertical,
                        length: size.height / 6,
                        dashLength: 8,
                        dashColor: MyColors.blue,
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColors.blue,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: MyColors.blue,
                        ),
                      ),
                      Dash(
                        direction: Axis.vertical,
                        length: size.height / 6,
                        dashLength: 8,
                        dashColor: const Color.fromRGBO(28, 27, 31, 0.6),
                      ),
                      const Icon(
                        Icons.circle_outlined,
                        color: Color.fromRGBO(142, 142, 142, 1),
                      ),
                      Dash(
                        direction: Axis.vertical,
                        length: size.height / 6,
                        dashLength: 8,
                        dashColor: const Color.fromRGBO(28, 27, 31, 0.6),
                      ),
                      const Icon(
                        Icons.circle_outlined,
                        color: Color.fromRGBO(142, 142, 142, 1),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                //------------------------------------------column od cAards-----------------------------//
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height / 5.2,
                      width: size.width - 90,
                      child: CaseInfoItem(
                        title: 'Lead Login',
                        date: widget.date,
                        details:
                            '${widget.loanType}\nCustomer name - ${widget.customerName}\nAmount received - ${widget.amountRecieved}',
                        isCompleted: false,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: size.height / 5.2,
                      width: size.width - 90,
                      child: CaseInfoItem(
                        title: 'Sanction',
                        date: widget.date,
                        details: 'Amount received - ${widget.amountRecieved}',
                        isCompleted: true,
                        isDownloadable: true,
                        buttonText: 'Enter Details',
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: size.height / 5.2,
                      width: size.width - 90,
                      child: CaseInfoItem(
                        title: 'Disbursment',
                        date: widget.date,
                        details: 'Amount received - ${widget.amountRecieved}',
                        isCompleted: false,
                        isDownloadable: true,
                        buttonText: 'Enter Details',
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: size.height / 5.2,
                      width: size.width - 90,
                      child: CaseInfoItem(
                        title: 'Commission Earned',
                        details: widget.commisssion,
                        isCompleted: false,
                        isDocComplete: false,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      // height: size.height / 5.2,
                      width: size.width - 90,
                      child: CaseInfoItem(
                        title: 'Commission Received',
                        details: widget.commisssion,
                        isCompleted: false,
                        isDocComplete: false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CaseInfoItem extends StatelessWidget {
  final String title;
  String? date;
  String? details;
  final bool isCompleted;
  final bool isDocComplete;
  final bool isDownloadable;
  String? buttonText;

  CaseInfoItem({
    Key? key,
    required this.title,
    this.date,
    this.details,
    this.isCompleted = false,
    this.isDocComplete = true,
    this.isDownloadable = false,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                      color: !isDocComplete
                          ? const Color.fromRGBO(142, 142, 142, 1)
                          : const Color.fromRGBO(47, 47, 47, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  if (isDocComplete)
                    Text(
                      date ?? '',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Nunito',
                        color: Color.fromRGBO(142, 142, 142, 1),
                      ),
                    ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    details ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                      color: !isDocComplete
                          ? const Color.fromRGBO(142, 142, 142, 1)
                          : const Color.fromRGBO(47, 47, 47, 1),
                    ),
                  ),
                ],
              ),
              isDownloadable
                  ? Container(
                      // height: 30,
                      // width: 110,
                      // color: MyColors.blue,
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Icon(
                      //       Icons.download,
                      //       color: Colors.white,
                      //       size: 18,
                      //     ),
                      //     SizedBox(
                      //       width: 1,
                      //     ),
                      //     Text(
                      //       'Download letter',
                      //       style: TextStyle(
                      //         fontSize: 9,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: 'Nunito',
                      //         color: Colors.white,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      )
                  : const SizedBox(),
            ],
          ),
          // if (isCompleted)
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => SanctionDetails(),
          //           ),
          //         );
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.only(bottom: 10, right: 30),
          //         child: Container(
          //           height: 25,
          //           width: 90,
          //           decoration: BoxDecoration(
          //             color: MyColors.blue,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           child: Center(
          //             child: Text(
          //               buttonText ?? '',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 10,
          //                 fontFamily: 'Nunito',
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

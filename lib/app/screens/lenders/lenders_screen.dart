// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/ft_cash/ftcash_field.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/fatakpay/fatak_pay_screen.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/fibeScreens/fibe_fields.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/moneytap/moneytap_fields.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/image_screen.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/pdfscreen.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/web_screen.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class OffersScreen extends StatefulWidget {
  final List data;
  final String amount;
  final String pinCode;
  final String mail;
  final String salary;
  final String loanType;

  const OffersScreen({
    super.key,
    required this.data,
    required this.amount,
    required this.pinCode,
    required this.mail,
    required this.salary,
    required this.loanType,
  });

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late List filteredList;
  bool isCCLoading = false;

  @override
  void initState() {
    super.initState();
    filteredList = List.from(widget.data);
  }

  void generateToken() async {
    setState(() {
      isCCLoading = true;
    });
    String? token2 = await apiValue.credilioLink();
    if (token2 != null) {
      setState(() {
        isCCLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebScreen(
            titleText: 'Credit Card',
            initialUrl: token2,
          ),
        ),
      );
    } else {
      setState(() {
        isCCLoading = false;
      });
      toastMsg('Please refresh page');
    }
    setState(() {
      isCCLoading = false;
    });
  }

  String getFileExtension(String url) {
    return path.extension(Uri.parse(url).path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
              'Bank Offers (${filteredList.length})',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: MyColors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: MyColors.dullWhite,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: RefreshIndicator(
          color: MyColors.blue,
          onRefresh: () async {},
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: filteredList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: MyColors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: isCCLoading
                            ? null
                            : () async {
                                //----------------------------------------------------- fibe ----------------------------------------------//
                                if (filteredList[index]['vendor'] == 'Fibe') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FibeFieldsScreen(
                                        pin: widget.pinCode,
                                        amount: widget.amount,
                                        imgUrl: filteredList[index]
                                                ['lenderImage']
                                            .toString(),
                                        mail: widget.mail,
                                        customerSalary: widget.salary,
                                        loanType: widget.loanType,
                                      ),
                                    ),
                                  );

                                  //----------------------------------------------------- moneyTap ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'Money Tap') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MoneyTapFieldsScreen(
                                        pin: widget.pinCode,
                                        amount: widget.amount,
                                        imgUrl: filteredList[index]
                                                ['lenderImage']
                                            .toString(),
                                        mail: widget.mail,
                                        customerSalary: widget.salary,
                                      ),
                                    ),
                                  );
                                  //----------------------------------------------------- fatakpay ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'FatakPay') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FatakPayScreen(
                                        pin: widget.pinCode,
                                        amount: widget.amount,
                                        imgUrl: filteredList[index]
                                                ['lenderImage']
                                            .toString(),
                                        mail: widget.mail,
                                        type: widget.loanType,
                                      ),
                                    ),
                                  );
                                  //----------------------------------------------------- kissht ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'Kissht') {
                                  dynamic response =
                                      await apiValue.emailSendRequest(
                                          widget.mail, 'KISSHT', '');
                                  if (response == "success") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          contentPadding: (EdgeInsets.zero),
                                          content: popupDialog(
                                            filteredList[index]['lenderImage']
                                                .toString(),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    toastMsg('Server error');
                                  }
                                  //----------------------------------------------------- FT Cash ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'FT Cash') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FTCashFieldScreen(
                                        landerName: filteredList[index]
                                            ['lenderName'],
                                        pin: widget.pinCode,
                                        amount: widget.amount,
                                        imgUrl: filteredList[index]
                                                ['lenderImage']
                                            .toString(),
                                        mail: widget.mail,
                                        loanType: widget.loanType,
                                      ),
                                    ),
                                  );
                                  //----------------------------------------------------- mPokket ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'mPokket') {
                                  dynamic response =
                                      await apiValue.emailSendRequest(
                                          widget.mail, 'mPokket', '');
                                  if (response == "success") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          contentPadding: (EdgeInsets.zero),
                                          content: popupDialog(
                                            filteredList[index]['lenderImage']
                                                .toString(),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    toastMsg('Server error');
                                  }
                                  //----------------------------------------------------- none ----------------------------------------------//
                                } else if (filteredList[index]['vendor'] ==
                                    'Credilio') {
                                  generateToken();
                                } else {
                                  null;
                                }
                              },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //--------------------------------image--------------//
                                  Container(
                                    width: 62,
                                    height: 42,
                                    padding: const EdgeInsets.all(5),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.black
                                              .withOpacity(0.10000000149011612),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: filteredList[index]
                                              ['lenderImage']
                                          .toString(),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: MyColors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  //----------------------bank name etc--------------//
                                  filteredList[index]['vendor'] == 'Credilio'
                                      ? isCCLoading
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: SpinKitThreeBounce(
                                                color: MyColors.blue,
                                                size: 25,
                                              ),
                                            )
                                          : SizedBox(
                                              height: 45,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    filteredList[index]
                                                        ['lenderName'],
                                                    style: GoogleFonts.nunito(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Color.fromRGBO(
                                                            2, 2, 2, 1),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Loan Amount - ${NumberFormat('#,##,###').format(int.parse(widget.amount))}',
                                                    style: GoogleFonts.nunito(
                                                      textStyle:
                                                          const TextStyle(
                                                        color:
                                                            Color(0xFF1E1E1E),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                      : SizedBox(
                                          height: 45,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filteredList[index]
                                                    ['lenderName'],
                                                style: GoogleFonts.nunito(
                                                  textStyle: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        2, 2, 2, 1),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Loan Amount - ${NumberFormat('#,##,###').format(int.parse(widget.amount))}',
                                                style: GoogleFonts.nunito(
                                                  textStyle: const TextStyle(
                                                    color: Color(0xFF1E1E1E),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            //----------------------interest tenure fee--------------//
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Interest rate \n${filteredList[index]['RateOfInt']}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF545454),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Tenure Up to\n${filteredList[index]['tenure']}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF545454),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Processing fee\n ${filteredList[index]['processingFee']}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF545454),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.6,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        color: const Color.fromRGBO(230, 235, 245, 0.62),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      String extension = getFileExtension(
                                          filteredList[index]
                                              ['eligibility_criteria']);
                                      if (extension == '.pdf') {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                PdfScreen(
                                                    initialUrl: filteredList[
                                                            index][
                                                        'eligibility_criteria'],
                                                    titleText:
                                                        'Eligibility Criteria'),
                                          ),
                                        );
                                      } else {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                ImageScreen(
                                                    initialUrl: filteredList[
                                                            index][
                                                        'eligibility_criteria'],
                                                    titleText:
                                                        'Eligibility Criteria'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/icons/eligibilitydoc.png'),
                                          fit: BoxFit.cover,
                                          height: 20,
                                          width: 20,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Eligibility Criteria',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.black,
                                              fontSize: 6,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      String extension = getFileExtension(
                                          filteredList[index]['product_usp']);
                                      if (extension == '.pdf') {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                PdfScreen(
                                                    initialUrl:
                                                        filteredList[index]
                                                            ['product_usp'],
                                                    titleText: 'Product USP'),
                                          ),
                                        );
                                      } else {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                ImageScreen(
                                                    initialUrl:
                                                        filteredList[index]
                                                            ['product_usp'],
                                                    titleText: 'Product USP'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/icons/ups.png'),
                                          fit: BoxFit.cover,
                                          height: 20,
                                          width: 20,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Product Brochure',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.black,
                                              fontSize: 6,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () async {
                                      String url =
                                          filteredList[index]['video_url'];
                                      Uri uri = Uri.parse(url);
                                      await launchUrl(uri);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/icons/vedio.png'),
                                          fit: BoxFit.cover,
                                          height: 20,
                                          width: 20,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Video's",
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.black,
                                              fontSize: 6,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget popupDialog(String url) {
    return Container(
      height: 250,
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
            'An email has been sent to the customer email :',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            widget.mail,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
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
                Navigator.of(context).pop();
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

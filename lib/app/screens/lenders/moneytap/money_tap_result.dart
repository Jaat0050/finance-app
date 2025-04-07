// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MoneyTapResult extends StatefulWidget {
  String satus;
  String maxEligibilityAmount;
  String askedAmount;
  String mailID;
  String imgUrl;
  String link;

  MoneyTapResult({
    super.key,
    required this.link,
    required this.satus,
    required this.maxEligibilityAmount,
    required this.askedAmount,
    required this.mailID,
    required this.imgUrl,
  });

  @override
  State<MoneyTapResult> createState() => _MoneyTapResultState();
}

class _MoneyTapResultState extends State<MoneyTapResult> {
  bool isLoading = false;

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
              'MoneyTap',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: MyColors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          color: MyColors.dullWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  width: 300,
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
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: MyColors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.satus),
              const SizedBox(height: 20),
              Text('Eligible max amount: ₹${widget.maxEligibilityAmount}'),
              const SizedBox(height: 5),
              Text('Your Amount: ₹${widget.askedAmount}'),
              const SizedBox(height: 100),
              if (widget.satus != "REJECTED")
                const Center(child: Text('To proceed with the application')),
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
                  onPressed: widget.satus == "REJECTED"
                      ? () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  BottomNav(currentIndex: 1),
                            ),
                            (route) => false,
                          );
                        }
                      : () async {
                          dynamic mailSentResponse =
                              await apiValue.emailSendRequest(
                                  widget.mailID, 'MONEYTAP', widget.link);
                          if (mailSentResponse == "success") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  contentPadding: (EdgeInsets.zero),
                                  content: popupDialog(
                                    widget.imgUrl,
                                  ),
                                );
                              },
                            );
                          } else {
                            toastMsg('Server error');
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
                          widget.satus == "REJECTED"
                              ? 'Go to My Leads'
                              : 'Send link',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                ),
              ),
            ],
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
            widget.mailID,
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BottomNav(currentIndex: 1),
                  ),
                  (route) => false,
                );
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

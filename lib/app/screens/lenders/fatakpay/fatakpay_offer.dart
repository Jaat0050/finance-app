// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class FatakPayOffer extends StatefulWidget {
  String message;
  String maxEligibilityAmount;
  String askedAmount;
  // String tenure;
  // String convenienceFee;
  String processingFee;
  String mailID;
  String imgUrl;

  FatakPayOffer({
    super.key,
    required this.message,
    required this.maxEligibilityAmount,
    required this.askedAmount,
    // required this.convenienceFee,
    required this.processingFee,
    // required this.tenure,
    required this.mailID,
    required this.imgUrl,
  });

  @override
  State<FatakPayOffer> createState() => FatakPayOfferState();
}

class FatakPayOfferState extends State<FatakPayOffer> {
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
              'Fatak Pay',
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(widget.message),
              const SizedBox(height: 20),
              Text('Eligible max amount: ₹${widget.maxEligibilityAmount}'),
              const SizedBox(height: 5),
              Text('Your Amount: ₹${widget.askedAmount}'),
              const SizedBox(height: 20),
              // Text('Tenure: ${widget.tenure} years'),
              // const SizedBox(height: 5),
              // Text(
              //     'Convenience Fee: ₹${widget.convenienceFee == 'null' ? '0' : widget.convenienceFee}'),
              // const SizedBox(height: 5),
              Text('Processing Fee: ₹${widget.processingFee}'),
              const SizedBox(height: 100),
              const Center(
                child: Text('To proceed with the application'),
              ),
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
                  onPressed: () async {
                    dynamic response = await apiValue.emailSendRequest(
                        widget.mailID, 'FATAKPAY', '');
                    if (response == "success") {
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
                      : const Text(
                          'Send Link',
                          style: TextStyle(
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

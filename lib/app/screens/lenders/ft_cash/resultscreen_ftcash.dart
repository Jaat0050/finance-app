// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class FTCashResult extends StatefulWidget {
  String message;
  String askedAmount;
  String title;
  String imgUrl;

  FTCashResult({
    super.key,
    required this.message,
    required this.askedAmount,
    required this.title,
    required this.imgUrl,
  });

  @override
  State<FTCashResult> createState() => FTCashResultState();
}

class FTCashResultState extends State<FTCashResult> {
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
              widget.title,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: MyColors.black,
                  fontSize: 17,
                ),
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
              Text(
                widget.message,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: MyColors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'for amount',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: MyColors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '₹${widget.askedAmount}',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: MyColors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 100),
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
                    'Go to Cases ->',
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
}

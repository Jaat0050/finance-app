import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/login_screen.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

import '../../utils/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  bool isLoading = false;

  initializePrefs() async {
    setState(() {
      SharedPreferencesHelper.setisFirstTime(isFirstTime: false);
    });
  }

  Widget _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < board.length - 1; i++) {
      bool isSelected = i == currentIndex;
      Color fillColor = isSelected ? MyColors.blue : Colors.transparent;

      dots.add(InkWell(
        onTap: () {
          setState(() {
            currentIndex = i;
          });
          _controller.animateToPage(
            i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: isSelected
              ? Container(
                  width: 26,
                  height: 10,
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: MyColors.blue,
                      width: 2.0,
                    ),
                  ),
                )
              : Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                    color: fillColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors.white,
                      width: 1.0,
                    ),
                  ),
                ),
        ),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }

  onChanged(int index) {
    setState(() {
      currentIndex = index;
    });

    if (currentIndex == 4) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    initializePrefs();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              board[currentIndex].image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView.builder(
          controller: _controller,
          itemCount: board.length,
          physics: const BouncingScrollPhysics(),
          onPageChanged: onChanged,
          allowImplicitScrolling: true,
          itemBuilder: (_, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: height * 0.06),

                //----------------------------------------------image----------------------------------//
                if (currentIndex != 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'Skip',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: currentIndex == 1
                                    ? Colors.white
                                    : const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                const Spacer(),

                //----------------------------------------------text 1----------------------------------//
                Container(
                  height: 70,
                  width: width,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      board[currentIndex].title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                //----------------------------------------------text 2----------------------------------//
                Container(
                  height: 60,
                  width: width,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      board[currentIndex].line1,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                //----------------------------------------------dot----------------------------------//
                Center(
                  child: _buildDots(),
                ),

                SizedBox(height: height * 0.02),

                //----------------------------------------------button----------------------------------//
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue,
                      disabledBackgroundColor: MyColors.blue,
                      minimumSize: const Size(double.infinity, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });
                            setState(() {
                              currentIndex == 3
                                  ? Navigator.of(context).pushAndRemoveUntil(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return const LoginScreen();
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                      (route) => false)
                                  : currentIndex++;
                            });
                            setState(() {
                              isLoading = false;
                            });
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
                            currentIndex == 3 ? 'Continue' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito',
                            ),
                          ),
                  ),
                ),

                SizedBox(height: height * 0.06),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UnbordingContent {
  String image;
  String line1;
  String title;

  UnbordingContent({
    required this.image,
    required this.line1,
    required this.title,
  });
}

List<UnbordingContent> board = [
  UnbordingContent(
    image: 'assets/onboarding/o1.png',
    line1:
        'Unlock boundless earnings at Mitra Fintech! Offer diverse financial products, join successful agents.',
    title: 'Diversify & Multiply Your Income',
  ),
  UnbordingContent(
    image: 'assets/onboarding/o2.png',
    line1:
        "Leverage technology to get loan and credit card from umbrella’s of Bank within few minutes.",
    title: 'Leverage Technology in your Business',
  ),
  UnbordingContent(
    image: 'assets/onboarding/o3.png',
    line1: 'Avoid hassle to integrate with multiple Financial institutions.',
    title: 'Banking Hub: “50+ Banks & NBFC in One Sigle App”',
  ),
  UnbordingContent(
    image: 'assets/onboarding/o4.png',
    line1: 'Opportunities to distribute Financial Products, across India',
    title: '150+ Banking Products. Your access to Pan India Customers',
  ),
  UnbordingContent(
    image: 'assets/onboarding/o1.png',
    line1:
        'Unlock boundless earnings at Mitra Fintech! Offer diverse financial products, join successful agents.',
    title: 'Diversify & Multiply Your Income',
  ),
];

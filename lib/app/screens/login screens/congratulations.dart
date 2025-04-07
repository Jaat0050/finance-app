import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';

class CongratScreen extends StatefulWidget {
  const CongratScreen({super.key});

  @override
  State<CongratScreen> createState() => _CongratScreenState();
}

class _CongratScreenState extends State<CongratScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the next screen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(
              currentIndex: 0,
            ),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: size.width * 0.6,
              child: const Image(
                image: AssetImage(
                  'assets/uploadDocument/congratulations.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              'Congratulations',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You have successfully registered On',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(101, 101, 100, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
                height: size.height * 0.13,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.2,
                    // ),
                    Image.asset(
                      'assets/icon1.png',
                      // height: size.height * 0.4,
                      width: size.width * 0.09,
                      // fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      "Mitra Fintech",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(47, 93, 172, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

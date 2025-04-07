import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/lender_view.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/profile_picture_edit_page.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/web_screen.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/edit_profile.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/faq.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/personal_detail.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/support.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/login_screen.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.put(ProfileController());
  List<dynamic> lenderList = [];
  List<dynamic> productList = [];
  bool isLoading = false;

  Future<void> initializePrefs() async {
    setState(() {
      isLoading = true;
    });
    var response = await apiValue.getProductWiseLenders();
    if (response != null) {
      List productName = [];
      List lender = [];
      response.forEach((key, value) {
        productName.add(key);
        List lenders = value['lenders'];
        if (lenders != null && lenders.isNotEmpty) {
          lender.addAll(lenders);
        }
      });

      if (productName.isNotEmpty) {
        setState(() {
          productList.clear();
          productList.addAll(productName);
        });
      }

      if (lender.isNotEmpty) {
        setState(() {
          lenderList = lender;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarBuilder('My Profile'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.blue,
              ),
            )
          : Container(
              color: MyColors.dullWhite,
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //--------------------------------------top section-------------------------------//
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: SharedPreferencesHelper.getUserId() == ''
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'assets/profile/dummy_dp.png'),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
// <<<<<<< chiragjathan
                                        child: Obx(
                                          () => CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              profileController.imageUrl.value,
                                            ),
// =======
//                                         child: CircleAvatar(
//                                           radius: 50,
//                                           backgroundColor: Colors.transparent,
//                                           backgroundImage:
//                                               CachedNetworkImageProvider(
//                                             profileController.imageUrl.value,
// >>>>>>> arjun
                                          ),
                                        ),
                                      ),
                              ),
                              if (SharedPreferencesHelper.getUserId() != '')
                                Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              // const EditProfile(),
                                              const ProfilePictureEditPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 6,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.15),
                                            offset: Offset(0, 2),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Icon(
                                              size: 18,
                                              Icons.camera_alt_outlined,
                                              color: MyColors.black,
                                            ),
                                            Text(
                                              '__',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: MyColors.black,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 15),
                          if (SharedPreferencesHelper.getUserId() == '')
                            Text(
                              'User',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          if (SharedPreferencesHelper.getUserId() != '')
// <<<<<<< chiragjathan
                            Obx(
                              () => Text(
                                '${profileController.firstName.value} ${profileController.lastName.value}',
                                style: GoogleFonts.dmSans(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w700,
                                  ),
// =======
//                             Text(
//                               '${profileController.firstName.value} ${profileController.lastName.value}',
//                               style: GoogleFonts.dmSans(
//                                 textStyle: const TextStyle(
//                                   fontSize: 17,
//                                   color: Color.fromRGBO(0, 0, 0, 1),
//                                   fontWeight: FontWeight.w700,
// >>>>>>> arjun
                                ),
                              ),
                            ),
                          const SizedBox(height: 5),
                          if (SharedPreferencesHelper.getUserId() != '')
                            Text(
                              '(${SharedPreferencesHelper.getUsertempId()})',
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),
                    //----------------------------------------2nd section---------------------------------//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //-------------------------total customer-------------------//
                        Container(
                          height: 60,
                          width: size.width * 0.42,
                          decoration: BoxDecoration(
                            color: MyColors.blue,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: MyColors.greyShadow,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Customers',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(228, 228, 228, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                SharedPreferencesHelper.getcustomerCount()
                                    .toString(),
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-------------------------total cases----------------------//
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => BottomNav(
                                  currentIndex: 1,
                                ),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            height: 60,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              color: MyColors.blue,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: MyColors.greyShadow,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Leads',
                                  maxLines: 1,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(228, 228, 228, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  SharedPreferencesHelper.getCases().toString(),
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    //----------------------------------------3rd section---------------------------------//
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //----------------------------------------personal details------------------------------------//

                          profileTabs(
                            () {
                              SharedPreferencesHelper.getUserId() == ''
                                  ? Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (route) => false)
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PersonalDetails(),
                                      ),
                                    );
                            },
                            'assets/profile/img1.png',
                            'Personal Details',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------Lenders -------------------------//

                          profileTabs(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LenderViewScreen(),
                                ),
                              );
                            },
                            'assets/profile/img2.png',
                            'Lenders (${lenderList.length})',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------privacy policy-------------------------//

                          profileTabs(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebScreen(
                                    titleText: 'Privacy Policy',
                                    initialUrl:
                                        'https://mitrafintech.com/privacy-policy.html',
                                  ),
                                ),
                              );
                            },
                            'assets/profile/img3.png',
                            'Privacy Policy',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------terms And condition-------------------------//

                          profileTabs(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebScreen(
                                    titleText: 'Terms & Conditions',
                                    initialUrl:
                                        'https://mitrafintech.com/terms&condition.html',
                                  ),
                                ),
                              );
                            },
                            'assets/profile/img4.png',
                            'Terms & Conditions',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------Support Centre------------------------//

                          profileTabs(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SupportCentre(),
                                ),
                              );
                            },
                            'assets/profile/img5.png',
                            'Support Centre',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------------FAQ--------------------------------//

                          profileTabs(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FAQ(),
                                ),
                              );
                            },
                            'assets/profile/img6.png',
                            'FAQ',
                          ),
                          const SizedBox(height: 15),

                          //--------------------------------------------Delete Account--------------------------------//
                          if (SharedPreferencesHelper.getUserId() != '')
                            profileTabs(
                              () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SuccessDeleteDialogBox();
                                    });
                              },
                              'assets/profile/img7.png',
                              'Delete Account',
                            ),
                          if (SharedPreferencesHelper.getUserId() != '')
                            const SizedBox(height: 15),
                          //--------------------------------------------Log Out--------------------------------//

                          profileTabs(
                            () {
                              if (SharedPreferencesHelper.getUserId() != '') {
                                if (SharedPreferencesHelper.getUserId() != '') {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const SuccessDialogBox();
                                      });
                                }
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false);
                              }
                            },
                            SharedPreferencesHelper.getUserId() == ''
                                ? 'assets/profile/img9.png'
                                : 'assets/profile/img8.png',
                            SharedPreferencesHelper.getUserId() == ''
                                ? 'Log In'
                                : 'Log Out',
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }

  Widget profileTabs(ontap, String icon, String text) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: MyColors.veryLightBlue,
      onTap: ontap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.all(10),
        width: size.width * 0.88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.black,
            width: 0.2,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 0,
              offset: Offset(1, 1),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(icon),
                  fit: BoxFit.contain,
                  height: 18,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Color.fromRGBO(0, 0, 0, 0.8),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessDialogBox extends StatefulWidget {
  const SuccessDialogBox({super.key});

  @override
  SuccessDialogBoxState createState() => SuccessDialogBoxState();
}

class SuccessDialogBoxState extends State<SuccessDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Log out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "DM_Sans",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(88, 88, 88, 0.68),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "DM_Sans",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            border: Border.all(
                              color: MyColors.blue,
                            ),
                          ),
                          width: 79,
                          height: 32,
                          child: const Center(
                            child: Text(
                              "Go back",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'DM_Sans',
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferencesHelper.clearShareCache();

                        SharedPreferencesHelper.setIsLoggedIn(
                            isLoggedIn: false);
                        SharedPreferencesHelper.setisFirstTime(
                            isFirstTime: false);

                        await box.clear();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                        setState(() {});
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyColors.blue,
                          ),
                          width: 79,
                          height: 32,
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'DM_Sans',
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

class SuccessDeleteDialogBox extends StatefulWidget {
  const SuccessDeleteDialogBox({super.key});

  @override
  SuccessDeleteDialogBoxState createState() => SuccessDeleteDialogBoxState();
}

class SuccessDeleteDialogBoxState extends State<SuccessDeleteDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Delete Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "DM_Sans",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(88, 88, 88, 0.68),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Are you sure you want to Delete Account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "DM_Sans",
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            border: Border.all(
                              color: MyColors.blue,
                            ),
                          ),
                          width: 79,
                          height: 32,
                          child: const Center(
                            child: Text(
                              "Go back",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'DM_Sans',
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => WebScreen(
                              titleText: "Delete Account",
                              initialUrl:
                                  "https://mitrafintech.com/delete-account.html",
                            ),
                          ),
                        )
                            .then(
                          (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Your account has been deleted',
                                ),
                              ),
                            );
                            SharedPreferencesHelper.setIsLoggedIn(
                              isLoggedIn: false,
                            );
                            SharedPreferencesHelper.clearShareCache();
                            Navigator.popUntil(context, (route) => false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyColors.blue,
                          ),
                          width: 79,
                          height: 32,
                          child: const Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'DM_Sans',
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/profile.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/engine_screen.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/login_screen.dart';
import 'package:mitra_fintech_agent/app/screens/wallet/withdrawal_screen.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/web_screen.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/force_update.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileController = Get.put(ProfileController());
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> tabsList = [];
  bool isSearch = false;
  bool isLoading = false;

  bool isCCLoading = false;

  List<dynamic> filteredItems = box.get('product') ?? [];

  final List<dynamic> tabsList2 = [
    {
      'product_name': 'Personal Loan',
      'product_commission': 8,
      'product_offer': '40',
      'icon': 'https://pub-f26857f927b24f2bb647fe6bc0039d47.r2.dev/card1.png',
    },
    {
      'product_name': 'Credit Card',
      'product_commission': 6,
      'product_offer': '10',
      'icon': "https://pub-f26857f927b24f2bb647fe6bc0039d47.r2.dev/card4.png",
    },
  ];

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

  @override
  void initState() {
    initializePrefs();
    profileController.initProfileData();
    profileController.initImage();
    super.initState();
  }

  Future<void> refresh() async {
    var loansData = await apiValue.getLoansTypeDetails();
    if (loansData != null) {
      if (mounted) {
        setState(() {
          tabsList = loansData;
          homeProducts = loansData;
          isLoading = false;
        });
      }
    }
    filteredItems = List.from(tabsList);
    await box.put('product', filteredItems);
  }

  Future<void> initializePrefs() async {
    // await checkForUpdate(context);
    if (mounted) {
      setState(() {
        isLoading = true;
      });

      setState(() {
        tabsList = homeProducts;
        isLoading = false;
      });
    }

    filteredItems = List.from(tabsList);
    await box.put('product', filteredItems);
    // refresh();
  }

  void _filterItems(String query) {
    setState(
      () {
        if (query.isEmpty) {
          // isSearch = false;
          filteredItems = List.from(tabsList);
        } else {
          isSearch = true;
          filteredItems = tabsList
              .where((item) => item['product_name']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: RefreshIndicator(
        color: MyColors.blue,
        onRefresh: () async {
          await GetUserData()
              .getUserDetails();
          await refresh();
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: size.width,
            height: size.height,
            color: MyColors.dullWhite,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.08),
                  //----------------------------------top section-----------------------------//
                  if (!isSearch)
                    SizedBox(
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ////////////////////
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ======== name ========
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Welcome,',
                                          style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                              fontSize: 17.sp,
                                              color: MyColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        if (SharedPreferencesHelper
                                                .getUserId() ==
                                            '')
                                          Text(
                                            ' User',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize: 17.sp,
                                                color: MyColors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    if (SharedPreferencesHelper.getUserId() !=
                                        '')
                                      SizedBox(
                                        width: size.width * 0.72,
                                        child: Obx(
                                          () => RichText(
                                            maxLines: 2,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${profileController.firstName.value} ${profileController.lastName.value}',
                                                  style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                      fontSize: 17.sp,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                // ======== DP ==========
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                    ),
                                    child:
                                        SharedPreferencesHelper.getUserId() ==
                                                ''
                                            ? const CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: AssetImage(
                                                    'assets/profile/dummy_dp.png'),
                                              )
                                            : Obx(
                                                () => CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    profileController
                                                        .imageUrl.value,
                                                  ),
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (SharedPreferencesHelper.getUserPhone() !=
                              '9999999999')
                            SizedBox(height: size.height * 0.024),
                          ///////////////////
                          if (SharedPreferencesHelper.getUserPhone() !=
                              '9999999999')
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 30, right: 30),
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: MyColors.blue,
                                borderRadius: BorderRadius.circular(20),
                                gradient: MyGradients.linearGradient,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child:
                                        SharedPreferencesHelper.getUserId() ==
                                                ''
                                            ? Text(
                                                'User',
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: MyColors.white,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              )
                                            : Obx(
                                                () => Text(
                                                  '${profileController.firstName.value} ${profileController.lastName.value}',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: MyColors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Dash(
                                      dashColor: Colors.white,
                                      direction: Axis.horizontal,
                                      dashThickness: 1,
                                      dashGap: 1,
                                      dashLength: 2,
                                      length: size.width * 0.65,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //--------------------------------------------------
                                      InkWell(
                                        onTap: () {
                                          SharedPreferencesHelper.getUserId() ==
                                                  ''
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
                                                        const WithdrawalScreen(),
                                                  ),
                                                );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Commission Earned',
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 12.sp,
                                                  color: MyColors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '₹${NumberFormat('#,##,###').format(int.parse(SharedPreferencesHelper.getTotalCommission()))}',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 17.sp,
                                                  color: MyColors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //------------------------------------------------------
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNav(currentIndex: 1),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Leads',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 12.sp,
                                                  color: MyColors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              SharedPreferencesHelper.getCases()
                                                  .toString(),
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 17.sp,
                                                  color: MyColors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (SharedPreferencesHelper.getUserPhone() != '9999999999')
                    SizedBox(height: size.height * 0.03),

                  //-------------------------------search bar-----------------------------------------//
                  if (SharedPreferencesHelper.getUserPhone() != '9999999999')
                    Container(
                      height: 45,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                            width: 1),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            spreadRadius: 0,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                _filterItems(value);
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5),
                                hintText: 'Search type of loans',
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                ),
                              ),
                              controller: _searchController,
                              onTap: () {
                                setState(() {
                                  isSearch = true;
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                isSearch = false;
                                filteredItems = List.from(tabsList);
                              });
                              FocusScope.of(context).unfocus();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: size.height * 0.03),
                  //-------------------------------tabs-----------------------------------//

                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: MyColors.dullWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //----------------------------------------------------------------//
                        if (!isSearch)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: Text(
                                  'What benefits will you receive',
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '(50+ Banks)',
                                maxLines: 1,
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(47, 93, 172, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        //----------------------------------------------------------------//
                        const SizedBox(height: 20),

                        filteredItems.isEmpty
                            ? otherTabsContent()
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    SharedPreferencesHelper.getUserPhone() ==
                                            '9999999999'
                                        ? tabsList2.length
                                        : filteredItems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 150,
                                ),
                                padding: const EdgeInsets.only(bottom: 20),
                                itemBuilder: (context, index) {
                                  final tab =
                                      SharedPreferencesHelper.getUserPhone() ==
                                              '9999999999'
                                          ? tabsList2[index]
                                          : filteredItems[index];
                                  if (filteredItems.isNotEmpty) {
                                    return createTab(
                                      size,
                                      title: tab['product_name'],
                                      commission:
                                          tab['product_commission'].toString(),
                                      imagePath: tab['icon'],
                                      offers: tab['product_offer'],
                                      onTap: isCCLoading
                                          ? () {}
                                          : () {
                                              navigateToNextPage(
                                                  context, tab['product_name']);
                                            },
                                    );
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 150,
                                        width: 120,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createTab(
    Size size, {
    required String title,
    required String commission,
    required String imagePath,
    required String offers,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromRGBO(0, 0, 0, 0.33),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                  color: MyColors.blue,
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            title == 'Credit Card'
                ? isCCLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: SpinKitThreeBounce(
                          color: MyColors.blue,
                          size: 25,
                        ),
                      )
                    : Text(
                        title,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      )
                : Text(
                    title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
            const SizedBox(height: 5),
            Text(
              "Commission Rate Up to $commission %",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "($offers Offers)",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(47, 93, 172, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToNextPage(BuildContext context, String nextPageName) {
    switch (nextPageName) {
      case "Personal Loan":
        SharedPreferencesHelper.getUserId() == ''
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false)
            : SharedPreferencesHelper.getUserPhone() == '9999999999'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNav(currentIndex: 1),
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EmiLoanDetails(loanType: 'Personal Loan'),
                    ),
                  );
        break;
      case "Car Loan":
        showToast("Car Loan is not available");
        break;
      case "Home / Mortgage Loan":
        showToast("Home / Mortgage Loan is not available");
        break;
      case "Credit Card":
        SharedPreferencesHelper.getUserId() == ''
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false)
            : SharedPreferencesHelper.getUserPhone() == '9999999999'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNav(currentIndex: 1),
                    ),
                  )
                : generateToken();
        break;
      case "Business Loan":
        SharedPreferencesHelper.getUserId() == ''
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmiLoanDetails(loanType: 'Business Loan'),
                ),
              );
        break;
      case "Student Loan":
        showToast("Student Loan is not available");
        break;
      case "Mutual Fund":
        showToast("Mutual Fund is not available");
        break;
      case "Insurance":
        showToast("Insurance is not available");
        break;
      // Add cases for other loan types
      default:
        showToast("Loan type not available");
        break;
    }
  }

  // toast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget otherTabsContent() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.16),
          const Image(
            height: 250,
            width: 250,
            image: AssetImage('assets/mycases/mycasesfall.png'),
          ),
        ],
      ),
    );
  }
}

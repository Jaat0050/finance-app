// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/controller/lender_controller.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/image_screen.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/pdfscreen.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:path/path.dart' as path;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class LenderViewScreen extends StatefulWidget {
  const LenderViewScreen({super.key});

  @override
  State<LenderViewScreen> createState() => _LenderViewScreenState();
}

class _LenderViewScreenState extends State<LenderViewScreen>
    with TickerProviderStateMixin {
  final lenderController = Get.put(LenderController());
  TabController? tabController;
  // List<dynamic> lenderList = [];
  // List<dynamic> productList = [];
  // bool isLoading = false;

  // Future<void> initializePrefs() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var response = await apiValue.getProductWiseLenders();

  //   List productName = [];
  //   List lender = [];
  //   response.forEach((key, value) {
  //     productName.add(key);
  //     List lenders = value['lenders'];
  //     if (lenders != null && lenders.isNotEmpty) {
  //       lender.addAll(lenders);
  //     }
  //   });

  //   if (productName.isNotEmpty) {
  //     setState(() {
  //       productList.clear();
  //       productList.addAll(productName);
  //       tabController =
  //           TabController(length: productList.length + 1, vsync: this);
  //     });
  //   } else {
  //     tabController = TabController(length: 0, vsync: this);
  //   }

  //   if (lender.isNotEmpty) {
  //     setState(() {
  //       lenderList = lender;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  String getFileExtension(String url) {
    return path.extension(Uri.parse(url).path);
  }

  void initTabController() {
    setState(() {
      if (lenderController.productList.isEmpty) {
        tabController = TabController(length: 0, vsync: this);
      } else {
        tabController = TabController(
            length: lenderController.productList.length + 1, vsync: this);
      }
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 0, vsync: this);
    lenderController.initializePrefs().then((value) {
      initTabController();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: MyColors.black),
        title: Text(
          'Lenders (${lenderController.lenderList.length})',
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        color: MyColors.dullWhite,
        height: size.height,
        width: size.width,
        child: Obx(
          () => Column(
            children: [
              lenderController.isLoading.value
                  ? const SizedBox(height: 0)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.052,
                        // padding: const EdgeInsets.only(left: 20),
                        margin: const EdgeInsets.only(top: 20),
                        child: TabBar(
                          controller: tabController,
                          physics: const BouncingScrollPhysics(),
                          labelColor: MyColors.white,
                          unselectedLabelColor:
                              const Color.fromRGBO(0, 0, 0, 0.4),
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          indicator: BoxDecoration(
                            color: MyColors.blue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(142, 142, 142, 0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          labelStyle: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                          dividerColor: Colors.white,
                          tabs: _buildTabs(lenderController.lenderList.value),
                        ),
                      ),
                    ),
              if (!lenderController.isLoading.value) const SizedBox(height: 30),
              Expanded(
                child: Container(
                  height: size.height * 0.8,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: lenderController.lenderList.isEmpty
                      ? lenderController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyColors.blue,
                              ),
                            )
                          : RefreshIndicator(
                              color: MyColors.blue,
                              onRefresh: () async {
                                lenderController.initLenders().then((value) {
                                  initTabController();
                                });
                              },
                              child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  child: Container(
                                      width: size.width,
                                      height: size.height * 0.7,
                                      child: otherTabsContent())))
                      : TabBarView(
                          controller: tabController,
                          physics: const BouncingScrollPhysics(),
                          children:
                              _buildTabsView(lenderController.lenderList.value),
                        ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(List productsTabsList) {
    List<Widget> tabs = [];
    Map<String, int> counts = {};
    for (var product in lenderController.productList.value) {
      String productname = product;
      List<dynamic> filteredLenders = productsTabsList.where((lender) {
        return lender['type'] == productname;
      }).toList();
      counts[productname] = filteredLenders.length;
    }
    for (var product in lenderController.productList.value) {
      tabs.add(tabContainerBuilder('$product (${counts[product] ?? 0})'));
    }
    tabs.insert(0, tabContainerBuilder('All (${productsTabsList.length})'));
    return tabs;
  }

  List<Widget> _buildTabsView(List productsTabsList) {
    Size size = MediaQuery.of(context).size;
    List<Widget> tabsView = [];
    tabsView.add(
      Obx(
        () => lenderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.blue,
                ),
              )
            : productsTabsList.isEmpty
                ? RefreshIndicator(
                    color: MyColors.blue,
                    onRefresh: () async {
                      lenderController.initLenders().then((value) {
                        initTabController();
                      });
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.7,
                        child: otherTabsContent(),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    color: MyColors.blue,
                    onRefresh: () async {
                      lenderController.initLenders().then((value) {
                        initTabController();
                      });
                    },
                    child: lenderListBuilder(productsTabsList),
                  ),
      ),
    );
    for (var product in lenderController.productList.value) {
      String productname = product;

      List<dynamic> filteredLenders = productsTabsList.where((lender) {
        return lender['type'] == productname;
      }).toList();
      tabsView.add(
        Obx(
          () => lenderController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.blue,
                  ),
                )
              : filteredLenders.isEmpty
                  ? RefreshIndicator(
                      color: MyColors.blue,
                      onRefresh: () async {
                        lenderController.initLenders().then((value) {
                          initTabController();
                        });
                      },
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.7,
                            child: otherTabsContent(),
                          )))
                  : RefreshIndicator(
                      color: MyColors.blue,
                      onRefresh: () async {
                        lenderController.initLenders().then((value) {
                          initTabController();
                        });
                      },
                      child: lenderListBuilder(filteredLenders),
                    ),
        ),
      );
    }

    return tabsView;
  }

  Widget lenderListBuilder(List filteredLenders) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: filteredLenders.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 145,
          mainAxisSpacing: 18,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: MyColors.blue),
              borderRadius: BorderRadius.circular(10),
              color: MyColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //--------------------------------image--------------//
                    Container(
                      width: 60,
                      height: 35,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color:
                                Colors.black.withOpacity(0.10000000149011612),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: filteredLenders[index]['lenderName'] == 'Credilio'
                          ? const Icon(Icons.extension_sharp)
                          : CachedNetworkImage(
                              imageUrl: filteredLenders[index]['lenderImage']
                                  .toString(),
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

                    //----------------------bank name etc--------------//
                    Flexible(
                      child: Text(
                        filteredLenders[index]['lenderName'] == 'Credilio'
                            ? 'Other'
                            : filteredLenders[index]['lenderName'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(2, 2, 2, 1),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //----------------------interest tenure fee--------------//
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Interest\nrate\n${filteredLenders[index]['RateOfInt']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'Tenure\nUp to\n${filteredLenders[index]['tenure']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'Processing\nfee\n${filteredLenders[index]['processingFee']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.6),
                    ),
                    color: Color.fromRGBO(230, 235, 245, 0.62),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          String extension = getFileExtension(
                              filteredLenders[index]['eligibility_criteria']);
                          if (extension == '.pdf') {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => PdfScreen(
                                    initialUrl: filteredLenders[index]
                                        ['eligibility_criteria'],
                                    titleText: 'Eligiblity Criteria'),
                              ),
                            );
                          } else {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ImageScreen(
                                    initialUrl: filteredLenders[index]
                                        ['eligibility_criteria'],
                                    titleText: 'Eligiblity Criteria'),
                              ),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image:
                                  AssetImage('assets/icons/eligibilitydoc.png'),
                              fit: BoxFit.cover,
                              height: 15,
                              width: 15,
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
                      GestureDetector(
                        onTap: () {
                          String extension = getFileExtension(
                              filteredLenders[index]['product_usp']);
                          if (extension == '.pdf') {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => PdfScreen(
                                    initialUrl: filteredLenders[index]
                                        ['product_usp'],
                                    titleText: 'Product USP'),
                              ),
                            );
                          } else {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => ImageScreen(
                                    initialUrl: filteredLenders[index]
                                        ['product_usp'],
                                    titleText: 'Product USP'),
                              ),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/icons/ups.png'),
                              fit: BoxFit.cover,
                              height: 15,
                              width: 15,
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
                      GestureDetector(
                        onTap: () async {
                          String url = filteredLenders[index]['video_url'];
                          Uri uri = Uri.parse(url);
                          await launchUrl(uri);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/icons/vedio.png'),
                              fit: BoxFit.cover,
                              height: 15,
                              width: 15,
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
                )
              ],
            ),
          );
        });
  }

  Widget tabContainerBuilder(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.blue,
            width: 1,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  //-------------------------------- other tabs ----------------------------//
  Widget otherTabsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        const Image(
          height: 250,
          width: 250,
          image: AssetImage('assets/mycases/mycasesfall.png'),
        ),
        Text(
          SharedPreferencesHelper.getUserId() == ''
              ? 'Login first to see Offers'
              : 'No Offer Found',
          style: const TextStyle(
            color: Color.fromRGBO(126, 126, 126, 1),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

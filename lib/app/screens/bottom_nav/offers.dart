// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/controller/offer_controller.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/profile.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';
import 'package:shimmer/shimmer.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen>
    with TickerProviderStateMixin {
  final profileController = Get.put(ProfileController());
  final offerController = Get.put(OfferController());
  TabController? tabController;

  void initTabController() async {
    setState(() {
      if (offerController.offerLanguageList.isEmpty) {
        tabController = TabController(length: 0, vsync: this);
      } else {
        tabController = TabController(
            length: offerController.offerLanguageList.length + 1, vsync: this);
      }
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 0, vsync: this);
    offerController.initializePrefs().then((value) {
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
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: MyColors.black),
        title: Text(
          'Offers',
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          // ======== DP ==========
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 15, top: 8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: SharedPreferencesHelper.getUserId() == ''
                  ? const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage('assets/profile/dummy_dp.png'),
                    )
// <<<<<<< chiragjathan
                  : Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: CachedNetworkImageProvider(
                          profileController.imageUrl.value,
                        ),
// =======
//                   : CircleAvatar(
//                       backgroundColor: Colors.transparent,
//                       backgroundImage: CachedNetworkImageProvider(
//                         profileController.imageUrl.value,
// >>>>>>> arjun
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: MyColors.dullWhite,
          height: size.height * 0.8,
          width: size.width,
          child: Obx(
            () => Column(
              children: [
                offerController.offerList.isEmpty
                    ? SizedBox(height: size.height * 0.08)
                    : Container(
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
                          tabs: _buildTabs(),
                        ),
                      ),
                if (offerController.offerList.isNotEmpty)
                  const SizedBox(height: 30),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: const BouncingScrollPhysics(),
                    children: _buildTabsView(offerController.offerList.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===========tabs=========
  List<Widget> _buildTabs() {
    List<Widget> tabs = [];
    // // Add the 'All' tab
    tabs.add(
      tabContainerBuilder('All'),
    );
    // // Dynamically add tabs based on the categories
    for (var offerLanguage in offerController.offerLanguageList.value) {
      tabs.add(tabContainerBuilder(offerLanguage));
    }
    return tabs;
  }

  List<Widget> _buildTabsView(List offers) {
    Size size = MediaQuery.of(context).size;
    List<Widget> tabsView = [];
    // Add the 'All' tab
    tabsView.add(
      Obx(
        () => offerController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.blue,
                ),
              )
            : offers.isEmpty
                ? RefreshIndicator(
                    color: MyColors.blue,
                    onRefresh: () async {
                      await offerController.initOffers().then((value) {
                        initTabController();
                      });
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: SizedBox(
                        width: size.width,
                        height: size.height * 0.6,
                        child: otherTabsContent(),
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 15, left: 15),
                    child: RefreshIndicator(
                      color: MyColors.blue,
                      onRefresh: () async {
                        await offerController.initOffers().then((value) {
                          initTabController();
                        });
                      },
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: offers.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: size.width,
                                    maxWidth: size.width,
                                    minHeight: size.height * 0.2),
                                // height: size.height * 0.24,
                                // width: size.width,
                                child: CachedNetworkImage(
                                  imageUrl: offers[index]['offer'],
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: MyColors.blue,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (offerController.favouriteOffer
                                            .contains(offers[index]['_id'])) {
                                          offerController.favouriteOffer
                                              .remove(offers[index]['_id']);

                                          await box.put(
                                              'favOffer',
                                              offerController
                                                  .favouriteOffer.value);
                                          setState(() {});
                                        } else {
                                          offerController.favouriteOffer
                                              .add(offers[index]['_id']);

                                          await box.put(
                                              'favOffer',
                                              offerController
                                                  .favouriteOffer.value);
                                          setState(() {});
                                        }
                                      },
                                      child: Icon(
                                        offerController.favouriteOffer
                                                .contains(offers[index]['_id'])
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 24,
                                        color: offerController.favouriteOffer
                                                .contains(offers[index]['_id'])
                                            ? Colors.amber
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
      ),
    );
    // Dynamically add tabs based on the categories
    for (var offer in offerController.offerLanguageList.value) {
      String offerLang = offer;

      List<dynamic> filteredOffers = offers.where((offer) {
        return offer['language'] == offerLang;
      }).toList();

      tabsView.add(
        Obx(
          () => offerController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.blue,
                  ),
                )
              : filteredOffers.isEmpty
                  ? otherTabsContent()
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 15, left: 15),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredOffers.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: size.width,
                                    maxWidth: size.width,
                                    minHeight: size.height * 0.2),
                                // height: size.height * 0.24,
                                // width: size.width,
                                child: CachedNetworkImage(
                                  imageUrl: filteredOffers[index]['offer'],
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    color: MyColors.blue,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (offerController.favouriteOffer
                                            .contains(
                                                filteredOffers[index]['_id'])) {
                                          offerController.favouriteOffer.remove(
                                              filteredOffers[index]['_id']);

                                          await box.put(
                                              'favOffer',
                                              offerController
                                                  .favouriteOffer.value);
                                          setState(() {
                                            offerController.initializePrefs();
                                          });
                                        } else {
                                          offerController.favouriteOffer.add(
                                              filteredOffers[index]['_id']);

                                          await box.put('favOffer',
                                              offerController.favouriteOffer);
                                          setState(() {
                                            offerController.initializePrefs();
                                          });
                                        }
                                      },
                                      child: Icon(
                                        offerController.favouriteOffer.contains(
                                                filteredOffers[index]['_id'])
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 24,
                                        color: offerController.favouriteOffer
                                                .contains(filteredOffers[index]
                                                    ['_id'])
                                            ? Colors.amber
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
        ),
      );
    }

    return tabsView;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

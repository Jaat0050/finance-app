import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mitra_fintech_agent/app/controller/case_controller.dart';
import 'package:mitra_fintech_agent/app/controller/filter_controller.dart';
import 'package:mitra_fintech_agent/app/screens/my_case/filter.dart';
import 'package:mitra_fintech_agent/app/screens/my_case/tabs/credit_card_tab_content.dart';
import 'package:mitra_fintech_agent/app/screens/my_case/tabs/loan_tab_content.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

class MyCasePage extends StatefulWidget {
  final List<bool>? applicationTypes;
  final List<bool>? stateTypes;
  final double? priceRangeStart;
  final double? priceRangeEnd;
  final double? percentRangeStart;
  final double? percentRangeEnd;

  const MyCasePage({
    this.applicationTypes,
    this.stateTypes,
    this.priceRangeStart,
    this.priceRangeEnd,
    this.percentRangeStart,
    this.percentRangeEnd,
    Key? key,
  }) : super(key: key);

  @override
  State<MyCasePage> createState() => _MyCasePageState();
}

class _MyCasePageState extends State<MyCasePage>
    with SingleTickerProviderStateMixin {
  final caseController = Get.put(CaseController());
  // final filterController = Get.put(FilterController());
  // final creditCardController = Get.put(CreditCardController());

  final TextEditingController _searchController = TextEditingController();
  TabController? tabController;

  bool isSearch = false;

  List<bool>? localApplicationTypes;
  List<bool>? localStateTypes;
  double? localPriceRangeStart;
  double? localPriceRangeEnd;
  double? localPercentRangeStart;
  double? localPercentRangeEnd;

  void _filterItems(String query) {
    setState(
      () {
        if (query.isEmpty) {
          if (tabController!.index == 0) {
            caseController.filteredAllLoanCases.value =
                List.from(caseController.allLoanCases);
          } else if (tabController!.index == 1) {
            caseController.filteredCreditCardCases.value =
                List.from(caseController.creditCardCases);
          }
        } else {
          isSearch = true;
          if (tabController!.index == 0) {
            caseController.filteredAllLoanCases.value = caseController
                .allLoanCases
                .where((item) =>
                    item != null &&
                    (item['customer_id']['full_name']
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        item['customer_id']['phoneno']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase())))
                .toList();
          } else if (tabController!.index == 1) {
            caseController.filteredCreditCardCases.value = caseController
                .creditCardCases
                .where((item) =>
                    item != null &&
                    (item['CustomerName']
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        item['CustomerMobile']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase())))
                .toList();
          }
        }
      },
    );
  }

  String userId = '';

  @override
  void initState() {
    caseController.initializePrefs();
    caseController.initCases();

    // filterController.initpriceRange();
    // creditCardController.initializePrefs();
    localApplicationTypes = widget.applicationTypes;
    localStateTypes = widget.stateTypes;
    localPriceRangeStart = widget.priceRangeStart;
    localPriceRangeEnd = widget.priceRangeEnd;
    localPercentRangeStart = widget.percentRangeStart;
    localPercentRangeEnd = widget.percentRangeEnd;

    tabController = TabController(length: 3, vsync: this);
    if (SharedPreferencesHelper.getUserId() == '') {
      setState(() {
        caseController.isCaseLoading.value = false;
      });
    } else {
      setState(() {
        userId = SharedPreferencesHelper.getUserId();
      });
    }
    super.initState();
  }

  // bool checkFilterApplied() {
  //   return filterController.applicationTypes.contains(true) ||
  //       filterController.stateTypes.contains(true) ||
  //       filterController.priceRange.start > 0 ||
  //       filterController.priceRange.end < filterController.maxPrice;
  // }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: MyColors.dullWhite,
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                const SizedBox(height: 5),
                //--------------------------------top bar------------------------------------//
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Leads',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Visibility(
                      //       visible: userId != '' ||
                      //           caseController.allCases.isEmpty,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           // Navigator.push(
                      //           //   context,
                      //           //   MaterialPageRoute(
                      //           //     builder: (context) => const Filter(),
                      //           //   ),
                      //           // );
                      //         },
                      //         child: Icon(
                      //           Icons.filter_alt_outlined,
                      //           color: checkFilterApplied()
                      //               ? MyColors.blue
                      //               : const Color.fromRGBO(84, 84, 84, 0.8),
                      //           size: 20,
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 5),
                      //     Visibility(
                      //       visible: checkFilterApplied(),
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           filterController.clearFilters();
                      //         },
                      //         child: const Center(
                      //           child: Text(
                      //             'Clear Filters',
                      //             style: TextStyle(
                      //               fontFamily: 'Rubik',
                      //               fontWeight: FontWeight.w400,
                      //               color: Colors.red,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),

                //------------------------------search part-----------------------------------//
                if (userId != '')
                  Obx(
                    () => caseController.allLoanCases.isEmpty &&
                            caseController.creditCardCases.isEmpty &&
                            !isSearch
                        ? SizedBox(
                            height: size.height * 0.2,
                          )
                        : Container(
                            height: 45,
                            width: size.width * 0.9,
                            margin: const EdgeInsets.only(top: 15),
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
                                      hintText: 'Search case',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.only(bottom: 5),
                                      hintStyle: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.4),
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
                                      if (tabController!.index == 0) {
                                        caseController
                                                .filteredAllLoanCases.value =
                                            List.from(
                                                caseController.allLoanCases);
                                      } else if (tabController!.index == 1) {
                                        caseController
                                                .filteredCreditCardCases.value =
                                            List.from(
                                                caseController.creditCardCases);
                                      }
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                //------------------------------tabs name-----------------------------------//
                // if (!isSearch)

                Obx(
                  () => caseController.allLoanCases.isEmpty &&
                          caseController.creditCardCases.isEmpty
                      ? SizedBox(
                          height: size.height * 0.1,
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Container(
                              width: size.width,
                              height: size.height * 0.052,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
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
                                tabs: [
                                  tabContainerBuilder(
                                      'Personal Loan (${caseController.allLoanCases.length})'),
                                  tabContainerBuilder(
                                      'Credit Card (${caseController.creditCardCases.length})'),
                                  tabContainerBuilder(
                                      'Business Loan (${caseController.allLoanCases.where((element) => element['type'] == 'Business Loan').toList().length})'),
                                ],
                              )),
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),

                Expanded(
                  child: Obx(
                    () => caseController.allLoanCases.isEmpty &&
                            caseController.creditCardCases.isEmpty
                        ? caseController.isCaseLoading.value
                            ? Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.width * 0.6),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.blue,
                                  ),
                                ),
                              )
                            : RefreshIndicator(
                                color: MyColors.blue,
                                onRefresh: () async {
                                  await caseController.initCases();
                                },
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  child: otherTabsContent(),
                                ),
                              )
                        : TabBarView(
                            controller: tabController,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              // //--------------------------------------tab Personal-----------------------------------------//
                              allTabContent(
                                  caseController.filteredAllLoanCases.value,
                                  'Personal Loan'),

                              // //--------------------------------------tab Credit Card-----------------------------------------//
                              allTabContent(
                                  caseController.filteredCreditCardCases.value,
                                  'Credit Card'),

                              // //--------------------------------------tab Business-----------------------------------------//
                              allTabContent(
                                  caseController.filteredAllLoanCases
                                      .where((element) =>
                                          element['type'] == 'Business Loan')
                                      .toList(),
                                  'Business Loan'),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------------- all tab ----------------------------//
  Widget allTabContent(List casesList, String type) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: MyColors.blue,
      onRefresh: () async {
        await caseController.initCases();
        // filterController.applyFilter();
      },
      child: casesList.isEmpty
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: otherTabsContent(),
            )
          : ListView.separated(
              itemCount: casesList.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 25,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                if ((localApplicationTypes == null ||
                        !localApplicationTypes!.contains(true)) ||
                    (casesList[index]['partner'] == 'CREDILIO' &&
                        localApplicationTypes?[3] == true) ||
                    (casesList[index]['partner'] != 'CREDILIO' &&
                        localApplicationTypes?[0] == true)) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == casesList.length - 1 ? 200 : 0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.02),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 0.09),
                              width: 1,
                            ),
                          ),
                          child: type == 'Credit Card'
                              ? creditCardTabContent(size, casesList[index])
                              : loanTabContent(size, casesList[index]),
                        ),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
    );
  }

  //-------------------------------- other tabs ----------------------------//
  Widget otherTabsContent() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.09),
          const Image(
            height: 250,
            width: 250,
            image: AssetImage('assets/mycases/mycasesfall.png'),
          ),
          Text(
            userId == '' ? 'Login first to see Leads' : 'No Leads Found',
            style: const TextStyle(
              color: Color.fromRGBO(126, 126, 126, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_fintech_agent/app/controller/filter_controller.dart';

import '../../utils/constants.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final filterController = Get.put(FilterController());
  int currentRoute = 0;
  CaseFilter filter = CaseFilter();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Filters',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              filterController.clearFilters();
              // Navigator.pop(context);
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  'Clear Filters',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: VerticalNavBar(
              selectedIndex: currentRoute,
              height: size.height,
              width: size.width * 0.6,
              onItemSelected: (value) {
                _navigateRoutes(value);
              },
              items: const [
                VerticalNavBarItem(title: "Application Type"),
                VerticalNavBarItem(title: "Stage of Application"),
                VerticalNavBarItem(title: "Commission Amount"),
                // VerticalNavBarItem(title: "Commission Rate"),
              ],
            ),
          ),

          // Content Area
          Expanded(
            flex: 3,
            child: _buildPageContent(currentRoute),
          ),
        ],
      ),
    );
  }

  void _navigateRoutes(int selectedIndex) {
    setState(() {
      currentRoute = selectedIndex;
    });
  }

  // Function to build content for each page
  Widget _buildPageContent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        Size size = MediaQuery.of(context).size;
        return Column(
          children: [
            ...List.generate(
              filterController.applicationTypes.length,
              (index) => Obx(
                () => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: MyColors.white,
                  activeColor: MyColors.blue,
                  visualDensity: const VisualDensity(horizontal: -4),
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 10),
                  title: Text(
                    filterController.applicationTypeNames[index],
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                  value: filterController.applicationTypes.value[index],
                  onChanged: (bool? value) {
                    setState(() {
                      filterController.updateApplicationType(
                          index, value ?? false);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue,
                    disabledBackgroundColor: MyColors.veryLightBlue,
                    minimumSize: const Size(150, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    filterController.applyFilter();
                    Navigator.pop(context);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => BottomNav(
                    //       applicationTypes:
                    //           filterController.applicationTypes.value,
                    //       stateTypes: filterController.stateTypes.value,
                    //       priceRangeStart: filterController.priceRange.start,
                    //       priceRangeEnd: filterController.priceRange.end,
                    //       currentIndex: 1,
                    //     ),
                    //   ),
                    //   (route) => false,
                    // );
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      case 1:
        Size size = MediaQuery.of(context).size;
        return Column(
          children: [
            ...List.generate(
              filterController.stateTypes.length,
              (index) => Obx(
                () => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: MyColors.white,
                  activeColor: MyColors.blue,
                  visualDensity: const VisualDensity(horizontal: -4),
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 10),
                  title: Text(
                    filterController.stateTypeNames[index],
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                  value: filterController.stateTypes.value[index],
                  onChanged: (bool? value) {
                    setState(() {
                      filterController.updateStateType(index, value ?? false);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue,
                    disabledBackgroundColor: MyColors.veryLightBlue,
                    minimumSize: const Size(150, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    filterController.applyFilter();
                    Navigator.pop(context);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => BottomNav(
                    //       applicationTypes:
                    //           filterController.applicationTypes.value,
                    //       stateTypes: filterController.stateTypes.value,
                    //       priceRangeStart: filterController.priceRange.start,
                    //       priceRangeEnd: filterController.priceRange.end,
                    //       currentIndex: 1,
                    //     ),
                    //   ),
                    //   (route) => false,
                    // );
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
        Size size = MediaQuery.of(context).size;
        return Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: MyColors.blue,
                inactiveTrackColor: MyColors.mediumGrey,
                thumbColor: MyColors.blue,
                trackHeight: 0.2,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 5,
                ),
              ),
              child: RangeSlider(
                min: 0,
                max: filterController.maxPrice,
                values: filterController.priceRange,
                onChanged: (values) {
                  setState(() {
                    filterController.priceRange = values;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ ${filterController.priceRange.start.round()}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  Text(
                    '₹ ${filterController.priceRange.end.round()}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue,
                    disabledBackgroundColor: MyColors.veryLightBlue,
                    minimumSize: const Size(150, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    filterController.applyFilter();
                    Navigator.pop(context);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => BottomNav(
                    //       applicationTypes:
                    //           filterController.applicationTypes.value,
                    //       stateTypes: filterController.stateTypes.value,
                    //       priceRangeStart: filterController.priceRange.start,
                    //       priceRangeEnd: filterController.priceRange.end,
                    //       currentIndex: 1,
                    //     ),
                    //   ),
                    //   (route) => false,
                    // );
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      // case 3:
      //   Size size = MediaQuery.of(context).size;
      //   return Column(
      //     children: [
      //       SliderTheme(
      //         data: SliderTheme.of(context).copyWith(
      //           activeTrackColor: MyColors.blue,
      //           inactiveTrackColor: MyColors.mediumGrey,
      //           thumbColor: MyColors.blue,
      //           trackHeight: 0.2,
      //           rangeThumbShape: const RoundRangeSliderThumbShape(
      //             enabledThumbRadius: 5,
      //           ),
      //         ),
      //         child: RangeSlider(
      //           min: 0,
      //           max: 10,
      //           values: filterController.percentRange,
      //           onChanged: (values) {
      //             setState(() {
      //               filterController.percentRange = values;
      //             });
      //           },
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               '${filterController.percentRange.start.round()} %',
      //               style: const TextStyle(
      //                 fontSize: 9,
      //                 fontWeight: FontWeight.w400,
      //                 color: Colors.black,
      //                 fontFamily: 'Rubik',
      //               ),
      //             ),
      //             Text(
      //               '${filterController.percentRange.end.round()} %',
      //               style: const TextStyle(
      //                 fontSize: 9,
      //                 fontWeight: FontWeight.w400,
      //                 color: Colors.black,
      //                 fontFamily: 'Rubik',
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: size.height * 0.04),
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Container(
      //           padding: const EdgeInsets.only(left: 20),
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: MyColors.blue,
      //               disabledBackgroundColor: MyColors.veryLightBlue,
      //               minimumSize: const Size(150, 35),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(8),
      //               ),
      //             ),
      //             onPressed: () {
      //               Navigator.pushAndRemoveUntil(
      //                 context,
      //                 MaterialPageRoute<void>(
      //                   builder: (BuildContext context) => BottomNav(
      //                     applicationTypes:
      //                         filterController.applicationTypes.value,
      //                     stateTypes: filterController.stateTypes.value,
      //                     priceRangeStart: filterController.percentRange.start,
      //                     priceRangeEnd: filterController.priceRange.end,
      //                     percentRangeStart:
      //                         filterController.percentRange.start,
      //                     percentRangeEnd: filterController.percentRange.end,
      //                     currentIndex: 1,
      //                   ),
      //                 ),
      //                 (route) => false,
      //               );
      //             },
      //             child: const Text(
      //               'Apply',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 10,
      //                 fontWeight: FontWeight.w700,
      //                 fontFamily: 'Nunito',
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   );
      default:
        return Container(); // Default empty container
    }
  }
}

// Vertical Navigation Bar Widget
class VerticalNavBar extends StatelessWidget {
  final int selectedIndex;
  final double height;
  final double width;
  final ValueChanged<int> onItemSelected;
  final List<VerticalNavBarItem> items;

  const VerticalNavBar({
    super.key,
    required this.selectedIndex,
    required this.height,
    required this.width,
    required this.onItemSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: const Color(0xffECECEC), // Adjust the color as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items
            .asMap()
            .entries
            .map(
              (entry) => GestureDetector(
                onTap: () => onItemSelected(entry.key),
                child: Container(
                  color: entry.key == selectedIndex
                      ? const Color(0xffDDDDDD) // Highlight selected item
                      : Colors.transparent,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    entry.value.title,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik',
                      fontSize: 11,
                      color: entry.key == selectedIndex
                          ? MyColors.blue // Highlight selected item
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// Vertical Navigation Bar Item Model
class VerticalNavBarItem {
  final String title;

  const VerticalNavBarItem({
    required this.title,
  });
}

class CaseFilter {
  bool showAll;
  bool showPersonal;
  bool showBusiness;
  bool showCar;
  bool showHome;

  CaseFilter({
    this.showAll = true,
    this.showPersonal = true,
    this.showBusiness = true,
    this.showCar = true,
    this.showHome = true,
  });
}

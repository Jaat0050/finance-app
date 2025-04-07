import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_fintech_agent/app/controller/broadcast_controller.dart';
import 'package:mitra_fintech_agent/app/controller/case_controller.dart';
import 'package:mitra_fintech_agent/app/controller/offer_controller.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/broadcast.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/my_case.dart';
import 'package:mitra_fintech_agent/app/screens/bottom_nav/offers.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';

// ignore: must_be_immutable
class BottomNav extends StatefulWidget {
  final List<bool>? applicationTypes;
  final List<bool>? stateTypes;
  final double? priceRangeStart;
  final double? priceRangeEnd;
  final double? percentRangeStart;
  final double? percentRangeEnd;
  int currentIndex;
  BottomNav({
    this.applicationTypes,
    this.stateTypes,
    this.priceRangeStart,
    this.priceRangeEnd,
    this.percentRangeStart,
    this.percentRangeEnd,
    required this.currentIndex,
    super.key,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  List<Widget> get pages => [
        const HomePage(),
        MyCasePage(
            applicationTypes: widget.applicationTypes,
            stateTypes: widget.stateTypes,
            priceRangeStart: widget.priceRangeStart,
            priceRangeEnd: widget.priceRangeEnd,
            percentRangeStart: widget.percentRangeStart,
            percentRangeEnd: widget.percentRangeEnd),
        const OffersScreen(),
        const BroadcastScreen(),
      ];

  void _onItemTapped(int index) async {
    if (index >= 0 && index < pages.length) {
      setState(() {
        _selectedIndex = index;
      });
      await FirebaseAnalytics.instance.logEvent(
          name: 'visiting_$index', parameters: {'time': '${DateTime.now()}'});
    }
  }

  void firebaseAnalytics() async {
    await FirebaseAnalytics.instance.logEvent(
        name: 'visiting_$_selectedIndex',
        parameters: {'time': '${DateTime.now()}'});
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
    firebaseAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: pages.elementAt(_selectedIndex),
          bottomNavigationBar: Material(
            color: Colors.transparent,
            child: Container(
              height: 55,
              margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                shadows: [
                  BoxShadow(
                    // color: Colors.black.withOpacity(0.16),
                    // blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,

                unselectedItemColor: const Color.fromRGBO(147, 147, 147, 1),
                selectedItemColor: MyColors.blue,
                selectedFontSize: 12,
                unselectedFontSize: 9,
                unselectedLabelStyle: const TextStyle(
                  color: Color.fromRGBO(147, 147, 147, 1),
                  fontFamily: "Nunito",
                ),
                selectedLabelStyle: TextStyle(
                  color: MyColors.blue,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w500,
                ),
                elevation: 10,
                backgroundColor: const Color.fromRGBO(243, 245, 247, 1),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.home,
                      size: 25,
                      color: MyColors.blue,
                    ),
                    icon: const Icon(
                      Icons.home,
                      size: 20,
                      color: Color.fromRGBO(147, 147, 147, 1),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.bar_chart_sharp,
                      size: 25,
                      color: MyColors.blue,
                    ),
                    icon: const Icon(
                      Icons.bar_chart_sharp,
                      size: 20,
                      color: Color.fromRGBO(147, 147, 147, 1),
                    ),
                    label: 'My Leads',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.local_offer_outlined,
                      color: MyColors.blue,
                      size: 25,
                    ),
                    icon: const Icon(
                      Icons.local_offer_outlined,
                      color: Color.fromRGBO(147, 147, 147, 1),
                      size: 20,
                    ),
                    label: 'Offers',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.screen_share_outlined,
                      size: 25,
                      color: MyColors.blue,
                    ),
                    icon: const Icon(
                      Icons.screen_share_outlined,
                      size: 20,
                      color: Color.fromRGBO(147, 147, 147, 1),
                    ),
                    label: 'Broadcast',
                  ),
                ],
                currentIndex: _selectedIndex,
                // selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

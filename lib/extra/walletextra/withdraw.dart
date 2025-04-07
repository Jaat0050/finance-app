// import 'package:flutter/material.dart';
// import 'package:mitra_fintech_agent/app/screens/wallet/last_withdrawal.dart';
// import 'package:mitra_fintech_agent/app/screens/wallet/select_bank.dart';
// import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// import '../../utils/constants.dart';
// import 'add_upi.dart';

// // ignore: must_be_immutable
// class Withdraw extends StatefulWidget {
//   int tabIndex;
//   Withdraw({required this.tabIndex, super.key});

//   @override
//   State<Withdraw> createState() => _WithdrawState();
// }

// class _WithdrawState extends State<Withdraw>
//     with SingleTickerProviderStateMixin {
//   TextEditingController searchController = TextEditingController();
//   TabController? tabController;

//   @override
//   void initState() {
//     tabController =
//         TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     tabController?.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyColors.dullWhite,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         scrolledUnderElevation: 0,
//         title: Row(
//           children: [
//             IconButton(
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Text(
//               'Withdraw',
//               style: TextStyle(
//                 fontFamily: 'Rubik',
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           height: size.height,
//           width: size.width,
//           color: MyColors.dullWhite,
//           // padding: EdgeInsets.only(left: 20, right: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: size.width,
//                   padding: const EdgeInsets.only(top: 20, bottom: 10),
//                   child: Column(
//                     children: [
//                       //-----------------------------------search-------------------------------//
//                       Container(
//                         width: size.width * 0.9,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border:
//                               Border.all(color: MyColors.greyShadow, width: 1),
//                         ),
//                         child: const Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(Icons.search,
//                                   color: Color.fromRGBO(0, 0, 0, 0.6)),
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Search bank account, UPI ID',
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //-----------------------------tab container--------------------------------//
//                       Container(
//                         height: size.height * 0.74,
//                         decoration: const BoxDecoration(
//                           color: Color.fromRGBO(217, 217, 217, 0.13),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30.0),
//                             topRight: Radius.circular(30.0),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             //===============================tabs--------------------------------------//
//                             TabBar(
//                               controller: tabController,
//                               physics: const BouncingScrollPhysics(),
//                               // tabAlignment: TabAlignment.fill,
//                               labelColor: MyColors.blue,
//                               unselectedLabelColor:
//                                   const Color.fromRGBO(70, 70, 70, 1),
//                               indicatorSize: TabBarIndicatorSize.label,
//                               indicatorColor: MyColors.blue,
//                               labelStyle: const TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 15,
//                               ),
//                               dividerColor:
//                                   const Color.fromRGBO(212, 212, 212, 0.5),
//                               // dividerHeight: 1,
//                               tabs: const [
//                                 Tab(
//                                   child: Text('Bank Accounts'),
//                                 ),
//                                 Tab(
//                                   child: Text('UPI ID'),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Expanded(
//                               child: TabBarView(
//                                 controller: tabController,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       ListView.separated(
//                                         itemCount: 1,
//                                         separatorBuilder:
//                                             (BuildContext context, int index) =>
//                                                 const Divider(),
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           return ListTile(
//                                             leading: Container(
//                                               height: 45,
//                                               width: 45,
//                                               decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: Colors.orange,
//                                               ),
//                                               child: const Center(
//                                                 child: Text(
//                                                   'A',
//                                                   style: TextStyle(
//                                                     fontFamily: 'Nunito',
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.white,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             title: Text(
//                                               '${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}',
//                                               style: const TextStyle(
//                                                 fontFamily: 'Nunito',
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Color.fromRGBO(
//                                                     41, 41, 41, 1),
//                                                 fontSize: 17,
//                                               ),
//                                             ),
//                                             subtitle: Text(
//                                               '${SharedPreferencesHelper.getUserPhone()}@upi',
//                                               style: const TextStyle(
//                                                 fontFamily: 'Nunito',
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Color.fromRGBO(
//                                                     91, 91, 91, 1),
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             trailing: const Icon(
//                                                 Icons.more_vert_rounded),
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         LastWithdrawalScreen(
//                                                             upiID:
//                                                                 '${SharedPreferencesHelper.getUserPhone()}@upi'),
//                                                   ));
//                                             },
//                                           );
//                                         },
//                                       ),
//                                       Positioned(
//                                         bottom: 20,
//                                         right: 20,
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const SelectBankAccount()),
//                                             );
//                                           },
//                                           child: Container(
//                                             height: 68,
//                                             width: 68,
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: MyColors.blue,
//                                             ),
//                                             child: const Center(
//                                               child: Icon(
//                                                 Icons.add,
//                                                 color: Colors.white,
//                                                 size: 30,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Stack(
//                                     children: [
//                                       ListView.separated(
//                                         itemCount: 1,
//                                         separatorBuilder:
//                                             (BuildContext context, int index) =>
//                                                 const Divider(),
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           return ListTile(
//                                             leading: Container(
//                                               height: 45,
//                                               width: 45,
//                                               decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: Colors.orange,
//                                               ),
//                                               child: const Center(
//                                                 child: Text(
//                                                   'A',
//                                                   style: TextStyle(
//                                                     fontFamily: 'Nunito',
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.white,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             title: Text(
//                                               '${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}',
//                                               style: const TextStyle(
//                                                 fontFamily: 'Nunito',
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Color.fromRGBO(
//                                                     41, 41, 41, 1),
//                                                 fontSize: 17,
//                                               ),
//                                             ),
//                                             subtitle: Text(
//                                               '${SharedPreferencesHelper.getUserPhone()}@upi',
//                                               style: const TextStyle(
//                                                 fontFamily: 'Nunito',
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Color.fromRGBO(
//                                                     91, 91, 91, 1),
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             trailing: const Icon(
//                                                 Icons.more_vert_rounded),
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         LastWithdrawalScreen(
//                                                           upiID:
//                                                               '${SharedPreferencesHelper.getUserPhone()}@upi',
//                                                         )),
//                                               );
//                                             },
//                                           );
//                                         },
//                                       ),
//                                       Positioned(
//                                         bottom: 20,
//                                         right: 20,
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const UpiAddScreen(),
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             height: 68,
//                                             width: 68,
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: MyColors.blue,
//                                             ),
//                                             child: const Center(
//                                               child: Icon(
//                                                 Icons.add,
//                                                 color: Colors.white,
//                                                 size: 30,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       // floatingActionButton: GestureDetector(
//       //   onTap: () async {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => UpiAddScreen(),
//       //       ),
//       //     );
//       //   },
//       //   child: Container(
//       //     height: 68,
//       //     width: 68,
//       //     decoration: BoxDecoration(
//       //       shape: BoxShape.circle,
//       //       color: MyColors.blue,
//       //     ),
//       //     child: Center(
//       //       child: Icon(
//       //         Icons.add,
//       //         color: Colors.white,
//       //         size: 30,
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

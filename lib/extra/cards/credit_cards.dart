// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mitra_fintech_agent/app/api_value.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/emi%20calculator%20and%20offers/offers/fatakpay/fatak_pay_screen.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/web_screen.dart';
// import 'package:mitra_fintech_agent/app/utils/constants.dart';
// import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// class CreditCards extends StatefulWidget {
//   const CreditCards({super.key});

//   @override
//   State<CreditCards> createState() => _CreditCardsState();
// }

// class _CreditCardsState extends State<CreditCards> {
//   List filteredList = [
//     {
//       "bankName": "Credilio",
//       "rate": 16,
//       "processing_fee": 2,
//       "multiplier": 14,
//       "image": "assets/credilio.png",
//     },
//     {
//       "bankName": "FatakPay",
//       "rate": 16,
//       "processing_fee": 2,
//       "multiplier": 14,
//       "image": "assets/fpay.png",
//     },
//   ];

//   void generateToken() async {
//     String? token2 = await apiValue
//         .generateDashboardToken(SharedPreferencesHelper.getUsertempId());
//     if (token2 != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => WebScreen(
//             titleText: 'Credit Card',
//             initialUrl: crediliokeys.dashboardUrl + token2,
//           ),
//         ),
//       );
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyColors.dullWhite,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         scrolledUnderElevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             Text(
//               'Card Offers ${filteredList.length}',
//               style: TextStyle(
//                 fontFamily: 'Rubik',
//                 fontWeight: FontWeight.w500,
//                 color: MyColors.black,
//                 fontSize: 17,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: MyColors.dullWhite,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//           child: ListView.separated(
//             itemCount: filteredList.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 10,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: GestureDetector(
//                   onTap: () {
//                     if (filteredList[index]['bankName'] == 'Credilio') {
//                       generateToken();
//                     } else if (filteredList[index]['bankName'] == 'FatakPay') {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => FatakPayScreen(),
//                       //   ),
//                       // );
//                     } else {
//                       null;
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 0.60,
//                         color: MyColors.blue,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       color: MyColors.white,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             //--------------------------------image--------------//
//                             Container(
//                               width: 62,
//                               height: 42,
//                               padding: EdgeInsets.all(5),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(
//                                     width: 1,
//                                     color: Colors.black
//                                         .withOpacity(0.10000000149011612),
//                                   ),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                               ),
//                               child: Image(
//                                 image: AssetImage(
//                                   filteredList[index]['image'].toString(),
//                                 ),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 15,
//                             ),
//                             //----------------------bank name etc--------------//
//                             SizedBox(
//                               height: 45,
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.6,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       filteredList[index]['bankName'],
//                                       style: TextStyle(
//                                         color: Color(0xFF1E1E1E),
//                                         fontSize: 16,
//                                         fontFamily: 'Nunito',
//                                         fontWeight: FontWeight.w500,
//                                         height: 0,
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.arrow_forward_ios_sharp,
//                                       color: Colors.grey,
//                                       size: 15,
//                                     )
//                                     // SizedBox(
//                                     //   height: 5,
//                                     // ),
//                                     // Text(
//                                     //   'Amount - ${NumberFormat('#,##,###').format(int.parse('20000'))}',
//                                     // style: TextStyle(
//                                     //   color: Color(0xFF1E1E1E),
//                                     //   fontSize: 16,
//                                     //   fontFamily: 'Nunito',
//                                     //   fontWeight: FontWeight.w500,
//                                     //   height: 0,
//                                     // ),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         // SizedBox(
//                         //   height: 20,
//                         // ),
//                         //----------------------interest tenure fee--------------//
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         //     Text(
//                         //       'Interest rate \n${filteredList[index]['rate']}% p.a',
//                         //       textAlign: TextAlign.center,
//                         //       style: TextStyle(
//                         //         color: Color(0xFF545454),
//                         //         fontSize: 13,
//                         //         fontFamily: 'Inter',
//                         //         fontWeight: FontWeight.w500,
//                         //         height: 0,
//                         //       ),
//                         //     ),
//                         //     Text(
//                         //       'Tenure\nUp to ${filteredList[index]['multiplier']} months',
//                         //       textAlign: TextAlign.center,
//                         //       style: TextStyle(
//                         //         color: Color(0xFF545454),
//                         //         fontSize: 13,
//                         //         fontFamily: 'Inter',
//                         //         fontWeight: FontWeight.w500,
//                         //         height: 0,
//                         //       ),
//                         //     ),
//                         //     Text(
//                         //       'Processing fee\n ${filteredList[index]['processing_fee']}%',
//                         //       textAlign: TextAlign.center,
//                         //       style: TextStyle(
//                         //         color: Color(0xFF545454),
//                         //         fontSize: 13,
//                         //         fontFamily: 'Inter',
//                         //         fontWeight: FontWeight.w500,
//                         //         height: 0,
//                         //       ),
//                         //     )
//                         //   ],
//                         // )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

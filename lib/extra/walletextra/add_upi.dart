// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:mitra_fintech_agent/app/screens/wallet/withdraw.dart';
// import 'package:mitra_fintech_agent/app/utils/commission_controller.dart';

// import '../../utils/constants.dart';

// class UpiAddScreen extends StatefulWidget {
//   const UpiAddScreen({super.key});

//   @override
//   State<UpiAddScreen> createState() => _UpiAddScreenState();
// }

// class _UpiAddScreenState extends State<UpiAddScreen> {
//   final TextEditingController _idController = TextEditingController();
//   late CommissionController commissionController;

//   Future<void> initializePrefs() async {
//     await Future.wait([
//       commissionController.getCommissionDetails(),
//     ]);

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     // fetchPromoCode();
//     commissionController = Get.put(CommissionController());

//     super.initState();
//     initializePrefs();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _idController.dispose();
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
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Text(
//               'Add UPI ID',
//               style: TextStyle(
//                 fontFamily: 'Rubik',
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//             // Spacer(),
//             // InkWell(
//             //   onTap: (){
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) => EditProfile(),
//             //       ),
//             //     );
//             //   },
//             //   child: Text(
//             //     'Edit Profile',
//             //     style: TextStyle(
//             //       fontFamily: 'Nunito',
//             //       fontWeight: FontWeight.w500,
//             //       color: MyColors.veryLightBlue, // Adjust color as needed
//             //       fontSize: 15,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //---------------------------------text 1---------------------------//
//                 const Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Text(
//                     "You can pay or request money to your contact's UPI ID. When the UPI ID is successfully verified, the contact's name is returned.",
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: Color.fromRGBO(48, 48, 48, 1),
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 //--------------------------------------textfield------------------------//
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 2),
//                         child: Text(
//                           "Beneficiary UPI ID",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             color: Color.fromRGBO(48, 48, 48, 1),
//                             fontFamily: 'Nunito',
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       TextField(
//                         decoration: InputDecoration(
//                           isDense: true,
//                           contentPadding: const EdgeInsets.only(
//                               top: 5, left: 10, right: 20, bottom: 5),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: MyColors.blue,
//                               width: 1,
//                             ),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: MyColors.blue,
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                         textAlign: TextAlign.start,
//                         controller: _idController,
//                         cursorColor: MyColors.blue,
//                       ),
//                     ],
//                   ),
//                 ),
//                 //------------------------------------verify button------------------------//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 25),
//                   child: Container(
//                     height: size.height * 0.05,
//                     width: size.width * 0.2,
//                     decoration: BoxDecoration(
//                       color: MyColors.blue,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Verify',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: 'Nunito',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             //--------------------------------save button---------------------------//
//             Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.blue,
//                   minimumSize: const Size(double.infinity, 45),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: isLoading
//                     ? null
//                     : () async {
//                         if (_idController.text.isEmpty) {
//                           Fluttertoast.showToast(
//                             msg: "Please Enter Your UPI ID",
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: MyColors.blue,
//                             textColor: Colors.white,
//                             fontSize: 16.0,
//                           );
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Withdraw(tabIndex: 0),
//                             ),
//                           );
//                         }
//                       },
//                 child: isLoading
//                     ? const Align(
//                         alignment: Alignment.center,
//                         child: SpinKitThreeBounce(
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       )
//                     : const Text(
//                         'Save',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: 'Nunito',
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool isLoading = false;
// }

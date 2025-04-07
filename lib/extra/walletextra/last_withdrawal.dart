// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mitra_fintech_agent/app/api/api_value.dart';
// import 'package:mitra_fintech_agent/app/screens/wallet/transfer_success.dart';
// import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
// import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// import '../../utils/constants.dart';

// // ignore: must_be_immutable
// class LastWithdrawalScreen extends StatefulWidget {
//   String upiID;
//   LastWithdrawalScreen({required this.upiID, super.key});

//   @override
//   State<LastWithdrawalScreen> createState() => _LastWithdrawalScreenState();
// }

// class _LastWithdrawalScreenState extends State<LastWithdrawalScreen> {
//   TextEditingController amountController = TextEditingController();
//   @override
//   void dispose() {
//     super.dispose();
//     amountController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
//             padding: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               size: 20,
//               Icons.arrow_back_sharp,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           height: size.height,
//           width: size.width,
//           color: Colors.white,
//           padding: const EdgeInsets.only(right: 20, left: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 70,
//                   width: 70,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.transparent,
//                   ),
//                   child: const CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     // backgroundImage: CachedNetworkImageProvider(
//                     //   SharedPreferencesHelper.getUserProfilePic(),

//                     // ),
//                     backgroundImage: AssetImage('assets/profile/dummy_dp.png'),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   'Paying ${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}',
//                   style: const TextStyle(
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 2,
//                 ),
//                 Text(
//                   widget.upiID,
//                   style: const TextStyle(
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 2,
//                 ),
//                 Text(
//                   'Banking Name: ${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}',
//                   style: const TextStyle(
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.w500,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 SizedBox(
//                   width: size.width * 0.35,
//                   child: Center(
//                     child: TextField(
//                       controller: amountController,
//                       cursorColor: MyColors.blue,
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       style: const TextStyle(
//                         fontSize: 20,
//                       ),
//                       decoration: InputDecoration(
//                         isDense: true,
//                         alignLabelWithHint: true,
//                         hintText: 'Enter Amount',
//                         hintStyle: TextStyle(
//                           fontFamily: 'Nunito',
//                           fontWeight: FontWeight.w600,
//                           color: MyColors.blue,
//                           fontSize: 12,
//                         ),
//                         enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide.none),
//                         focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide.none),
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 6),
//                           child: Text(
//                             '₹',
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w600,
//                               color: MyColors.blue,
//                               fontSize: 28,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: GestureDetector(
//         onTap: isLoading
//             ? null
//             : () async {
//                 if (amountController.text.isEmpty) {
//                   Fluttertoast.showToast(
//                     msg: "Please Enter Your Mobile Number",
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: MyColors.blue,
//                     textColor: Colors.white,
//                     fontSize: 16.0,
//                   );
//                 } else {
//                   setState(() {
//                     isLoading = true;
//                   });
//                   if (await apiValue
//                           .getWithdrawal(amountController.text.toString()) ==
//                       'success') {
//                     await GetUserData()
//                         .getUserDetails(SharedPreferencesHelper.getUserId());
//                     setState(() {
//                       isLoading = false;
//                     });
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TransactionSuccessful(
//                             amount: amountController.text.toString()),
//                       ),
//                       (route) => false, // Remove all routes from the stack
//                     );
//                   } else {
//                     setState(() {
//                       isLoading = false;
//                     });
//                     Fluttertoast.showToast(
//                         msg: "Something Went Wrong",
//                         toastLength: Toast.LENGTH_LONG,
//                         gravity: ToastGravity.BOTTOM,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: MyColors.blue,
//                         textColor: Colors.white,
//                         fontSize: 16.0);
//                   }
//                   setState(() {
//                     isLoading = false;
//                   });
//                 }
//               },
//         child: isLoading
//             ? Container(
//                 height: 55,
//                 width: 55,
//                 decoration: BoxDecoration(
//                   color: MyColors.blue,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const Align(
//                   alignment: Alignment.center,
//                   child: SpinKitThreeBounce(
//                     color: Colors.white,
//                     size: 15,
//                   ),
//                 ),
//               )
//             : Container(
//                 height: 55,
//                 width: 55,
//                 decoration: BoxDecoration(
//                   color: MyColors.blue,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.arrow_forward,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   bool isLoading = false;
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';

// import '../../utils/constants.dart';

// // ignore: must_be_immutable
// class TransactionSuccessful extends StatefulWidget {
//   String amount;
//   TransactionSuccessful({required this.amount, super.key});

//   @override
//   State<TransactionSuccessful> createState() => _TransactionSuccessfulState();
// }

// class _TransactionSuccessfulState extends State<TransactionSuccessful> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Container(
//         height: size.height,
//         width: size.width,
//         color: Colors.white,
//         padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 height: size.height * 0.7,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Container(
//                           height: 200,
//                           width: 200,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 'assets/uploadDocument/congrats1.png',
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 100,
//                           width: 100,
//                           child: Image(
//                             image: AssetImage(
//                               'assets/uploadDocument/congrats2.png',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     const Text(
//                       'Transaction Successful Done',
//                       style: TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Nunito',
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       '₹${widget.amount}',
//                       style: TextStyle(
//                         fontSize: 23,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Nunito',
//                         color: MyColors.blue,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       height: 50,
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: MyColors.blue,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.picture_as_pdf,
//                                 color: MyColors.blue,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               const Text(
//                                 'Invoice',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Nunito',
//                                   color: Color.fromRGBO(0, 0, 0, 1),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Icon(Icons.download),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               //------------------------------------button-------------------------------//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColors.blue,
//                     disabledBackgroundColor: MyColors.blue,
//                     minimumSize: const Size(312, 40),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? null
//                       : () async {
//                           setState(() {
//                             isLoading = true;
//                           });
//                           Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BottomNav(
//                                   currentIndex: 1,
//                                 ),
//                               ),
//                               (route) => false);

//                           setState(() {
//                             isLoading = true;
//                           });
//                         },
//                   child: isLoading
//                       ? const Align(
//                           alignment: Alignment.center,
//                           child: SpinKitThreeBounce(
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         )
//                       : const Text(
//                           'Continue',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: 'Nunito',
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool isLoading = false;
// }

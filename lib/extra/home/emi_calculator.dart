// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../utils/constants.dart';

// class EmiCalculator extends StatefulWidget {
//   const EmiCalculator({super.key});

//   @override
//   State<EmiCalculator> createState() => _EmiCalculatorState();
// }

// class _EmiCalculatorState extends State<EmiCalculator> {
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _tenureController = TextEditingController();
//   final TextEditingController _rateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'EMI Calculator',
//           style: TextStyle(
//             fontFamily: 'Nunito',
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//             fontSize: 16.sp,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: EdgeInsets.only(left: 15, top: 12, bottom: 12),
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               size: 20,
//               Icons.arrow_back_sharp,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         height: size.height,
//         width: size.width,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             //------------------------------------------text1-----------------------------------//
//             Text(
//               'Estimate Your Monthly Payments',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Nunito',
//                 color: Colors.black,
//                 fontSize: 22,
//               ),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: 30),
//             //-----------------------------------------text2--------------------------------------//
//             Text(
//               'Loan Type',
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Nunito',
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             //---------------------------------------loantype boxes---------------------------------//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 70,
//                   width: 75,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                           color: Color.fromRGBO(77, 77, 77, 1), width: 0.7)),
//                   child: Column(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/home/h3.png'),
//                         height: 44,
//                         width: 39,
//                         fit: BoxFit.contain,
//                       ),
//                       Text(
//                         'Home',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                           color: Colors.black,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 70,
//                   width: 75,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                           color: Color.fromRGBO(77, 77, 77, 1), width: 0.7)),
//                   child: Column(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/home/h1.png'),
//                         height: 44,
//                         width: 39,
//                         fit: BoxFit.contain,
//                       ),
//                       Text(
//                         'Personal',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                           color: Colors.black,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 70,
//                   width: 75,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                           color: Color.fromRGBO(77, 77, 77, 1), width: 0.7)),
//                   child: Column(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/home/h2.png'),
//                         height: 44,
//                         width: 39,
//                         fit: BoxFit.contain,
//                       ),
//                       Text(
//                         'Car',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                           color: Colors.black,
//                           fontSize: 13,
//                         ),
//                         textAlign: TextAlign.center,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             //----------------------------------textfield 1-----------------------------//
//             Text(
//               'Home Loan Amount',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Nunito',
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             // Add your button toggles for loan type here
//             Padding(
//               padding: const EdgeInsets.only(right: 0, left: 0),
//               child: TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: '₹1,50,000',
//                   hintStyle: TextStyle(
//                     color: Color.fromRGBO(130, 130, 130, 1),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Nunito',
//                   ),
//                   contentPadding: EdgeInsets.only(
//                     top: 0,
//                     left: 10,
//                     right: 10,
//                     bottom: 0,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: BorderSide(
//                       color: Color.fromRGBO(142, 142, 142, 1),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: BorderSide(
//                       color: MyColors.blue,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 textAlign: TextAlign.start,
//                 controller: _amountController,
//                 cursorColor: MyColors.blue,
//               ),
//             ),

//             SizedBox(height: 30),
//             //-----------------------------textfield 2----------------------------//
//             Text(
//               'Loan Tenure',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Nunito',
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//               textAlign: TextAlign.start,
//             ),

//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 hintText: '10',
//                 hintStyle: TextStyle(
//                   color: Color.fromRGBO(130, 130, 130, 1),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Nunito',
//                 ),
//                 contentPadding: EdgeInsets.only(
//                   top: 0,
//                   left: 10,
//                   right: 10,
//                   bottom: 0,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   gapPadding: 0,
//                   borderSide: BorderSide(
//                     color: Color.fromRGBO(142, 142, 142, 1),
//                     width: 1,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   gapPadding: 0,
//                   borderSide: BorderSide(
//                     color: MyColors.blue,
//                     width: 1,
//                   ),
//                 ),
//               ),
//               textAlign: TextAlign.start,
//               controller: _tenureController,
//               cursorColor: MyColors.blue,
//             ),

//             SizedBox(
//               height: 30,
//             ),
//             //-----------------------------------textfield 3---------------------------------//
//             Text(
//               'Interest Rate',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Nunito',
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//               textAlign: TextAlign.start,
//             ),
//             // Add your button toggles for loan type here
//             Padding(
//               padding: const EdgeInsets.only(right: 00, left: 00),
//               child: TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: '9.5',
//                   hintStyle: TextStyle(
//                     color: Color.fromRGBO(130, 130, 130, 1),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Nunito',
//                   ),
//                   contentPadding: EdgeInsets.only(
//                     top: 0,
//                     left: 10,
//                     right: 10,
//                     bottom: 0,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: BorderSide(
//                       color: Color.fromRGBO(142, 142, 142, 1),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: BorderSide(
//                       color: MyColors.blue,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 textAlign: TextAlign.start,
//                 controller: _rateController,
//                 cursorColor: MyColors.blue,
//               ),
//             ),

//             SizedBox(height: 100),
//             //-------------------------------- button -------------------------------//
//             Padding(
//               padding: const EdgeInsets.only(
//                   right: 40, left: 40, top: 10, bottom: 10),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.blue,
//                   minimumSize: Size(double.infinity, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: isLoading ? null : () async {},
//                 child: isLoading
//                     ? const Align(
//                         alignment: Alignment.center,
//                         child: SpinKitThreeBounce(
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       )
//                     : Text(
//                         'Calculate EMI',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/Home%20loan%20details/property_detail.dart';

// import '../../../../utils/constants.dart';

// class LoanDetails extends StatefulWidget {
//   const LoanDetails({super.key});

//   @override
//   State<LoanDetails> createState() => _LoanDetailsState();
// }

// class _LoanDetailsState extends State<LoanDetails> {
//   final TextEditingController _oneController = TextEditingController();
//   final TextEditingController _twoController = TextEditingController();
//   final TextEditingController _threeController = TextEditingController();
//   final TextEditingController _fourController = TextEditingController();
//   final TextEditingController _fiveController = TextEditingController();
//   final TextEditingController _sixController = TextEditingController();
//   final TextEditingController _sevenController = TextEditingController();
//   final TextEditingController _eightController = TextEditingController();
//   final TextEditingController _nineController = TextEditingController();
//   final TextEditingController _tenController = TextEditingController();
//   final TextEditingController _elevenController = TextEditingController();
//   final TextEditingController _tweleController = TextEditingController();
//   final TextEditingController _thirteenController = TextEditingController();
//   final TextEditingController _forteenController = TextEditingController();

//   String? productApplied;

//   List<String> products = [
//     'Home Loan',
//     'Mortagage Loan',
//     'Lease Rental discount',
//     'Commercial Property  Purchase',
//     'NRI home loan',
//     'Commercial property BT topup',
//     'Home loan Bt top up',
//     'Mortagage loan Bt topup '
//   ];

//   void _showDetailsDialogBox(BuildContext context, String text1, String text2) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Closes the dialog
//                       },
//                     ),
//                   ],
//                 ),
//                 Text(
//                   text1,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color.fromRGBO(78, 78, 78, 1),
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                   ),
//                 ),
//                 Text(
//                   text2,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: Color.fromRGBO(78, 78, 78, 1),
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                   ),
//                 ),
//                 // ... Add more information as needed
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _oneController.dispose();
//     _twoController.dispose();
//     _threeController.dispose();
//     _fourController.dispose();
//     _fiveController.dispose();
//     _sixController.dispose();
//     _sevenController.dispose();
//     _eightController.dispose();
//     _nineController.dispose();
//     _tenController.dispose();
//     _elevenController.dispose();
//     _tweleController.dispose();
//     _thirteenController.dispose();
//     _forteenController.dispose();
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
//               'Loan Details',
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
//           width: size.width,
//           height: size.height,
//           color: Colors.white,
//           padding: const EdgeInsets.only(left: 40, right: 40),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 //---------------------------------Products Apply-------------------------------//

//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Product Apply',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromRGBO(78, 78, 78, 1),
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                         ),
//                       ),
//                       Icon(
//                         Icons.star,
//                         size: 7,
//                         color: Color.fromRGBO(255, 0, 0, 1),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 DropdownButtonFormField(
//                   value: productApplied,
//                   icon: const Icon(
//                     Icons.keyboard_arrow_down,
//                     color: Color.fromRGBO(90, 90, 90, 1),
//                     size: 25,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       productApplied = value!;
//                     });
//                   },
//                   items: products.map((String type) {
//                     return DropdownMenuItem<String>(
//                       value: type,
//                       child: Text(type,
//                           style: const TextStyle(fontWeight: FontWeight.w400)),
//                     );
//                   }).toList(),
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 15, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Select one',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //---------1---------------------------------BT Bank From-------------------------------//

//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'BT Bank From',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromRGBO(78, 78, 78, 1),
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _showDetailsDialogBox(
//                             context,
//                             'BT stands for Balance Transfer.',
//                             'It is a process where you can transfer the outstanding balance of your existing loan from one bank to another bank. This is usually done to take advantage of lower interest rates or better loan terms offered by the other bank.',
//                           );
//                         },
//                         child: Icon(
//                           Icons.info,
//                           color: MyColors.blue,
//                           size: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter BT Bank From',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _oneController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------2---------------------------------Required Top up amount-------------------------------//
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Required Top up amount',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromRGBO(78, 78, 78, 1),
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _showDetailsDialogBox(
//                             context,
//                             'Required Top-Up Amount.',
//                             'A top-up loan on balance transfer is an additional loan amount that you can avail on transferring your existing home loan from one bank to another. This top-up amount can be used for a variety of personal or business needs.',
//                           );
//                         },
//                         child: Icon(
//                           Icons.info,
//                           color: MyColors.blue,
//                           size: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Required Top up amount',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _twoController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------3---------------------------------Loan Amount-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Loan amount',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Loan amount',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _threeController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //----------4---------------------------------Login Bank/NBFC name-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Login Bank/NBFC name',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Login Bank/NBFC name',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fourController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //----------5---------------------------------Login DSA code-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Login DSA code',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Login DSA code',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fiveController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //------------6---------------------------------Bank/ Nbfc Sales manger name-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Bank/ Nbfc Sales manger name',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Bank/ Nbfc Sales manger name',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _sixController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //----------7---------------------------------Bank/ Nbfc Sales manger mobile number-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Bank/ Nbfc Sales manger mobile number',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Bank/ Nbfc Sales manger mobile number',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _sevenController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------8---------------------------------Bank /nbfc sales manger Email Id-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Bank /nbfc sales manger Email Id',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Bank /nbfc sales manger Email Id',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _eightController,
//                   cursorColor: MyColors.blue,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //-----------9---------------------------------Login Branch Name-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Login Branch Name',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Login Branch Name',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _nineController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //-----------10---------------------------------Login city-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Login city',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Login city',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _tenController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //-----------11---------------------------------BANK NBFC ASM/ RSM name-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'BANK NBFC ASM/ RSM name',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter BANK NBFC ASM/ RSM name',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _elevenController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //-----------12---------------------------------BANK NBFC ASM /RSM mobile number-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'BANK NBFC ASM /RSM mobile number',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter BANK NBFC ASM /RSM mobile number',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _tweleController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //------------13---------------------------------BANK NBFC ASM/RSM E mail ID-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'BANK NBFC ASM/RSM E mail ID',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter BANK NBFC ASM/RSM E mail ID',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _thirteenController,
//                   cursorColor: MyColors.blue,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //------------14---------------------------------Login state-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Login state',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(78, 78, 78, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 20, bottom: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Color.fromRGBO(142, 142, 142, 1),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: MyColors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     hintText: 'Enter Login state',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fourController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),

//                 //------------------------------------------button-----------------------------------------//
//                 const SizedBox(
//                   height: 70,
//                 ),

//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColors.blue,
//                     disabledBackgroundColor: MyColors.blue,
//                     minimumSize: const Size(double.infinity, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? null
//                       : () async {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const PropertyDetail(),
//                             ),
//                           );
//                           // }
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
//                           'Proceed',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'Nunito',
//                           ),
//                         ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   bool isLoading = false;
// }

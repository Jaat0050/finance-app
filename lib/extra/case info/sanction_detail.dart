// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/my_case/case%20info/disbursment_details.dart';

// import '../../../../utils/constants.dart';

// class SanctionDetails extends StatefulWidget {
//   const SanctionDetails({super.key});

//   @override
//   State<SanctionDetails> createState() => _SanctionDetailsState();
// }

// class _SanctionDetailsState extends State<SanctionDetails> {
//   final TextEditingController _sanctionDateController = TextEditingController();
//   final TextEditingController _bankSanctionController = TextEditingController();
//   final TextEditingController _amountSanctionController =
//       TextEditingController();
//   final TextEditingController _ROISanctionController = TextEditingController();

//   File? _sanctionDoc;

//   _getFromGallery() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       setState(() {
//         _sanctionDoc = file;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _ROISanctionController.dispose();
//     _amountSanctionController.dispose();
//     _bankSanctionController.dispose();
//     _sanctionDateController.dispose();
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
//         centerTitle: true,
//         title: const Row(
//           children: [
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Sanction Details',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color.fromRGBO(0, 0, 0, 1),
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Nunito',
//               ),
//             ),
//           ],
//         ),
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
//                   offset: const Offset(0, 3),
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
//           padding: const EdgeInsets.only(left: 40, right: 40),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 //-----------------------------------------sanction date-----------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Sanction Date',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   onTap: () async {
//                     showDatePicker(
//                       context: context,
//                       initialDate: DateTime(2023),
//                       firstDate: DateTime(1901),
//                       lastDate: DateTime(2023),
//                       builder: (context, child) {
//                         return Theme(
//                           data: Theme.of(context).copyWith(
//                             colorScheme: ColorScheme.light(
//                               primary: MyColors.blue,
//                             ),
//                             textButtonTheme: TextButtonThemeData(
//                                 style: TextButton.styleFrom(
//                                     foregroundColor: Colors.red)),
//                           ),
//                           child: child!,
//                         );
//                       },
//                     ).then((value) {
//                       if (value != null) {
//                         final DateFormat outputFormat =
//                             DateFormat('dd/MM/yyyy');
//                         setState(() {
//                           _sanctionDateController.text =
//                               outputFormat.format(value).toString();
//                         });
//                       }
//                     });
//                   },
//                   decoration: InputDecoration(
//                     suffixIcon: Icon(
//                       Icons.calendar_month_outlined,
//                       color: MyColors.blue,
//                     ),
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
//                     hintText: 'dd/mm/yyyy',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _sanctionDateController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------------sanction Bank---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Sanction Bank',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color.fromRGBO(54, 54, 54, 1),
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
//                     hintText: 'Enter sanction bank',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _bankSanctionController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------------sanction Amount---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Sanction Amount',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color.fromRGBO(54, 54, 54, 1),
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
//                     hintText: 'Enter sanction amount',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _amountSanctionController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------------sanction ROI---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Sanction ROI',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color.fromRGBO(54, 54, 54, 1),
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
//                     hintText: 'Enter sanction ROI',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _ROISanctionController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------------Upload Sanction copy---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Upload Sanction copy',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),

//                 GestureDetector(
//                   onTap: () {
//                     _getFromGallery();
//                   },
//                   child:
//                       //  _sanctionDoc == null
//                       //     ?
//                       Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Image(
//                         image: AssetImage('assets/uploadFiles/upload2.png'),
//                         height: 182,
//                         width: 364,
//                       ),
//                       if (_sanctionDoc != null)
//                         Container(
//                           height: 100,
//                           width: 100,
//                           color: Colors.white,
//                           child: Icon(
//                             Icons.picture_as_pdf_rounded,
//                             color: MyColors.blue,
//                             size: 100,
//                           ),
//                         ),
//                     ],
//                   ),

//                   // : Center(
//                   //     child: Icon(
//                   //       Icons.picture_as_pdf_rounded,
//                   //       color: MyColors.blue,
//                   //       size: 172,
//                   //     ),
//                   //   ),
//                 ),

//                 SizedBox(
//                   height: size.height * 0.1,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColors.blue,
//                     disabledBackgroundColor: MyColors.blue,
//                     minimumSize: const Size(double.infinity, 40),
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
//                               builder: (context) => const DisbursmentDetail(),
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
//                           'Submit',
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

// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/bottomnav.dart';

// import '../../../../utils/constants.dart';

// class DisbursmentDetail extends StatefulWidget {
//   const DisbursmentDetail({super.key});

//   @override
//   State<DisbursmentDetail> createState() => _DisbursmentDetailState();
// }

// class _DisbursmentDetailState extends State<DisbursmentDetail> {
//   final TextEditingController _disbursmentDateController =
//       TextEditingController();
//   final TextEditingController _partialdisbursmentDateController =
//       TextEditingController();
//   final TextEditingController _fulldisbursmentDateController =
//       TextEditingController();
//   final TextEditingController _amountDisbursmentController =
//       TextEditingController();
//   final TextEditingController _fullAmountDisbursmentController =
//       TextEditingController();
//   final TextEditingController _loanAggrementController =
//       TextEditingController();

//   File? _partialDisbursmentDoc;
//   File? _fullDistursmentDoc;
//   File? _ebstCopy;
//   File? _noticeCopy;

//   bool isLoading = false;

//   _getFromGallery(String documentType) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       setState(() {
//         switch (documentType) {
//           case 'partialDisbursment':
//             _partialDisbursmentDoc = file;
//             break;
//           case 'fullDistursment':
//             _fullDistursmentDoc = file;
//             break;
//           case 'ebstCopy':
//             _ebstCopy = file;
//             break;
//           case 'noticeCopy':
//             _noticeCopy = file;
//             break;
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _disbursmentDateController.dispose();
//     _partialdisbursmentDateController.dispose();
//     _fulldisbursmentDateController.dispose();
//     _amountDisbursmentController.dispose();
//     _fullAmountDisbursmentController.dispose();
//     _loanAggrementController.dispose();
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
//               'Disbursment Details',
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
//                 //-----------------------------------------disbursment date-----------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Disbursment Date',
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
//                           _disbursmentDateController.text =
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
//                   controller: _disbursmentDateController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //--------------------------------------------first container------------------------------//

//                 Container(
//                   height: 30,
//                   width: 340,
//                   color: const Color.fromRGBO(251, 199, 10, 1),
//                   child: const Center(
//                     child: Text(
//                       'Partial Disbursment',
//                       style: TextStyle(
//                         fontFamily: 'Nunito',
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //-----------------------------------------Partial disbursment date-----------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Partial Disbursment Date',
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
//                           _partialdisbursmentDateController.text =
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
//                   controller: _partialdisbursmentDateController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //---------------------------------------Partial Disbursment Amount---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Partial Disbursment Amount',
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
//                     hintText: 'Enter partial disbursment amount',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _amountDisbursmentController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //---------------------------------------upload partial disbursment copy---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Upload Partial Disbursment proof',
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
//                     _getFromGallery('partialDisbursment');
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Image(
//                         image: AssetImage('assets/uploadFiles/upload2.png'),
//                         height: 182,
//                         width: 364,
//                       ),
//                       if (_partialDisbursmentDoc != null)
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
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //--------------------------------------------Second container------------------------------//

//                 Container(
//                   height: 30,
//                   width: 340,
//                   color: const Color.fromRGBO(251, 199, 10, 1),
//                   child: const Center(
//                     child: Text(
//                       'Full Disbursment',
//                       style: TextStyle(
//                         fontFamily: 'Nunito',
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //-----------------------------------------Full disbursment date-----------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Partial Disbursment Date',
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
//                           _fulldisbursmentDateController.text =
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
//                   controller: _fulldisbursmentDateController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //---------------------------------------Full Disbursment Amount---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Full Disbursment Amount',
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
//                     hintText: 'Enter Full disbursment amount',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fullAmountDisbursmentController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //---------------------------------------upload Full disbursment copy---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Upload Full Disbursment proof',
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
//                     _getFromGallery('fullDistursment');
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Image(
//                         image: AssetImage('assets/uploadFiles/upload2.png'),
//                         height: 182,
//                         width: 364,
//                       ),
//                       if (_fullDistursmentDoc != null)
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
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //------------------------------------loan aggrement----------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Loan agreement (Los ID number)',
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
//                     hintText: 'Enter Los ID number',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _loanAggrementController,
//                   cursorColor: MyColors.blue,
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //----------------------------------------upload EBST copy------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Upload Franking EBSTR copy',
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
//                     _getFromGallery('ebstCopy');
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Image(
//                         image: AssetImage('assets/uploadFiles/upload2.png'),
//                         height: 182,
//                         width: 364,
//                       ),
//                       if (_ebstCopy != null)
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
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //--------------------------------upload Notice of Internation copy---------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Upload Notice of Intemation copy',
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
//                     _getFromGallery('noticeCopy');
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Image(
//                         image: AssetImage('assets/uploadFiles/upload2.png'),
//                         height: 182,
//                         width: 364,
//                       ),
//                       if (_noticeCopy != null)
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
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),

//                 //--------------------------------------------button--------------------------------------//
//                 SizedBox(
//                   height: size.height * 0.08,
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
//                               builder: (context) => BottomNav(currentIndex: 1),
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
// }

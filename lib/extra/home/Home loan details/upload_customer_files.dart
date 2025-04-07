// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/Home%20loan%20details/loan_details.dart';

// import '../../../../utils/constants.dart';

// class UploadCustomerFiles extends StatefulWidget {
//   const UploadCustomerFiles({super.key});

//   @override
//   State<UploadCustomerFiles> createState() => _UploadCustomerFilesState();
// }

// class _UploadCustomerFilesState extends State<UploadCustomerFiles> {
//   File? _aadharFront;
//   File? _aadharBack;
//   File? _panFront;
//   File? _panBack;
//   File? _gstCertificate;

//   _getFromGallery(String documentType) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       setState(() {
//         switch (documentType) {
//           case '_aadharFront':
//             _aadharFront = file;
//             break;
//           case '_aadharBack':
//             _aadharBack = file;
//             break;
//           case '_panFront':
//             _panFront = file;
//             break;
//           case '_panBack':
//             _panBack = file;
//             break;
//           case '_gstCertificate':
//             _gstCertificate = file;
//             break;
//         }
//       });
//     }
//   }

//   Widget _buildUploadSlot(
//     String documentType,
//     String docText,
//     File? file, {
//     bool isLarge = false,
//   }) {
//     return GestureDetector(
//       onTap: () => _getFromGallery(documentType),
//       child:
//           // file == null
//           //     ?
//           Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 5),
//             child: Text(
//               docText,
//               style: const TextStyle(
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w500,
//                 fontSize: 10,
//                 color: Color.fromRGBO(54, 54, 54, 1),
//               ),
//             ),
//           ),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Image(
//                 image: AssetImage(
//                     'assets/uploadFiles/upload${isLarge ? '2' : '1'}.png'),
//                 height: isLarge ? 182 : 130,
//                 width: isLarge ? 364 : 130,
//               ),
//               if (file != null)
//                 Container(
//                   height: 100,
//                   width: 100,
//                   color: Colors.white,
//                   child: Icon(
//                     Icons.picture_as_pdf_rounded,
//                     color: MyColors.blue,
//                     size: isLarge ? 100 : 70,
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       // : Column(
//       //     crossAxisAlignment: CrossAxisAlignment.stretch,
//       //     children: [
//       //       Row(
//       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //         children: [
//       //           Padding(
//       //             padding: const EdgeInsets.only(left: 5),
//       //             child: Text(
//       //               docText,
//       //               style: TextStyle(
//       //                 fontFamily: 'Nunito',
//       //                 fontWeight: FontWeight.w500,
//       //                 fontSize: 10,
//       //                 color: Color.fromRGBO(54, 54, 54, 1),
//       //               ),
//       //             ),
//       //           ),
//       //           SizedBox(),
//       //         ],
//       //       ),
//       //       Icon(
//       //         Icons.picture_as_pdf_rounded,
//       //         color: MyColors.blue,
//       //         size: isLarge ? 172 : 120,
//       //       ),
//       //     ],
//       //   ),
//     );
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
//         title: const Text(
//           'Upload Files',
//           style: TextStyle(
//             fontSize: 15,
//             color: Color.fromRGBO(0, 0, 0, 1),
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Nunito',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         height: size.height,
//         width: size.width,
//         color: Colors.white,
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildUploadSlot(
//                         '_aadharFront', 'Upload Aadhar Front', _aadharFront),
//                     _buildUploadSlot(
//                         '_aadharBack', 'Upload Aadhar Back', _aadharBack),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildUploadSlot(
//                         '_panFront', 'Upload PAN Front', _panFront),
//                     _buildUploadSlot('_panBack', 'Upload PAN Back', _panBack),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 _buildUploadSlot('_gstCertificate', 'Upload Gst Certificate',
//                     _gstCertificate,
//                     isLarge: true),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.blue,
//                   minimumSize: const Size(double.infinity, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: isLoading
//                     ? null
//                     : () async {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoanDetails(),
//                           ),
//                         );
//                         // }
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
//                         'Proceed',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
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

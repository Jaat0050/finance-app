// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../../utils/constants.dart';

// class UploadCustomerDoc extends StatefulWidget {
//   const UploadCustomerDoc({super.key});

//   @override
//   State<UploadCustomerDoc> createState() => _UploadCustomerDocState();
// }

// class _UploadCustomerDocState extends State<UploadCustomerDoc> {
//   File? _customerPhoto;
//   File? _addressProff;
//   File? _qualifitation;
//   File? _salarySlip;
//   File? _bankStatement;
//   File? _companyId;
//   File? _visitingId;

//   _getFromGallery(String documentType) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       setState(() {
//         switch (documentType) {
//           case 'picture':
//             _customerPhoto = file;
//             break;
//           case 'address':
//             _addressProff = file;
//             break;
//           case 'marksheet':
//             _qualifitation = file;
//             break;
//           case 'salary':
//             _salarySlip = file;
//             break;
//           case 'bank':
//             _bankStatement = file;
//             break;
//           case 'company':
//             _companyId = file;
//             break;
//           case 'visiting':
//             _visitingId = file;
//             break;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         height: size.height,
//         width: size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               //--------------------------------top container-----------------------------//
//               Container(
//                 height: size.height * 0.12,
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       'assets/home/homerect.png',
//                     ),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             height: 35,
//                             width: 35,
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(Icons.arrow_back_sharp),
//                           ),
//                         ),
//                         Text(
//                           'Upload Documents',
//                           style: TextStyle(
//                             fontFamily: 'Nunito',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(
//                           width: size.width * 0.1,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               //----------------------------------tile container----------------------------//
//               Container(
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 height: size.height * 0.82,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 65),
//                     //-----------------Customer Picture tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Customer Picture',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 'Upload your passport size photo',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('picture');
//                             },
//                             child: Icon(
//                               _customerPhoto != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _customerPhoto != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Address Proof tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Address Proof',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 'Aadhar card/pan card',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('address');
//                             },
//                             child: Icon(
//                               _addressProff != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _addressProff != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Qualification card tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Qualification',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 'Upload your highest qualification marksheet',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('marksheet');
//                             },
//                             child: Icon(
//                               _qualifitation != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _qualifitation != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Salary Slip  card tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Salary Slip',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 '(3 month)',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('salary');
//                             },
//                             child: Icon(
//                               _salarySlip != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _salarySlip != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Bank Statement  card tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Bank Statement',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 'Minimum 6 month',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('bank');
//                             },
//                             child: Icon(
//                               _bankStatement != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _bankStatement != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Company ID card tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Company ID',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 '(optional)',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('company');
//                             },
//                             child: Icon(
//                               _companyId != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _companyId != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                     //-----------------Visiting ID  card tile-----------------------//

//                     Padding(
//                       padding: const EdgeInsets.only(left: 25, right: 25),
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: SharedPreferencesHelper.getAadhaar()
//                             //     ? MyColors.blue
//                             //     : Color.fromRGBO(142, 142, 142, 1),
//                             color: Color.fromRGBO(142, 142, 142, 1),
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ListTile(
//                           leading: Container(
//                             padding: EdgeInsets.all(8),
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: MyColors.blue,
//                             ),
//                             child: Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/uploadDocument/idcard.png',
//                                 ),
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           title: Center(
//                             child: const Text(
//                               'Visiting ID',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Center(
//                               child: Text(
//                                 '(optional)',
//                                 style: TextStyle(
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               // if (SharedPreferencesHelper.getAadhaar()) {
//                               //   return null;
//                               // } else {
//                               //   _getFromGallery('aadhaar');
//                               // }

//                               _getFromGallery('visiting');
//                             },
//                             child: Icon(
//                               _visitingId != null
//                                   ? Icons.check_sharp
//                                   : Icons.cloud_upload,
//                               size: 25,
//                               color: _visitingId != null
//                                   ? Color.fromRGBO(55, 203, 31, 1)
//                                   : Color.fromRGBO(142, 142, 142, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 30,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.09,
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColors.blue,
//                     disabledBackgroundColor: MyColors.blue,
//                     minimumSize: Size(double.infinity, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: isLoading ? null : () async {},
//                   child: isLoading
//                       ? const Align(
//                           alignment: Alignment.center,
//                           child: SpinKitThreeBounce(
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         )
//                       : Text(
//                           'Submit',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Nunito',
//                           ),
//                         ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   bool isLoading = false;
// }

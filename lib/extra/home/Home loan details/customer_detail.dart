// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/Home%20loan%20details/upload_customer_files.dart';

// import '../../../../utils/constants.dart';

// class CustomerDetails extends StatefulWidget {
//   const CustomerDetails({Key? key}) : super(key: key);

//   @override
//   State<CustomerDetails> createState() => _CustomerDetailsState();
// }

// class _CustomerDetailsState extends State<CustomerDetails> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _aadharController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();

//   bool isLoading = false;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _otpController.dispose();
//     _emailController.dispose();
//     _dobController.dispose();
//     _aadharController.dispose();
//     _panController.dispose();
//     super.dispose();
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
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Customer Information',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2,
//                 ),
//                 Text(
//                   'Please fill in the following information',
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: Color.fromRGBO(103, 103, 103, 1),
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           color: MyColors.dullWhite,
//           padding: const EdgeInsets.only(right: 30, left: 30),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 //---------------------------------full name-------------------------------//
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Full name',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: const Color.fromRGBO(54, 54, 54, 1),
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Nunito',
//                         ),
//                       ),
//                       const Icon(
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
//                     hintText: 'Please enter full name',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fullNameController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Mobile Number-------------------------------//
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Phone Number',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: const Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 7,
//                             color: Color.fromRGBO(255, 0, 0, 1),
//                           )
//                         ],
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
//                     hintText: 'Please enter mobile number',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _phoneController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(10),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------OTP name-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'OTP',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color.fromRGBO(54, 54, 54, 1),
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
//                     hintText: 'Please enter OTP',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _otpController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(4),
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Email address-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Email Address',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color.fromRGBO(54, 54, 54, 1),
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
//                     hintText: 'Please enter email address',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _emailController,
//                   cursorColor: MyColors.blue,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------DOB-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Date of Birth (DOB)',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color.fromRGBO(54, 54, 54, 1),
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
//                           _dobController.text =
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
//                   controller: _dobController,
//                   cursorColor: MyColors.blue,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Aadhar number-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Aadhar Number ',
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
//                     hintText: 'Please enter aadhar no.',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _aadharController,
//                   cursorColor: MyColors.blue,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Pan Number-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Pan No.',
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
//                     hintText: 'Please enter pan no.',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _panController,
//                   cursorColor: MyColors.blue,
//                 ),

//                 //-------------------------------- button -------------------------------//
//                 SizedBox(
//                   height: size.height * 0.09,
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
//                           // if (_fullNameController.text.isEmpty) {
//                           //   Fluttertoast.showToast(
//                           //     msg: "Please Enter Name",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 1,
//                           //     backgroundColor: MyColors.blue,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0,
//                           //   );
//                           // } else if (_phoneController.text.isEmpty) {
//                           //   Fluttertoast.showToast(
//                           //     msg: "Please Enter Phone number",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 1,
//                           //     backgroundColor: MyColors.blue,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0,
//                           //   );
//                           // } else if (_otpController.text.isEmpty) {
//                           //   Fluttertoast.showToast(
//                           //     msg: "Please Enter OTP",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 1,
//                           //     backgroundColor: MyColors.blue,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0,
//                           //   );
//                           // } else if (_emailController.text.isEmpty) {
//                           //   Fluttertoast.showToast(
//                           //     msg: "Please Enter Your Email Address",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 1,
//                           //     backgroundColor: MyColors.blue,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0,
//                           //   );
//                           // } else if (_dobController.text.isEmpty) {
//                           //   Fluttertoast.showToast(
//                           //     msg: "Please select your Date Of Birth",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 1,
//                           //     backgroundColor: MyColors.blue,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0,
//                           //   );
//                           // } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const UploadCustomerFiles(),
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
//                           'Next',
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

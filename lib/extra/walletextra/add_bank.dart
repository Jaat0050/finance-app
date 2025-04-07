// import 'package:flutter/material.dart';

// import '../../utils/constants.dart';

// class AddBankAccount extends StatefulWidget {
//   const AddBankAccount({super.key});

//   @override
//   State<AddBankAccount> createState() => _AddBankAccountState();
// }

// class _AddBankAccountState extends State<AddBankAccount> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: MyColors.dullWhite,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           scrolledUnderElevation: 0,
//           title: Row(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: MyColors.black,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               const Text(
//                 'Add Bank Account',
//                 style: TextStyle(
//                   fontFamily: 'Rubik',
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           color: MyColors.dullWhite,
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             SizedBox(
//               height: size.height * 0.02,
//             ),
//             Row(children: [
//               Image(
//                   image: const AssetImage('assets/icons/hdfc.png'),
//                   width: size.width * 0.1),
//               SizedBox(
//                 width: size.width * 0.05,
//               ),
//               const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Selected Bank",
//                       style: TextStyle(
//                         fontFamily: 'Roboto', // Font family
//                         fontWeight: FontWeight.w500, // Font weight
//                         fontSize: 13.0, // Font size
//                         height:
//                             1.17, // Line height in Flutter is represented as a multiplier (15.23 / 13)
//                       ),
//                     ),
//                     Text(
//                       "HDFC Bank",
//                       style: TextStyle(
//                         fontFamily: 'Roboto', // Font family
//                         fontWeight: FontWeight.w500, // Font weight
//                         fontSize: 13.0, // Font size
//                         height:
//                             1.17, // Line height in Flutter is represented as a multiplier (15.23 / 13)
//                       ),
//                     ),
//                   ]),
//               const Spacer(),
//               const Image(image: AssetImage('assets/icons/pen.png'), width: 20),
//             ]),
//             SizedBox(
//               height: size.height * 0.02,
//             ),
//             Container(
//               width: size.width * 0.9,
//               height: 1,
//               color: MyColors.blue,
//             ),
//             SizedBox(
//               height: size.height * 0.04,
//             ),
//             //-----------------Account Number-----------------
//             const Text(
//               ' Account Number (Customer ID)',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.only(
//                     top: 5, left: 10, right: 20, bottom: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: const BorderSide(
//                     color: Color.fromRGBO(142, 142, 142, 1),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(
//                     color: MyColors.blue,
//                     width: 1,
//                   ),
//                 ),
//                 hintText: 'Enter your Account Number',
//                 hintStyle: const TextStyle(
//                   color: Color.fromRGBO(224, 224, 224, 1),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Nunito',
//                 ),
//               ),
//               textAlign: TextAlign.start,
//               // controller: _pincodeController,
//               cursorColor: MyColors.blue,
//               // inputFormatters: [
//               //   LengthLimitingTextInputFormatter(6),
//               //   FilteringTextInputFormatter.digitsOnly,
//               // ],
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(
//               height: 20,
//             ),

//             //-----------------IFSC Code-----------------
//             const Text(
//               ' IFSC Code',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.only(
//                     top: 5, left: 10, right: 20, bottom: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: const BorderSide(
//                     color: Color.fromRGBO(142, 142, 142, 1),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(
//                     color: MyColors.blue,
//                     width: 1,
//                   ),
//                 ),
//                 hintText: ' Enter IFSC Code',
//                 hintStyle: const TextStyle(
//                   color: Color.fromRGBO(224, 224, 224, 1),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Nunito',
//                 ),
//               ),
//               textAlign: TextAlign.start,
//               // controller: _pincodeController,
//               cursorColor: MyColors.blue,
//               // inputFormatters: [
//               //   LengthLimitingTextInputFormatter(6),
//               //   FilteringTextInputFormatter.digitsOnly,
//               // ],
//               keyboardType: TextInputType.number,
//             ),
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.veryLightBlue,
//                   minimumSize: const Size(double.infinity, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => AddUPI(),
//                   //   ),
//                   // );
//                 },
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(
//                     color: MyColors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ]),
//         ));
//   }
// }

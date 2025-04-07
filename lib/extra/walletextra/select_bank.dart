// import 'package:flutter/material.dart';

// import '../../utils/constants.dart';
// import 'add_bank.dart';

// class SelectBankAccount extends StatefulWidget {
//   const SelectBankAccount({super.key});

//   @override
//   State<SelectBankAccount> createState() => _SelectBankAccountState();
// }

// class _SelectBankAccountState extends State<SelectBankAccount> {
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
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return const AddBankAccount();
//                   }));
//                 },
//                 child: const Text(
//                   ' Select Bank',
//                   style: TextStyle(
//                     fontFamily: 'Rubik',
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//             width: size.width,
//             color: MyColors.dullWhite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: size.height * 0.02),
//                 //-----------------------------------search-------------------------------//
//                 Container(
//                   width: size.width * 0.9,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: MyColors.greyShadow, width: 1),
//                   ),
//                   child: const Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(Icons.search,
//                             color: Color.fromRGBO(0, 0, 0, 0.6)),
//                       ),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Search bank account, UPI ID',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 //-----------------------------------popular banks-------------------------------//

//                 //-----------------------------------all banks-------------------------------//
//               ],
//             )));
//   }
// }

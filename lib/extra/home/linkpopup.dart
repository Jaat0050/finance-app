// import 'package:flutter/material.dart';

// class LinkPopup extends StatefulWidget {
//   const LinkPopup({super.key});

//   @override
//   State<LinkPopup> createState() => _LinkPopupState();
// }

// class _LinkPopupState extends State<LinkPopup> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Dialog(
//       child: Container(
//         padding: const EdgeInsets.all(15),
//         height: size.height * 0.3,
//         width: size.width * 0.32,
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(251, 243, 223, 1),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     child: Icon(Icons.close),
//                   ),
//                 )
//               ],
//             ),
//             Text(
//               'Share this Link to your Customer',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Nunito',
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '---------',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 Text(
//                   'OR',
//                 ),
//                 Text(
//                   '---------',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Copy Link',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Nunito',
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
//               height: 30,
//               width: 200,
//               decoration: BoxDecoration(
//                   color: Color.fromRGBO(217, 217, 217, 1),
//                   borderRadius: BorderRadius.circular(5)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('link'),
//                   Icon(
//                     Icons.copy_rounded,
//                     size: 15,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

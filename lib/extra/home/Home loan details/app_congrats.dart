// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mitra_fintech_agent/app/bottomnav.dart';

// import '../../../../utils/constants.dart';

// class ApplicationCongrats extends StatefulWidget {
//   const ApplicationCongrats({super.key});

//   @override
//   State<ApplicationCongrats> createState() => _ApplicationCongratsState();
// }

// class _ApplicationCongratsState extends State<ApplicationCongrats> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Container(
//         height: size.height,
//         width: size.width,
//         color: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 40,
//             ),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 200,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     // image: DecorationImage(
//                     //   image: AssetImage(
//                     //     'assets/uploadDocument/congrats1.png',
//                     //   ),
//                     // ),
//                     color: MyColors.blue,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: Image(
//                     image: AssetImage(
//                       'assets/uploadDocument/congrats2.png',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             const Text(
//               'Congratulations',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Nunito',
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               'Your application Accepted',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Nunito',
//                 color: Color.fromRGBO(101, 101, 100, 1),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SizedBox(
//               height: 80,
//               width: 300,
//               child: Text(
//                 "Congratulations! Your loan application has been approved.\nThank you for choosing our services.",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Nunito',
//                   color: Color.fromRGBO(101, 101, 100, 1),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.2,
//             ),

//             //--------------------------------button---------------------------------------//
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.blue,
//                   minimumSize: const Size(312, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: isLoading
//                     ? null
//                     : () async {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BottomNav(
//                                 currentIndex: 0,
//                               ),
//                             ),
//                             (route) => false);

//                         setState(() {
//                           isLoading = true;
//                         });
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
//                         'Back to Home',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
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

// import 'package:flutter/material.dart';
// import 'package:mitra_fintech_agent/app/bottomnav.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/knowledge_center/video_screen.dart';

// class KnowledgeCentre extends StatefulWidget {
//   const KnowledgeCentre({super.key});

//   @override
//   State<KnowledgeCentre> createState() => _KnowledgeCentreState();
// }

// class _KnowledgeCentreState extends State<KnowledgeCentre> {
//   int? selectedIndex;

//   void handleTileTap(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: const Text(
//           'Knowledge Centre',
//           style: TextStyle(
//             fontFamily: 'Nunito',
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             fontSize: 23,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BottomNav(currentIndex: 0),
//             ),
//           ),
//           child: Container(
//             height: 30,
//             width: 30,
//             margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
//             child: const Icon(Icons.arrow_back, color: Colors.black),
//           ),
//         ),
//       ),
//       body: Container(
//         height: size.height,
//         width: size.width,
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: size.width * 0.82,
//                 child: Text(
//                   'Complete all the playlist to earn ₹100 andrecieve a certificate.',
//                   style: TextStyle(
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               ...serviceItems.asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 ServiceItem item = entry.value;

//                 bool isSelected = idx == selectedIndex;
//                 return Column(
//                   children: [
//                     Container(
//                       width: size.width * 0.85,
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: isSelected ? Colors.black : Colors.grey,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: ListTile(
//                         leading: Container(
//                           height: 40,
//                           width: 40,
//                           child: Center(
//                             child: Image.asset(
//                               item.imageAsset,
//                               fit: BoxFit.scaleDown,
//                             ),
//                           ),
//                         ),
//                         title: Center(
//                           child: Text(
//                             item.title,
//                             style: TextStyle(
//                               fontFamily: 'Nunito',
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                         subtitle: Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Center(
//                             child: Text(
//                               item.subtitle,
//                               style: TextStyle(
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                         ),
//                         trailing: Container(
//                           height: 50,
//                           width: 50,
//                           child: Center(
//                               child: Icon(
//                             Icons.play_arrow,
//                             color: isSelected ? Colors.black : Colors.grey,
//                             size: 40,
//                           )),
//                         ),
//                         onTap: () {
//                           handleTileTap(idx);
//                           item.onTap();
//                         },
//                       ),
//                     ),
//                     // Add a SizedBox for spacing if it's not the last item
//                     if (idx != serviceItems.length - 1) SizedBox(height: 30),
//                   ],
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToVideoScreen(String videoName, String overview) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VideoScreen(
//           videoName: videoName,
//           overView: overview,
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();

//     serviceItems = [
//       ServiceItem(
//         imageAsset: 'assets/home/h1.png',
//         title: 'Personal Loan',
//         subtitle: '02/14 videos',
//         onTap: () {
//           _navigateToVideoScreen('Personal Loan',
//               'Overview for Personal Loan kkkkknnnnnnnnnnnnnnnnnkkkkkkkkkkkkkkkkkdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
//         },
//       ),
//       ServiceItem(
//         imageAsset: 'assets/home/h2.png',
//         title: 'Car Loan',
//         subtitle: '01/20 videos',
//         onTap: () =>
//             _navigateToVideoScreen('Car Loan', 'Overview for Car Loan'),
//       ),
//       ServiceItem(
//         imageAsset: 'assets/home/h3.png',
//         title: 'Home Loan',
//         subtitle: '01/32 videos',
//         onTap: () =>
//             _navigateToVideoScreen('Car Loan', 'Overview for Car Loan'),
//       ),
//       ServiceItem(
//         imageAsset: 'assets/home/h4.png',
//         title: 'Credit Cards',
//         subtitle: '0/9 videos',
//         onTap: () =>
//             _navigateToVideoScreen('Car Loan', 'Overview for Car Loan'),
//       ),
//       // ... add other ServiceItems similarly
//     ];
//   }

//   List<ServiceItem> serviceItems = [];
// }

// class ServiceItem {
//   final String imageAsset;
//   final String title;
//   final String subtitle;
//   final Function onTap;

//   ServiceItem({
//     required this.imageAsset,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });
// }

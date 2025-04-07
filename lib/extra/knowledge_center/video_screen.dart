// import 'package:flutter/material.dart';

// import '../../../utils/constants.dart';

// // ignore: must_be_immutable
// class VideoScreen extends StatefulWidget {
//   String videoName;
//   String overView;
//   VideoScreen({required this.videoName, required this.overView, super.key});

//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen>
//     with SingleTickerProviderStateMixin {
//   double _progress = 0.75;

//   TabController? tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     tabController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           widget.videoName,
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
//           onTap: () {
//             Navigator.pop(context);
//           },
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
//         width: size.width,
//         height: size.height,
//         padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: MyColors.blue,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Download Certificate',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Nunito',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Progress',
//                       style: TextStyle(
//                         fontFamily: 'Nunito',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         SizedBox(
//                           height: 45,
//                           width: 45,
//                           child: CircularProgressIndicator(
//                             value: _progress, // Use the _progress value here
//                             backgroundColor: Colors.grey[300],
//                             color: Colors.amber,
//                             strokeWidth: 8,
//                           ),
//                         ),
//                         Center(
//                           child: Text('${(_progress * 100).toInt()}%'),
//                         ), // Display the percentage
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 5, right: 5),
//               height: 200,
//               width: double.infinity,
//               color: Colors.grey,
//               child: Center(
//                 child: Icon(
//                   Icons.play_arrow_rounded,
//                   size: 100,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             TabBar(
//               controller: tabController,
//               physics: const BouncingScrollPhysics(),
//               labelColor: Colors.black,
//               unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.4),
//               indicatorSize: TabBarIndicatorSize.label,
//               indicatorColor: const Color.fromRGBO(251, 199, 10, 1),
//               indicatorPadding: EdgeInsets.only(bottom: 10),
//               indicatorWeight: 4,
//               tabs: [
//                 Tab(
//                   child: const Text(
//                     'Videos',
//                     style: TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: const Text(
//                     'Information',
//                     style: TextStyle(
//                       fontFamily: 'Nunito',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 200,
//                     color: Colors.blue,
//                   ),
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Overview',
//                             style: TextStyle(
//                               fontFamily: 'Nunito',
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           width: size.width * 0.89,
//                           child: Text(
//                             widget.overView,
//                             maxLines: 6,
//                             style: TextStyle(
//                               fontFamily: 'Nunito',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                               overflow: TextOverflow.fade,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                             'Show More',
//                             style: TextStyle(
//                               fontFamily: 'Nunito',
//                               fontWeight: FontWeight.w500,
//                               color: MyColors.blue,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Highlights',
//                             style: TextStyle(
//                               fontFamily: 'Nunito',
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(0, 0, 0, 1),
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Unsecured Nature',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               '00:00',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Loan Amount and Repayment Period',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               '00:00',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Unsecured Nature',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               '00:00',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Loan Amount and Repayment Period',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               '00:00',
//                               style: TextStyle(
//                                 fontFamily: 'Nunito',
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

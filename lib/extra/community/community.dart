// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/community/dummy_api.dart';
// import 'package:mitra_fintech_agent/app/utils/constants.dart';
// import 'add_post.dart';

// class CommunityPage extends StatefulWidget {
//   const CommunityPage({Key? key}) : super(key: key);

//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   int selectedPostIndex = -1;
//   bool isHeartFilled = false;

//   // void _sharePostData(Post post) {
//   //   String shareText =
//   //       'Check out this post by ${post.agentName}:\n${post.postText}\n\nShared via YourApp';
//   //   Share.share(shareText);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyColors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Text(
//               'Community',
//               style: GoogleFonts.rubik(
//                 textStyle: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               color: MyColors.white,
//               padding: EdgeInsets.only(left: 10, right: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: MyColors.lightGrey,
//                         contentPadding: EdgeInsets.only(
//                           top: 5,
//                           left: 10,
//                           right: 20,
//                           bottom: 15,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(40),
//                           borderSide: BorderSide(
//                             color: Colors
//                                 .transparent, // Set transparent color to remove the border
//                             width: 0, // Set width to 0 to remove the border
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(40),
//                           borderSide: BorderSide(
//                             color: Colors
//                                 .transparent, // Set transparent color to remove the border
//                             width: 0, // Set width to 0 to remove the border
//                           ),
//                         ),
//                         hintText: 'Search Topic',
//                         hintStyle: GoogleFonts.roboto(
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: Color.fromRGBO(117, 117, 117, 1),
//                             fontSize: 15,
//                           ),
//                         ),
//                         suffixIcon: Padding(
//                           padding: EdgeInsets.all(5),
//                           child: CircleAvatar(
//                             backgroundColor: MyColors.blue,
//                             radius: 12.sp,
//                             child: Icon(
//                               Icons.search,
//                               size: 18.sp,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       textAlign: TextAlign.start,
//                       cursorColor: MyColors.blue,
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     width: size.width * 0.02,
//                   ),
//                   InkWell(
//                     // onTap: () {
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(builder: (context) => AddPost()),
//                     //   );
//                     // },
//                     child: Image(
//                       image: AssetImage(
//                         'assets/icons/notification.png',
//                       ),
//                       width: 30.sp, // Width
//                       height: 30.sp,
//                     ),
//                   ),
//                   SizedBox(
//                     width: size.width * 0.02,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddPost()),
//                       );
//                     },
//                     child: Image(
//                       image: AssetImage(
//                         'assets/icons/add_post.png',
//                       ),
//                       width: 30.sp, // Width
//                       height: 30.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: size.height * 0.03),
//             Expanded(
//               child: RefreshIndicator(
//                 color: MyColors.blue,
//                 onRefresh: () async {
//                   await Future.delayed(Duration(seconds: 2));
//                   return Future.value(true);
//                 },
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(children: [
//                     ListView.builder(
//                         itemCount: postsData.length,
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           Post post = postsData[index];
//                           return Container(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(
//                                       left: size.width * 0.02,
//                                       right: size.width * 0.02),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 50.0,
//                                             backgroundColor: Colors.transparent,
//                                             child: ClipOval(
//                                               child: CachedNetworkImage(
//                                                 imageUrl: post.agentProfile,
//                                                 fit: BoxFit.cover,
//                                                 width: size.width * 0.15,
//                                                 height: size.width * 0.15,
//                                                 placeholder: (context, url) =>
//                                                     CircularProgressIndicator(),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Icon(Icons.error),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: size.width * 0.02),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 post.agentName,
//                                                 style: GoogleFonts.roboto(
//                                                   textStyle: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.black,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                                 // style: TextStyle(
//                                                 //     fontFamily: 'Roboto',
//                                                 //     fontWeight: FontWeight.w400,
//                                                 //     fontSize: 14.sp,
//                                                 //     height: 16.41 /
//                                                 //         14.0, // Calculated line height based on specified values
//                                                 //     color: MyColors.black),
//                                               ),
//                                               Text(
//                                                 post.postDate,
//                                                 style: GoogleFonts.roboto(
//                                                   textStyle: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Color.fromRGBO(
//                                                         147, 147, 147, 1),
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: size.height * 0.01),
//                                       Text(post.postText),
//                                       SizedBox(height: size.height * 0.04),
//                                       Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 isHeartFilled = !isHeartFilled;
//                                               });
//                                             },
//                                             child: Image.asset(
//                                               isHeartFilled
//                                                   ? 'assets/icons/community/heart_filled.png'
//                                                   : 'assets/icons/community/heart_empty.png',
//                                               width: 20.0,
//                                               height: 20.0,
//                                             ),
//                                           ),
//                                           Text("100k"),
//                                           SizedBox(width: size.width * 0.05),
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedPostIndex =
//                                                     selectedPostIndex == index
//                                                         ? -1
//                                                         : index;
//                                               });
//                                             },
//                                             child: Image.asset(
//                                                 'assets/icons/community/comment.png',
//                                                 width: 20.0,
//                                                 height: 20.0),
//                                           ),
//                                           Text("1k"),
//                                           SizedBox(width: size.width * 0.05),
//                                           Image.asset(
//                                               'assets/icons/community/forward.png',
//                                               width: 20.0,
//                                               height: 20.0),
//                                           Text("1k"),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: size.height * 0.04),
//                                 Container(
//                                   width: size.width,
//                                   height: 1,
//                                   color: Colors.black,
//                                 ),
//                                 Visibility(
//                                   visible: selectedPostIndex == index,
//                                   child: Container(
//                                       child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text("Comments"),
//                                           IconButton(
//                                             onPressed: () {
//                                               // Handle your action when the down arrow is pressed
//                                             },
//                                             icon: Icon(Icons.arrow_downward),
//                                           ),
//                                         ],
//                                       ),
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         itemCount: post.comments.length,
//                                         itemBuilder: (context, commentIndex) {
//                                           Comment comment =
//                                               post.comments[commentIndex];

//                                           return Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 20.0,
//                                                 backgroundColor:
//                                                     Colors.transparent,
//                                                 child: ClipOval(
//                                                   child: CachedNetworkImage(
//                                                     imageUrl:
//                                                         comment.commentorImage,
//                                                     fit: BoxFit.cover,
//                                                     width: 40.0,
//                                                     height: 40.0,
//                                                     placeholder: (context,
//                                                             url) =>
//                                                         CircularProgressIndicator(),
//                                                     errorWidget:
//                                                         (context, url, error) =>
//                                                             Icon(Icons.error),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: size.width * 0.02,
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     padding: EdgeInsets.all(20),
//                                                     width: size.width * 0.75,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 0.0),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 20.0),
//                                                         bottomLeft:
//                                                             Radius.circular(
//                                                                 20.0),
//                                                         bottomRight:
//                                                             Radius.circular(
//                                                                 20.0),
//                                                       ),
//                                                       color: MyColors.lightGrey,
//                                                       border: Border.all(
//                                                         color:
//                                                             MyColors.greyShadow,
//                                                         width: 1,
//                                                       ),
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: Color.fromRGBO(
//                                                               0, 0, 0, 0.25),
//                                                           offset: Offset(1, 1),
//                                                           blurRadius: 4.0,
//                                                           spreadRadius: 0.0,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           comment.commentorName,
//                                                           style: GoogleFonts
//                                                               .roboto(
//                                                             textStyle:
//                                                                 TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color:
//                                                                   Colors.black,
//                                                               fontSize: 10,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(
//                                                               "Shared Feb 5",
//                                                               style: GoogleFonts
//                                                                   .roboto(
//                                                                 textStyle:
//                                                                     TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: Color
//                                                                       .fromRGBO(
//                                                                           147,
//                                                                           147,
//                                                                           147,
//                                                                           1),
//                                                                   fontSize: 8,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                               "4h",
//                                                               style: GoogleFonts
//                                                                   .roboto(
//                                                                 textStyle:
//                                                                     TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: Color
//                                                                       .fromRGBO(
//                                                                           141,
//                                                                           141,
//                                                                           141,
//                                                                           1),
//                                                                   fontSize: 10,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         SizedBox(
//                                                             height:
//                                                                 size.height *
//                                                                     0.02),
//                                                         Text(
//                                                           comment.commentText,
//                                                           style: GoogleFonts
//                                                               .roboto(
//                                                             textStyle:
//                                                                 TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color:
//                                                                   Colors.black,
//                                                               fontSize: 12,
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       IconButton(
//                                                         onPressed: () {
//                                                           // Handle heart icon tap
//                                                         },
//                                                         icon: Icon(Icons
//                                                             .favorite_border),
//                                                       ),
//                                                       IconButton(
//                                                         onPressed: () {
//                                                           setState(() {
//                                                             // Toggle the visibility of comments for the selected post
//                                                             selectedPostIndex =
//                                                                 selectedPostIndex ==
//                                                                         index
//                                                                     ? -1
//                                                                     : index;
//                                                           });
//                                                         },
//                                                         icon:
//                                                             Icon(Icons.comment),
//                                                       ),
//                                                       IconButton(
//                                                         onPressed: () {
//                                                           // Handle forward icon tap
//                                                         },
//                                                         icon:
//                                                             Icon(Icons.forward),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   )),
//                                 ),
//                               ],
//                             ),
//                           );
//                         })
//                   ]),
//                 ),
//               ),
//             ),
//             SizedBox(height: size.height * 0.01)
//           ],
//         ),
//       ),
//     );
//   }
// }

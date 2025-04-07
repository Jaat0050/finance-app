// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// import '../../../utils/constants.dart';

// class AddPost extends StatefulWidget {
//   const AddPost({Key? key}) : super(key: key);

//   @override
//   _AddPostState createState() => _AddPostState();
// }

// class _AddPostState extends State<AddPost> {
//   TextEditingController textEditingController = TextEditingController();
//   String selectedValue = 'Option 1';

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyColors.white,
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
//             const Text(
//               'Add Post',
//               style: TextStyle(
//                 fontFamily: 'Rubik',
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//             // Spacer(),
//             // InkWell(
//             //   onTap: (){
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) => EditProfile(),
//             //       ),
//             //     );
//             //   },
//             //   child: Text(
//             //     'Edit Profile',
//             //     style: TextStyle(
//             //       fontFamily: 'Nunito',
//             //       fontWeight: FontWeight.w500,
//             //       color: MyColors.veryLightBlue, // Adjust color as needed
//             //       fontSize: 15,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Image selection placeholder (Replace with your image selection widget)
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 50.0,
//                   backgroundColor: Colors.transparent,
//                   child: ClipOval(
//                     child: CachedNetworkImage(
//                       imageUrl:
//                           'https://cdn.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.webp',
//                       fit: BoxFit.cover,
//                       width: size.width * 0.2,
//                       height: size.width * 0.2,
//                       placeholder: (context, url) =>
//                           const CircularProgressIndicator(),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//                 // DropdownButton<String>(
//                 //   value: selectedValue,
//                 //   onChanged: (String? newValue) {
//                 //     setState(() {
//                 //       selectedValue = newValue!;
//                 //     });
//                 //   },
//                 //   items: <String>[
//                 //     'Option 1',
//                 //     'Option 2',
//                 //     'Option 3',
//                 //     'Option 4'
//                 //   ].map<DropdownMenuItem<String>>((String value) {
//                 //     return DropdownMenuItem<String>(
//                 //       value: value,
//                 //       child: Text(value),
//                 //     );
//                 //   }).toList(),
//                 // ),
//                 const Spacer(),
//                 SizedBox(
//                   height: 32,
//                   width: 76,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // String postText = textEditingController.text;
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: MyColors.blue,
//                       disabledBackgroundColor: MyColors.veryLightBlue,
//                       minimumSize: const Size(double.infinity, 40),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text('Post'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: textEditingController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 hintText: 'Type Something....',
//                 border: InputBorder.none,
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }

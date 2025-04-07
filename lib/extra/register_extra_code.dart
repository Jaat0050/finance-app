//showbottomsheet
//   void showbottomsheet(Size size) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return BottomSheetWidget(
//           firstName: _firstNameController.text.toString(),
//           lastname: _lastNameController.text.toString(),
//           // dob: _dobController.text.toString(),
//           dob:
//               '${_dayController.text}-${_monthController.text}-${_yearController.text}',
//           gender: genderValue ?? 'Male',
//           email: _emailController.text.toString(),
//           phoneNumber: SharedPreferencesHelper.getUserPhone(),
//           city: _cityController.text.toString(),
//           state: _stateController.text.toString(),
//           invitationCode: _codeController.text.toString(),
//         );
//       },
//     );
//   }
// }
// ignore: must_be_immutable
// class BottomSheetWidget extends StatefulWidget {
//   String firstName;
//   String lastname;
//   String dob;
//   String gender;
//   String email;
//   String phoneNumber;
//   String city;
//   String state;
//   String invitationCode;
//   BottomSheetWidget({
//     super.key,
//     required this.firstName,
//     required this.lastname,
//     required this.dob,
//     required this.gender,
//     required this.email,
//     required this.phoneNumber,
//     required this.city,
//     required this.state,
//     required this.invitationCode,
//   });
//   @override
//   State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
// }
// class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//   final TextEditingController _agentIdController = TextEditingController();
//   bool isLoading = false;
//   double _containerHeight = 200;
//   @override
//   void dispose() {
//     super.dispose();
//     _agentIdController.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: _containerHeight,
//       width: size.width,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 25),
//             //---------------------------------------------text------------------------------------------//
//             const Padding(
//               padding: EdgeInsets.only(
//                 right: 40,
//                 left: 45,
//               ),
//               child: Text(
//                 'Agent ID',
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Color.fromRGBO(54, 54, 54, 1),
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Nunito',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             //------------------------------------------textfield----------------------------------------
//             Padding(
//               padding: const EdgeInsets.only(right: 40, left: 40),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Please enter Agent ID - 000000',
//                   hintStyle: const TextStyle(
//                     color: Color.fromRGBO(224, 224, 224, 1),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Nunito',
//                   ),
//                   contentPadding: const EdgeInsets.only(
//                     top: 10,
//                     bottom: 10,
//                     left: 10,
//                     right: 10,
//                   ),
//                   isDense: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: const BorderSide(
//                       color: Color.fromRGBO(142, 142, 142, 1),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     gapPadding: 0,
//                     borderSide: BorderSide(
//                       color: MyColors.blue,
//                       width: 1,
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     _containerHeight = 800;
//                   });
//                 },
//                 onTapOutside: (event) {
//                   setState(() {
//                     _containerHeight = 200;
//                     FocusScope.of(context).unfocus();
//                   });
//                 },
//                 onSubmitted: (value) {
//                   setState(() {
//                     _containerHeight = 200;
//                     FocusScope.of(context).unfocus();
//                   });
//                 },
//                 controller: _agentIdController,
//                 textAlign: TextAlign.start,
//                 cursorColor: MyColors.blue,
//               ),
//             ),
//             const SizedBox(height: 20),
//             //-----------------------------------button----------------------------------//
//             Padding(
//               padding: const EdgeInsets.only(right: 100, left: 100),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   disabledBackgroundColor: MyColors.blue,
//                   minimumSize: const Size(double.infinity, 40),
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
//                         if (_agentIdController.text.isEmpty) {
//                           Fluttertoast.showToast(
//                             msg: "Please Enter Agent ID - 000000",
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: MyColors.blue,
//                             textColor: Colors.white,
//                             fontSize: 16.0,
//                           );
//                         } else {
//                           if (ids.contains(_agentIdController.text)) {
//                             var registrationResponse =
//                                 await apiValue.registerUser(
//                               widget.firstName,
//                               widget.lastname,
//                               widget.dob,
//                               widget.gender,
//                               widget.email,
//                               widget.phoneNumber,
//                               widget.city,
//                               widget.state,
//                               widget.invitationCode,
//                             );
//                             if (registrationResponse != null) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               String userId = registrationResponse['data'][0]
//                                       ['_id']
//                                   .toString();
//                               SharedPreferencesHelper.setNewUserId(
//                                   userId: userId);
//                               SharedPreferencesHelper.setIsLoggedIn(
//                                   isLoggedIn: true);
//                               await GetUserData().getUserDetails(userId);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const UploadDocScreen(),
//                                 ),
//                               );
//                             } else {
//                               Fluttertoast.showToast(
//                                 msg: "Incorrect details",
//                                 toastLength: Toast.LENGTH_LONG,
//                                 gravity: ToastGravity.BOTTOM,
//                                 timeInSecForIosWeb: 1,
//                                 backgroundColor: MyColors.blue,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0,
//                               );
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             }
//                           } else {
//                             Fluttertoast.showToast(
//                               msg: "Invalid Agent ID",
//                               toastLength: Toast.LENGTH_LONG,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 1,
//                               backgroundColor: MyColors.blue,
//                               textColor: Colors.white,
//                               fontSize: 16.0,
//                             );
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         }
//                         setState(() {
//                           isLoading = false;
//                         });
//                       },
// child: isLoading
//     ? const Align(
//         alignment: Alignment.center,
//         child: SpinKitThreeBounce(
//           color: Colors.white,
//           size: 20,
//         ),
//       )
//     : const Text(
//                         'Submit',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
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
// }

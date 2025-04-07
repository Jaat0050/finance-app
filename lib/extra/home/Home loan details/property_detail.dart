// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mitra_fintech_agent/app/screens/bottom_nav/home_page/Home%20loan%20details/app_congrats.dart';

// import '../../../../utils/constants.dart';

// class PropertyDetail extends StatefulWidget {
//   const PropertyDetail({super.key});

//   @override
//   State<PropertyDetail> createState() => _PropertyDetailState();
// }

// class _PropertyDetailState extends State<PropertyDetail> {
//   final TextEditingController _fullAddressController = TextEditingController();
//   final TextEditingController _societyNameController = TextEditingController();
//   final TextEditingController _flatNumberController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();

//   String? selectedOcNumber;
//   String? selectedApprovedPlan;
//   String? selectedBluePrint;
//   String? selectedShareCertificate;

//   String? propertyType;

//   List<String> properties = [
//     'Single-Family Home',
//     'Multi-Family Residence',
//     'Condominium (Condo)',
//     'Townhouse',
//     'Commercial Property',
//   ];

//   bool isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _areaController.dispose();
//     _flatNumberController.dispose();
//     _fullAddressController.dispose();
//     _societyNameController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
//             padding: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               size: 20,
//               Icons.arrow_back_sharp,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: const Padding(
//           padding: EdgeInsets.only(left: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Property Details',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Color.fromRGBO(0, 0, 0, 1),
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Nunito',
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Text(
//                 'Please fill in the following information',
//                 style: TextStyle(
//                   fontSize: 9,
//                   color: Color.fromRGBO(103, 103, 103, 1),
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Nunito',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Container(
//           height: size.height,
//           width: size.width,
//           color: Colors.white,
//           padding: const EdgeInsets.only(left: 40, right: 40),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 //---------------------------------Property full address-------------------------------//

//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Property full address',
//                     style: TextStyle(
//                       fontSize: 12,
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
//                         top: 10, left: 10, right: 20, bottom: 10),
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
//                     hintText: 'Enter full address',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _fullAddressController,
//                   cursorColor: MyColors.blue,
//                   keyboardType: TextInputType.streetAddress,
//                   maxLines: 3,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Society name----Flat/ Building no-------------------------------//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: size.width * 0.36,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(
//                               left: 5,
//                             ),
//                             child: Text(
//                               'Society name',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'Nunito',
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.only(
//                                   top: 10, left: 10, right: 20, bottom: 10),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: MyColors.blue,
//                                   width: 1,
//                                 ),
//                               ),
//                               hintText: 'Enter Society name',
//                               hintStyle: const TextStyle(
//                                 color: Color.fromRGBO(224, 224, 224, 1),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Nunito',
//                               ),
//                             ),
//                             textAlign: TextAlign.start,
//                             controller: _societyNameController,
//                             cursorColor: MyColors.blue,
//                             keyboardType: TextInputType.streetAddress,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: size.width * 0.36,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(
//                               left: 5,
//                             ),
//                             child: Text(
//                               'Flat/ Building no',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color.fromRGBO(54, 54, 54, 1),
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: 'Nunito',
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.only(
//                                   top: 10, left: 10, right: 20, bottom: 10),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Color.fromRGBO(142, 142, 142, 1),
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(
//                                   color: MyColors.blue,
//                                   width: 1,
//                                 ),
//                               ),
//                               hintText: 'Enter Flat/ Building no',
//                               hintStyle: const TextStyle(
//                                 color: Color.fromRGBO(224, 224, 224, 1),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Nunito',
//                               ),
//                             ),
//                             textAlign: TextAlign.start,
//                             controller: _flatNumberController,
//                             cursorColor: MyColors.blue,
//                             keyboardType: TextInputType.streetAddress,
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //-----------------------------------Type Property--------------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Type Property',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 DropdownButtonFormField(
//                   value: propertyType,
//                   icon: const Icon(
//                     Icons.keyboard_arrow_down,
//                     color: Color.fromRGBO(90, 90, 90, 1),
//                     size: 25,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       propertyType = value!;
//                     });
//                   },
//                   items: properties.map((String type) {
//                     return DropdownMenuItem<String>(
//                       value: type,
//                       child: Text(type,
//                           style: const TextStyle(fontWeight: FontWeight.w400)),
//                     );
//                   }).toList(),
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.only(
//                         top: 15, left: 10, right: 20, bottom: 10),
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
//                     hintText: 'Type property',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------Property Area (Sqr ft)-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     left: 5,
//                   ),
//                   child: Text(
//                     'Property Area (Sqr ft)',
//                     style: TextStyle(
//                       fontSize: 12,
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
//                         top: 10, left: 10, right: 20, bottom: 10),
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
//                     hintText: 'Enter Property Area (Sqr ft)',
//                     hintStyle: const TextStyle(
//                       color: Color.fromRGBO(224, 224, 224, 1),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                   textAlign: TextAlign.start,
//                   controller: _areaController,
//                   cursorColor: MyColors.blue,
//                   keyboardType: TextInputType.streetAddress,
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 //---------------------------------OC Number-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: Text(
//                     'OC Number',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 20),
//                   width: size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'Yes',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedOcNumber == 'Yes',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedOcNumber = 'Yes';
//                                 });
//                               }
//                             },
//                           ),
//                           onTap: () {},
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'No',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedOcNumber == 'No',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedOcNumber = 'No';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 //---------------------------------Approved plan-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: Text(
//                     'Approved plan',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 20),
//                   width: size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'Yes',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedApprovedPlan == 'Yes',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedApprovedPlan = 'Yes';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'No',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedApprovedPlan == 'No',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedApprovedPlan = 'No';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 //---------------------------------Blue Print-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: Text(
//                     'Blue Print',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 20),
//                   width: size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'Yes',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedBluePrint == 'Yes',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedBluePrint = 'Yes';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'No',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedBluePrint == 'No',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedBluePrint = 'No';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 //---------------------------------Share Certificate-------------------------------//
//                 const Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: Text(
//                     'Share Certificate',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromRGBO(54, 54, 54, 1),
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Nunito',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 20),
//                   width: size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'Yes',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedShareCertificate == 'Yes',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedShareCertificate = 'Yes';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: const Text(
//                             'No',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color.fromRGBO(54, 54, 54, 1),
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           leading: CheckRadio(
//                             isSelected: selectedShareCertificate == 'No',
//                             onChanged: (bool value) {
//                               if (value) {
//                                 setState(() {
//                                   selectedShareCertificate = 'No';
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 //------------------------------------button-----------------------------------------//
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
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ApplicationCongrats(),
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
//                           'Submit',
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

// class CheckRadio extends StatelessWidget {
//   final bool isSelected;
//   final ValueChanged<bool> onChanged;

//   const CheckRadio({
//     Key? key,
//     required this.isSelected,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onChanged(!isSelected),
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isSelected ? MyColors.blue : Colors.white,
//           border: Border.all(
//             color: isSelected
//                 ? MyColors.blue
//                 : const Color.fromRGBO(142, 142, 142, 1),
//             width: 1,
//           ),
//         ),
//         child: isSelected
//             ? const Icon(Icons.check, size: 16.0, color: Colors.white)
//             : const Icon(
//                 Icons.circle,
//                 size: 16.0,
//                 color: Colors.transparent,
//               ),
//       ),
//     );
//   }
// }

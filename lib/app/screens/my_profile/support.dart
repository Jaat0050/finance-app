// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class SupportCentre extends StatefulWidget {
  const SupportCentre({super.key});

  @override
  State<SupportCentre> createState() => _SupportCentreState();
}

class _SupportCentreState extends State<SupportCentre> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController messageController = TextEditingController();

  _sendingMails() async {
    final mailtoLink = Mailto(
      to: ['support@mitrafintech.com'],
      subject: '',
      body: '',
    );

    try {
      if (await launch('$mailtoLink')) {
        await canLaunch('$mailtoLink');
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  // _makingPhoneCall(tel) async {
  //   var url = Uri.parse("tel:$tel");
  //   try {
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url);
  //     } else {}
  //   } on PlatformException catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  void dispose() {
    // nameController.dispose();
    // emailController.dispose();
    // phoneController.dispose();
    // messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Support Center',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: size.height,
          width: size.width,
          color: const Color(0xffFAFAFA),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                //----------------------------------------------top support image----------------------------------//
                Container(
                  height: 65,
                  width: 65,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 114, 94, 1),
                  ),
                  child: const Image(
                    image: AssetImage('assets/profile/support.png'),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //----------------------------------------------text 1----------------------------------//
                Text(
                  "We're here to assist you",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color.fromRGBO(46, 46, 46, 1),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //----------------------------------------------text 2----------------------------------//
                // Padding(
                //   padding: const EdgeInsets.only(left: 12, right: 10),
                //   child: Text(
                //     'Please submit enter the details of your request in this form below. We’ll respond within 24 hours of your request.',
                //     style: TextStyle(
                //       fontFamily: 'Nunito',
                //       fontWeight: FontWeight.w500,
                //       fontSize: 10.sp,
                //       color: const Color.fromRGBO(142, 142, 142, 1),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                //----------------------------------------------field container--------------------------------//
                // Container(
                //   width: size.width,
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: Column(
                //     children: [
                //       const SizedBox(
                //         height: 20,
                //       ),
                //       //----------------------------------------------name field----------------------------------//
                //       TextField(
                //         controller: nameController,
                //         keyboardType: TextInputType.name,
                //         cursorColor: MyColors.blue,
                //         decoration: InputDecoration(
                //           filled: true,
                //           hintText: 'Name',
                //           hintStyle: TextStyle(
                //             fontFamily: 'Nunito',
                //             fontWeight: FontWeight.w500,
                //             fontSize: 12.sp,
                //             color: const Color.fromRGBO(130, 130, 130, 1),
                //           ),
                //           fillColor: const Color.fromRGBO(255, 255, 255, 1),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(
                //               width: 1,
                //               color: Color.fromRGBO(142, 142, 142, 1),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: BorderSide(
                //               width: 1,
                //               color: MyColors.blue,
                //             ),
                //           ),
                //           contentPadding: const EdgeInsets.symmetric(
                //               vertical: 10, horizontal: 10),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 25,
                //       ),
                //       //----------------------------------------------email field----------------------------------//
                //       TextField(
                //         controller: emailController,
                //         keyboardType: TextInputType.emailAddress,
                //         cursorColor: MyColors.blue,
                //         decoration: InputDecoration(
                //           filled: true,
                //           hintText: 'Email',
                //           hintStyle: TextStyle(
                //             fontFamily: 'Nunito',
                //             fontWeight: FontWeight.w500,
                //             fontSize: 12.sp,
                //             color: const Color.fromRGBO(130, 130, 130, 1),
                //           ),
                //           fillColor: const Color.fromRGBO(255, 255, 255, 1),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(
                //               width: 1,
                //               color: Color.fromRGBO(142, 142, 142, 1),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: BorderSide(
                //               width: 1,
                //               color: MyColors.blue,
                //             ),
                //           ),
                //           contentPadding: const EdgeInsets.symmetric(
                //               vertical: 10, horizontal: 10),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 25,
                //       ),
                //       //----------------------------------------------phone field----------------------------------//
                //       TextField(
                //         controller: phoneController,
                //         keyboardType: TextInputType.phone,
                //         cursorColor: MyColors.blue,
                //         decoration: InputDecoration(
                //           filled: true,
                //           hintText: 'Phone Number',
                //           hintStyle: TextStyle(
                //             fontFamily: 'Nunito',
                //             fontWeight: FontWeight.w500,
                //             fontSize: 12.sp,
                //             color: const Color.fromRGBO(130, 130, 130, 1),
                //           ),
                //           fillColor: const Color.fromRGBO(255, 255, 255, 1),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(
                //               width: 1,
                //               color: Color.fromRGBO(142, 142, 142, 1),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: BorderSide(
                //               width: 1,
                //               color: MyColors.blue,
                //             ),
                //           ),
                //           contentPadding: const EdgeInsets.symmetric(
                //               vertical: 10, horizontal: 10),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 25,
                //       ),
                //       //----------------------------------------------message field----------------------------------//
                //       TextField(
                //         controller: messageController,
                //         keyboardType: TextInputType.multiline,
                //         maxLines: 4,
                //         cursorColor: MyColors.blue,
                //         decoration: InputDecoration(
                //           filled: true,
                //           hintText: 'Message',
                //           hintStyle: TextStyle(
                //             fontFamily: 'Nunito',
                //             fontWeight: FontWeight.w500,
                //             fontSize: 12.sp,
                //             color: const Color.fromRGBO(130, 130, 130, 1),
                //           ),
                //           fillColor: const Color.fromRGBO(255, 255, 255, 1),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(
                //               width: 1,
                //               color: Color.fromRGBO(142, 142, 142, 1),
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: BorderSide(
                //               width: 1,
                //               color: MyColors.blue,
                //             ),
                //           ),
                //           contentPadding: const EdgeInsets.symmetric(
                //               vertical: 10, horizontal: 10),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 25,
                //       ),
                //       //----------------------------------------------button---------------------------------------//
                //       ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: MyColors.blue,
                //           disabledBackgroundColor: MyColors.blue,
                //           minimumSize: const Size(double.infinity, 40),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //         onPressed: isLoading
                //             ? null
                //             : () async {
                //                 if (nameController.text.isEmpty) {
                //                   Fluttertoast.showToast(
                //                     msg: "Please Enter Your Name",
                //                     toastLength: Toast.LENGTH_LONG,
                //                     gravity: ToastGravity.BOTTOM,
                //                     timeInSecForIosWeb: 1,
                //                     backgroundColor: MyColors.blue,
                //                     textColor: Colors.white,
                //                     fontSize: 16.0,
                //                   );
                //                 } else if (emailController.text.isEmpty) {
                //                   Fluttertoast.showToast(
                //                     msg: "Please Enter Your Email",
                //                     toastLength: Toast.LENGTH_LONG,
                //                     gravity: ToastGravity.BOTTOM,
                //                     timeInSecForIosWeb: 1,
                //                     backgroundColor: MyColors.blue,
                //                     textColor: Colors.white,
                //                     fontSize: 16.0,
                //                   );
                //                 } else if (phoneController.text.isEmpty) {
                //                   Fluttertoast.showToast(
                //                     msg: "Please Enter Your Phone Number",
                //                     toastLength: Toast.LENGTH_LONG,
                //                     gravity: ToastGravity.BOTTOM,
                //                     timeInSecForIosWeb: 1,
                //                     backgroundColor: MyColors.blue,
                //                     textColor: Colors.white,
                //                     fontSize: 16.0,
                //                   );
                //                 } else if (messageController.text.isEmpty) {
                //                   Fluttertoast.showToast(
                //                     msg: "Please Enter Your Message",
                //                     toastLength: Toast.LENGTH_LONG,
                //                     gravity: ToastGravity.BOTTOM,
                //                     timeInSecForIosWeb: 1,
                //                     backgroundColor: MyColors.blue,
                //                     textColor: Colors.white,
                //                     fontSize: 16.0,
                //                   );
                //                 } else {
                //                   if ('some' == '') {
                //                     setState(() {
                //                       isLoading = true;
                //                     });
                //                   } else {
                //                     Fluttertoast.showToast(
                //                       msg: "We will contact you soon...",
                //                       toastLength: Toast.LENGTH_LONG,
                //                       gravity: ToastGravity.BOTTOM,
                //                       timeInSecForIosWeb: 1,
                //                       backgroundColor: MyColors.blue,
                //                       textColor: Colors.white,
                //                       fontSize: 16.0,
                //                     );

                //                     Navigator.pop(context);
                //                   }
                //                 }

                //                 setState(() {
                //                   isLoading = false;
                //                 });
                //               },
                //         child: isLoading
                //             ? const Align(
                //                 alignment: Alignment.center,
                //                 child: SpinKitThreeBounce(
                //                   color: Colors.white,
                //                   size: 20,
                //                 ),
                //               )
                //             : Text(
                //                 'Send Message',
                //                 style: TextStyle(
                //                   fontSize: 16.sp,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w600,
                //                   fontFamily: 'Nunito',
                //                 ),
                //               ),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                //----------------------------------------------mail container---------------------------------//
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _sendingMails(),
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 239, 232, 1),
                          ),
                          child: Icon(
                            Icons.mail,
                            color: MyColors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Get in touch',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Clear your queries.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(79, 79, 79, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        'support@mitrafintech.com',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(64, 72, 77, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //----------------------------------------------phone1 container---------------------------------//
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        // onTap: () => _makingPhoneCall('9930949835'),
                        onTap: () async {
                          String url =
                              "https://api.whatsapp.com/send/?phone=+919930949835&text=Hello&type=phone_number&app_absent=1";

                          final encodedUrl = Uri.encodeFull(url);
                          Uri uri = Uri.parse(encodedUrl);

                          try {
                            await launchUrl(uri);
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(255, 239, 232, 1),
                            ),
                            child: const Image(
                              image: AssetImage('assets/profile/image.png'),
                              fit: BoxFit.contain,
                            )),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Chat with us',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '24x7 chat support.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(79, 79, 79, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        '(+91) 99309 49835',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(64, 72, 77, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // //----------------------------------------------phone2 container---------------------------------//
                // Container(
                //   width: size.width,
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       GestureDetector(
                //         onTap: () => _makingPhoneCall('9653672539'),
                //         child: Container(
                //           height: 60,
                //           width: 60,
                //           padding: const EdgeInsets.all(5),
                //           decoration: const BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: Color.fromRGBO(255, 239, 232, 1),
                //           ),
                //           child: Icon(
                //             Icons.phone,
                //             color: MyColors.blue,
                //           ),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 12,
                //       ),
                //       Text(
                //         'Call us',
                //         style: TextStyle(
                //           fontFamily: 'Nunito',
                //           fontWeight: FontWeight.w600,
                //           fontSize: 17.sp,
                //           color: Colors.black,
                //         ),
                //       ),
                //       Text(
                //         '24x7 call support.',
                //         style: TextStyle(
                //           fontFamily: 'Nunito',
                //           fontWeight: FontWeight.w400,
                //           fontSize: 12.sp,
                //           color: const Color.fromRGBO(79, 79, 79, 1),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 22,
                //       ),
                //       Text(
                //         '(+91) 96536 72539',
                //         style: TextStyle(
                //           fontFamily: 'Nunito',
                //           fontWeight: FontWeight.w500,
                //           fontSize: 12.sp,
                //           color: const Color.fromRGBO(64, 72, 77, 1),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 12,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
}

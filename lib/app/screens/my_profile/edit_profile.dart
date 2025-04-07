import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  // VoidCallback profileRefresh;

  const EditProfile({
    super.key,
    // required this.profileRefresh,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profileController = Get.put(ProfileController());

  bool isLoading = false;
  bool isProfileDetailsFetched = false;

  final TextEditingController _pincodeController = TextEditingController();
  bool isPincodeValid = false;
  List<dynamic> fullAddress = [];
  bool isPincodeLoading = false;

  @override
  void initState() {
    profileController.initializePrefs();
    profileController.initImage();
    profileController.initProfileData();
    profileController.firstNameController.addListener(() {});
    profileController.lastNameController.addListener(() {});
    profileController.genderController.addListener(() {});
    profileController.dobController.addListener(() {});
    profileController.emailController.addListener(() {});
    profileController.cityController.addListener(() {});
    profileController.stateController.addListener(() {});
    _pincodeController.addListener(
      () {
        getAddress(_pincodeController.text);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    profileController.firstNameController.dispose();
    profileController.lastNameController.dispose();
    profileController.dobController.dispose();
    profileController.emailController.dispose();
    profileController.genderController.dispose();
    profileController.cityController.dispose();
    profileController.stateController.dispose();

    super.dispose();
  }

  Future<void> getAddress(String pincode) async {
    try {
      if (pincode.length == 6) {
        setState(() {
          isPincodeLoading = true;
        });
        fullAddress = await apiValue.getAddress(pincode);
        if (fullAddress.isNotEmpty) {
          setState(() {
            profileController.cityController.text = fullAddress[1]['District'];
            profileController.stateController.text = fullAddress[1]['State'];
            isPincodeValid = true;
            isPincodeLoading = false;
          });
        } else {
          setState(() {
            profileController.cityController.text = '';
            profileController.stateController.text = '';
            isPincodeLoading = false;
            isPincodeValid = false;
          });
          toastMsg('error while loading pincode');
        }
      } else {
        setState(() {
          profileController.cityController.text = '';
          profileController.stateController.text = '';
          isPincodeLoading = false;
          isPincodeValid = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarBuilder('Edit Profile'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: size.height,
          width: size.width,
          color: MyColors.dullWhite,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //------------------------------------------------------------column start------------------------------------------------//
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //---------------------------------------profile picture------------------------//
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     //add text in the center of the circle

                      //     Opacity(
                      //       opacity: 0.7,
                      //       child: Container(
                      //         height: 140,
                      //         width: 140,
                      //         decoration: const BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: Colors.transparent,
                      //         ),
                      //         child: SharedPreferencesHelper.getUserId() == ''
                      //             ? Container(
                      //                 foregroundDecoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Colors.grey.withOpacity(0.5),
                      //                   border: Border.all(
                      //                     color: Colors.grey,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Colors.grey,
                      //                   border: Border.all(
                      //                     color: Colors.grey,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 child: const CircleAvatar(
                      //                   radius: 50,
                      //                   backgroundColor: Colors.transparent,
                      //                   backgroundImage: AssetImage(
                      //                       'assets/profile/dummy_dp.png'),
                      //                 ),
                      //               )
                      //             : Container(
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   border: Border.all(
                      //                     color: Colors.grey,
                      //                     width: 2,
                      //                   ),
                      //                 ),
                      //                 child: CircleAvatar(
                      //                   radius: 50,
                      //                   backgroundColor: Colors.transparent,
                      //                   backgroundImage:
                      //                       CachedNetworkImageProvider(
                      //                     profileController.imageUrl.value,
                      //                   ),
                      //                 ),
                      //               ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       bottom: 5,
                      //       right: 10,
                      //       child: GestureDetector(
                      //         onTap: isUploadImgLoading
                      //             ? null
                      //             : () async {
                      //                 if (SharedPreferencesHelper.getUserId() !=
                      //                     '') {
                      //                   File? image =
                      //                       await profileController.pickImage();
                      //                   if (image != null) {
                      //                     setState(() {
                      //                       isUploadImgLoading = true;
                      //                     });
                      //                     var response = await apiValue
                      //                         .updateProfilePic(image);
                      //                     if (response != null) {
                      //                       await GetUserData().getUserDetails(
                      //                           SharedPreferencesHelper
                      //                               .getUserId());
                      //                       profileController.initImage();
                      //                       setState(() {
                      //                         isUploadImgLoading = false;
                      //                       });

                      //                       toastMsg(
                      //                           "Profile Picture Updated.");
                      //                     } else {
                      //                       setState(() {
                      //                         isUploadImgLoading = false;
                      //                       });
                      //                       toastMsg(
                      //                           "Error while uploading profile pic...");
                      //                     }
                      //                     setState(() {
                      //                       isUploadImgLoading = false;
                      //                     });
                      //                   } else {
                      //                     toastMsg('plzz try again');
                      //                   }
                      //                 }
                      //               },
                      //         child: Container(
                      //           padding: const EdgeInsets.all(7),
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: MyColors.white,
                      //             boxShadow: const [
                      //               BoxShadow(
                      //                 blurRadius: 6,
                      //                 color: Color.fromRGBO(0, 0, 0, 0.15),
                      //                 offset: Offset(0, 2),
                      //                 spreadRadius: 0,
                      //               ),
                      //             ],
                      //           ),
                      //           child: Center(
                      //             child: Icon(
                      //               size: 15,
                      //               Icons.camera_alt_outlined,
                      //               color: MyColors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       top: 60,
                      //       // right: ,
                      //       child: Center(
                      //         child: isUploadImgLoading
                      //             ? CircularProgressIndicator(
                      //                 color: MyColors.blue,
                      //               )
                      //             : Text(
                      //                 'CHANGE PHOTO',
                      //                 style: TextStyle(
                      //                   color: MyColors.white,
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w500,
                      //                   fontFamily: 'Nunito',
                      //                 ),
                      //               ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // const SizedBox(height: 30),
                      //---------------------------------------------------------------------first row--------------------------------------------------------//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //---------------------------------------------------first name---------------------------------------------------------//

                          rowForEditProfile(
                            size.width * 0.4,
                            profileController.firstNameController,
                            "First Name",
                            "First Name",
                            false,
                          ),

                          //---------------------------------------------------last name---------------------------------------------------------//

                          rowForEditProfile(
                            size.width * 0.4,
                            profileController.lastNameController,
                            "Last Name",
                            "Last Name",
                            false,
                          ),
                        ],
                      ),

                      //--------------------------------------------------------------------second row---------------------------------------------------------//

                      rowForEditProfile(
                        size.width,
                        profileController.emailController,
                        "Email ID",
                        "example@gmail.com",
                        false,
                      ),

                      //--------------------------------------------------------------------third row--------------------------------------------------------//

                      SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fieldName('Date of Birth (DOB)'),
                            TextField(
                                onTap: () async {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(1901),
                                    lastDate: DateTime(2023),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: MyColors.blue,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        final DateFormat outputFormat =
                                            DateFormat('dd/MM/yyyy');
                                        setState(() {
                                          profileController.dobController.text =
                                              outputFormat
                                                  .format(value)
                                                  .toString();
                                        });
                                      }
                                    },
                                  );
                                },
                                cursorColor: MyColors.blue,
                                controller: profileController.dobController,
                                keyboardType: TextInputType.none,
                                readOnly: true,
                                decoration: textfieldDecoration('Select Date')),
                          ],
                        ),
                      ),

                      //-------------------------------------------------------------------fourth row----------------------------------------------------//

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          fieldName('Gender'),
                          SizedBox(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: const Text('Male'),
                                    leading: Radio<String>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: MyColors.blue,
                                      value: 'Male',
                                      groupValue: profileController
                                          .selectedGender.value,
                                      onChanged:
                                          profileController.handleGenderChange,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: const Text(
                                      'Female',
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    leading: Radio<String>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: MyColors.blue,
                                      value: 'Female',
                                      groupValue: profileController
                                          .selectedGender.value,
                                      onChanged:
                                          profileController.handleGenderChange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      //-------------------------------------------------------------------fifth row----------------------------------------------------//

                      SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fieldName('Pincode'),
                            TextField(
                              cursorColor: MyColors.blue,
                              controller: _pincodeController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              decoration: textfieldDecoration('Enter Pincode'),
                            ),
                          ],
                        ),
                      ),

                      if (_pincodeController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: isPincodeLoading
                                ? Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: MyColors.blue,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isPincodeValid
                                        ? 'Pincode is Valid'
                                        : 'Pincode is Invalid',
                                    style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        color: isPincodeValid
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                      //-------------------------------------------------------------------fifth row----------------------------------------------------//

                      rowForEditProfile(
                        size.width,
                        profileController.cityController,
                        "City",
                        "Ex: Mumbai",
                        true,
                      ),

                      //-------------------------------------------------------------------sixth row----------------------------------------------------//

                      rowForEditProfile(
                        size.width,
                        profileController.stateController,
                        "State",
                        "Ex: Maharastra",
                        true,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.07),

                  //----------------------------------------------------button-------------------------------------------------------------------------//

                  SizedBox(
                    width: size.width * 0.75,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.blue,
                        disabledBackgroundColor: MyColors.blue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (profileController
                                  .firstNameController.value.text.isNotEmpty) {
                                profileController.firstName.value =
                                    profileController
                                        .firstNameController.value.text;
                              }
                              if (profileController
                                  .lastNameController.value.text.isNotEmpty) {
                                profileController.lastName.value =
                                    profileController
                                        .lastNameController.value.text;
                              }
                              if (profileController
                                  .dobController.value.text.isNotEmpty) {
                                profileController.dob.value =
                                    profileController.dobController.value.text;
                              }
                              if (profileController
                                  .emailController.value.text.isNotEmpty) {
                                profileController.email.value =
                                    profileController
                                        .emailController.value.text;
                              }
                              if (profileController
                                  .cityController.value.text.isNotEmpty) {
                                profileController.city.value =
                                    profileController.cityController.value.text;
                              }
                              if (profileController
                                  .stateController.value.text.isNotEmpty) {
                                profileController.state.value =
                                    profileController
                                        .stateController.value.text;
                              }

                              if (await apiValue.updateAgentProfile(
                                    profileController.firstName.value,
                                    profileController.lastName.value,
                                    profileController.email.value,
                                    profileController.dob.value,
                                    profileController.selectedGender.value,
                                    profileController.state.value,
                                    profileController.city.value,
                                  ) ==
                                  'success') {
                                await GetUserData().getUserDetails(
                                    );
                                profileController.initProfileData();

                                toastMsg("Profile updated successfully");

                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                toastMsg("Something Went Wrong");
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                      child: isLoading
                          ? const Align(
                              alignment: Alignment.center,
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowForEditProfile(
      size, controller, String text, String hintText, isReadOnly) {
    return SizedBox(
      width: size,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldName(text),
          TextField(
            controller: controller,
            keyboardType: hintText == 'example@gmail.com'
                ? TextInputType.emailAddress
                : TextInputType.name,
            readOnly: isReadOnly,
            cursorColor: MyColors.blue,
            decoration: textfieldDecoration(hintText),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: file_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

class ProfilePictureEditPage extends StatefulWidget {
  const ProfilePictureEditPage({
    Key? key,
  }) : super(key: key);

  @override
  ProfilePictureEditPageState createState() => ProfilePictureEditPageState();
}

class ProfilePictureEditPageState extends State<ProfilePictureEditPage> {
  final profileController = Get.put(ProfileController());

  // String profileImageUrl = SharedPreferencesHelper.getUserProfilePic();
  bool isUploadImgLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder('Edit Profile Picture'),
      body: Center(
        child: isUploadImgLoading
            ? CircularProgressIndicator(
                color: MyColors.blue,
              )
            : SizedBox(
                height: 450,
                width: MediaQuery.of(context).size.width,
                child: Obx(
                  () => CachedNetworkImage(
                    imageUrl: profileController.imageUrl.value,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color: MyColors.blue)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (SharedPreferencesHelper.getUserId() != '') {
            File? image = await profileController.pickImage();
            if (image != null) {
              setState(() {
                isUploadImgLoading = true;
              });
              var response = await apiValue.updateProfilePic(image);
              if (response != null) {
                await GetUserData()
                    .getUserDetails();
                profileController.initImage();
                setState(() {
                  isUploadImgLoading = false;
                });

                toastMsg("Profile Picture Updated.");
              } else {
                setState(() {
                  isUploadImgLoading = false;
                });
                toastMsg("Error while uploading profile pic...");
              }
              setState(() {
                isUploadImgLoading = false;
              });
            } else {
              toastMsg('plzz try again');
            }
          }
          Future.delayed(const Duration(seconds: 8), () {
            Navigator.pop(context);
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: MyColors.blue),
          child: const Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

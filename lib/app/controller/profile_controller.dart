import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/product_list.dart';

import '../utils/shared_pref_helper.dart';

class ProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString dob = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;
  RxString selectedGender = ''.obs;
  RxString state = ''.obs;
  RxString city = ''.obs;

  // List<String> gender = ['Male', 'Female', 'Others'];

  // List<String> states = statesOfIndia;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: MyColors.blue,
            toolbarWidgetColor: MyColors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (croppedFile != null) {
        int fileSizeInBytes = File(croppedFile.path).lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMb > 2) {
          toastMsg(
              "Large image size. Please select an image smaller than 2 MB.");
          return null;
        } else {
          return File(croppedFile.path);
        }
      }
    }
    return null;
  }

  void handleGenderChange(String? value) {
    selectedGender.value = value!;
  }

  void initImage() {
    imageUrl.value = SharedPreferencesHelper.getUserProfilePic();
  }

  void initProfileData() {
    firstName.value = SharedPreferencesHelper.getFirstName();
    lastName.value = SharedPreferencesHelper.getLastName();
    email.value = SharedPreferencesHelper.getUserEmail();
    dob.value = SharedPreferencesHelper.getUserDob();
    state.value = SharedPreferencesHelper.getUserState();
    city.value = SharedPreferencesHelper.getUserCity();
  }

  void initializePrefs() {
    firstNameController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();
    genderController = TextEditingController();
    lastNameController = TextEditingController();
    cityController = TextEditingController();

    stateController = TextEditingController();

    firstNameController.text = SharedPreferencesHelper.getFirstName();
    lastNameController.text = SharedPreferencesHelper.getLastName();
    dobController.text = SharedPreferencesHelper.getUserDob();
    emailController.text = SharedPreferencesHelper.getUserEmail();
    selectedGender.value = SharedPreferencesHelper.getUserGender();
    cityController.text = SharedPreferencesHelper.getUserCity();

    stateController.text = SharedPreferencesHelper.getUserState();
  }
}

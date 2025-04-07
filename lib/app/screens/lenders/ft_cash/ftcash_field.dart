import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/screens/lenders/ft_cash/resultscreen_ftcash.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/image_screen.dart';
import 'package:mitra_fintech_agent/app/screens/view_screens/pdfscreen.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/product_list.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class FTCashFieldScreen extends StatefulWidget {
  String pin;
  String amount;
  String imgUrl;
  String mail;
  String loanType;
  String landerName;

  FTCashFieldScreen({
    super.key,
    required this.pin,
    required this.amount,
    required this.imgUrl,
    required this.mail,
    required this.loanType,
    required this.landerName,
  });

  @override
  State<FTCashFieldScreen> createState() => _FTCashFieldScreenState();
}

class _FTCashFieldScreenState extends State<FTCashFieldScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  //-------------------------------------------------------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _residenceOwnershipController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _residenceDateController =
      TextEditingController();
  //-------------------------------------------------------------------------
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _companyTypeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _storeOwnershipController =
      TextEditingController();
  final TextEditingController _shopaddressController = TextEditingController();
  final TextEditingController _shopLocalityController = TextEditingController();
  final TextEditingController _shopStateController = TextEditingController();
  final TextEditingController _shopPincodeController = TextEditingController();
  final TextEditingController _businessDateController = TextEditingController();
  //---------------------------------------------------------------------------
  File? _pan;
  File? _aadharFront;
  File? _aadharBack;
  File? _photo;
  File? _homeAddressProof;
  File? _shopAddressProof;
  File? _optionalDoc;
  //----------------------------------------------------------------------------
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _bankStatement;
  String docName = 'pdf name';

  int selectedIndex = 0;

  List<String> companyType = businessCompanyList;
  String? companyValue;

  List<String> categoryType = businessCategoryList;
  String? categoryValue;

  List<String> productType = businessProductList;
  String? productValue;

  List<String> stateType = statesOfIndia;
  String? stateValue;

  List<String> ownershipType = ['Owned', 'Rent', 'other'];
  String? shopOownershipValue;
  String? ownershipValue;

  List<String> genderType = ['Male', 'Female', 'others'];
  String? genderValue;

  bool isLoading = false;
  bool isPincodeValid = false;
  bool isOtpSend = false;
  bool isFirstTime = true;
  bool isResendOtp = false;
  bool blockMultipleTap = false;
  bool isSendingConsentOTP = false;
  bool isConsentOTPValid = false;
  int _countdown = 15;
  late Timer _timer;

  List<dynamic> fullAddress = [];

  @override
  void initState() {
    super.initState();
    _pincodeController.text = widget.pin;
    _emailController.text = widget.mail;
    _loanAmountController.text = widget.amount;
    _shopPincodeController.addListener(() {
      getAddress(_shopPincodeController.text);
    });
    _firstNameController.addListener(_updateNameController);
    _lastNameController.addListener(_updateNameController);
  }

  void _updateNameController() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    _nameController.text = '$firstName $lastName';
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_countdown < 1) {
          timer.cancel();
          isResendOtp = false;
          blockMultipleTap = false;
        } else {
          _countdown -= 1;
        }
      });
    });
  }

  Future<void> verifyOTP(String otp) async {
    try {
      if (otp.length == 4) {
        setState(() {
          isSendingConsentOTP = true;
        });
        dynamic response =
            await apiValue.verifyConsentOTP(otp, _mobileNumberController.text);

        if (response == 'success') {
          setState(() {
            isConsentOTPValid = true;
            isSendingConsentOTP = false;
          });
        } else {
          setState(() {
            isConsentOTPValid = false;
            isSendingConsentOTP = false;
          });
        }
      } else {
        setState(() {
          isConsentOTPValid = false;
          isSendingConsentOTP = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAddress(String pincode) async {
    try {
      if (pincode.length == 6) {
        fullAddress = await apiValue.getAddress(pincode);

        if (fullAddress.isNotEmpty) {
          setState(() {
            isPincodeValid = true;
          });
        }
      } else {
        setState(() {
          isPincodeValid = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _getFromCamera(String documentType) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );

    if (image != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: MyColors.blue,
            toolbarWidgetColor: Colors.white,
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
          return;
        } else {
          setState(() {
            switch (documentType) {
              case 'image 1':
                _pan = File(croppedFile.path);
                break;
              case 'image 2':
                _aadharFront = File(croppedFile.path);
                break;
              case 'image 3':
                _aadharBack = File(croppedFile.path);
                break;
              case 'image 4':
                _photo = File(croppedFile.path);
                break;
              case 'image 5':
                _homeAddressProof = File(croppedFile.path);
                break;
              case 'image 6':
                _shopAddressProof = File(croppedFile.path);
                break;
              case 'image 7':
                _optionalDoc = File(croppedFile.path);
                break;
            }
          });
        }
      }
    }
  }

  _getFromGallery(String documentType) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (image != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: MyColors.blue,
            toolbarWidgetColor: Colors.white,
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
          return;
        } else {
          setState(() {
            switch (documentType) {
              case 'image 1':
                _pan = File(croppedFile.path);
                break;
              case 'image 2':
                _aadharFront = File(croppedFile.path);
                break;
              case 'image 3':
                _aadharBack = File(croppedFile.path);
                break;
              case 'image 4':
                _photo = File(croppedFile.path);
                break;
              case 'image 5':
                _homeAddressProof = File(croppedFile.path);
                break;
              case 'image 6':
                _shopAddressProof = File(croppedFile.path);
                break;
              case 'image 7':
                _optionalDoc = File(croppedFile.path);
                break;
            }
          });
        }
      }
    }
  }

  _getpdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = file.path.split('/').last;

      setState(() {
        _bankStatement = file;
        docName = fileName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Customer Details',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: MyColors.black,
                fontSize: 17,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 70,
              width: 80,
              child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                  errorWidget: (context, url, error) => const SizedBox()),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: const Color.fromRGBO(250, 250, 250, 1),
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //===================================================================================================================================================================================================================================================
                sectionTextBuilder('Customer Details'),
                //===================================================================================================================================================================================================================================================
                //----------------------------------Personal Details----------------------------------------------------
                fieldName(' First Name'),
                textField(_firstNameController, 'Enter first name', false,
                    false, false),

                //--------------------------------------------------------------------------------------
                fieldName(' Last Name'),
                textField(_lastNameController, 'Enter Last name', false, false,
                    false),

                //--------------------------------------------------------------------------------------
                fieldName(' Mobile Number'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          decoration: textfieldDecoration(
                              hintText: 'Please enter mobile number'),
                          textAlign: TextAlign.start,
                          controller: _mobileNumberController,
                          cursorColor: MyColors.blue,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: blockMultipleTap
                          ? null
                          : () async {
                              if (_mobileNumberController.text.isEmpty) {
                                toastMsg("Please Enter Your Mobile Number");
                              } else if (_mobileNumberController.text.length !=
                                  10) {
                                toastMsg("Please Enter a valid Mobile Number");
                              } else {
                                setState(() {
                                  isOtpSend = true;
                                  isFirstTime = false;
                                  blockMultipleTap = true;
                                });
                                if (await apiValue.sendConsentOTP(
                                        _mobileNumberController.text.toString(),
                                        _emailController.text) ==
                                    'success') {
                                  _otpController.clear();
                                  toastMsg("OTP Sent");
                                  setState(() {
                                    isOtpSend = false;
                                  });
                                } else {
                                  toastMsg("Something Went Wrong");
                                  setState(() {
                                    isOtpSend = false;
                                  });
                                }
                                setState(() {
                                  isResendOtp = true;
                                  _countdown = 15;
                                });
                                startTimer();
                              }
                            },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text(
                          isOtpSend
                              ? 'Sending'
                              : isResendOtp && !isOtpSend
                                  ? 'Resend ($_countdown)'
                                  : !isFirstTime
                                      ? 'Resend'
                                      : 'Send OTP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isOtpSend
                                ? MyColors.veryLightBlue
                                : isResendOtp
                                    ? MyColors.veryLightBlue
                                    : MyColors.blue,
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            decorationColor: isOtpSend
                                ? MyColors.veryLightBlue
                                : isResendOtp
                                    ? MyColors.veryLightBlue
                                    : MyColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //--------------------------------otp---------------------------------//

                fieldName(' Enter OTP'),
                Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (inputValue) async {
                      if (inputValue.length == 4) {
                        await verifyOTP(inputValue);
                      } else {
                        setState(() {
                          isConsentOTPValid = false;
                        });
                      }
                    },
                    enabled: !isFirstTime,
                    decoration:
                        textfieldDecoration(hintText: 'Please enter OTP'),
                    textAlign: TextAlign.start,
                    controller: _otpController,
                    cursorColor: MyColors.blue,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
                if (_otpController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      _otpController.text.length < 4
                          ? 'Enter a Valid OTP'
                          : isSendingConsentOTP
                              ? 'Verifying'
                              : isConsentOTPValid
                                  ? 'OTP Verified'
                                  : 'Wrong OTP',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: isConsentOTPValid ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                //--------------------------------------------------------------------------------------
                fieldName(' DOB'),
                textField(_dobController, 'dd-mm-yyyy', true, false, false),

                //------------------------profession-----------------------=//

                fieldName('Gender'),
                dropDownBuilder(
                    'Select one', _genderController, genderType, genderValue),

                //--------------------------------------------------------------------------------------
                fieldName('Aadhar Card Number'),
                textField(
                    _aadharController, 'Enter Aadhar', false, false, true),

                //--------------------------------------------------------------------------------------
                fieldName('Pan Card Number'),
                textField(_panController, 'Enter Pan', false, true, false),

                //--------------------------------------------------------------------------------------
                fieldName('Loan Amount'),
                textField(
                    _loanAmountController, 'Enter Amount', false, false, true),

                //===================================================================================================================================================================================================================================================
                sectionTextBuilder('Merchant Details'),
                //===================================================================================================================================================================================================================================================

                //----------------------------------Personal Details----------------------------------------------------
                fieldName('Merchant Name'),
                textField(_nameController, 'Enter Merchant Full name', false,
                    false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Merchant Email'),
                textField(_emailController, 'Enter Merchant email address',
                    false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Residence Ownership'),
                dropDownBuilder('Select one', _residenceOwnershipController,
                    ownershipType, ownershipValue),

                //--------------------------------------------------------------------------------------
                fieldName('Merchant Address'),
                textField(_addressController, 'Enter Merchant Address', false,
                    false, false),
                //--------------------------------------------------------------------------------------
                fieldName('Merchant city'),
                textField(_cityController, 'Enter Merchant city', false, false,
                    false),

                //--------------------------------------------------------------------------------------
                // fieldName('Merchant state'),
                // textField(_stateController, 'Enter Merchant state', false,
                //     false, false),

                fieldName('Merchant State'),
                dropDownBuilder(
                    'Select one', _stateController, stateType, stateValue),

                //--------------------------------------------------------------------------------------
                fieldName('Merchant pincode'),
                textField(
                    _pincodeController, 'Enter Pincode', false, false, true),

                //--------------------------------------------------------------------------------------
                fieldName('Residence Incorporation Date'),
                textField(
                    _residenceDateController, 'dd-mm-yyyy', true, false, false),

                //===================================================================================================================================================================================================================================================
                sectionTextBuilder('Business Details'),
                //===================================================================================================================================================================================================================================================

                //----------------------------------Personal Details----------------------------------------------------
                fieldName('Merchant Store Name'),
                textField(_storeNameController, 'Enter Merchant store name',
                    false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Company Type'),
                dropDownBuilder('Select one', _companyTypeController,
                    companyType, companyValue),

                //--------------------------------------------------------------------------------------
                fieldName('Category Name'),
                dropDownBuilder('Select one', _categoryController, categoryType,
                    categoryValue),

                //--------------------------------------------------------------------------------------
                fieldName('Product Name'),
                dropDownBuilder('Select one', _productController, productType,
                    productValue),

                //--------------------------------------------------------------------------------------
                fieldName('Store Ownership'),
                dropDownBuilder('Select one', _storeOwnershipController,
                    ownershipType, shopOownershipValue),

                //--------------------------------------------------------------------------------------
                fieldName('Shop Address'),
                textField(_shopaddressController, 'Enter shop address', false,
                    false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Shop Locality'),
                textField(_shopLocalityController, 'Enter shop locality', false,
                    false, false),

                //--------------------------------------------------------------------------------------
                // fieldName('Shop State'),
                // textField(_shopStateController, 'Enter shop state', false,
                //     false, false),

                fieldName('Shop State'),
                dropDownBuilder(
                    'Select one', _shopStateController, stateType, stateValue),

                //--------------------------------------------------------------------------------------
                fieldName('Shop pincode'),
                textField(
                  _shopPincodeController,
                  'Enter Pincode',
                  false,
                  false,
                  true,
                ),

                if (_shopPincodeController.text.isNotEmpty && !isPincodeValid)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      isPincodeValid
                          ? 'Pincode is Valid'
                          : 'Pincode is Invalid',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: isPincodeValid ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                //--------------------------------------------------------------------------------------
                fieldName('Business Incorporation Date'),
                textField(
                    _businessDateController, 'dd-mm-yyyy', true, false, false),

                //===================================================================================================================================================================================================================================================
                sectionTextBuilder('Document Details'),
                //===================================================================================================================================================================================================================================================

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder(
                    'Pan card', 'image 1', '', _pan, null, false, false, false),

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder('Aadhar card', 'image 2', 'image 3',
                    _aadharFront, _aadharBack, true, false, false),

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder('Merchant photo', 'image 4', '', _photo,
                    null, false, false, false),

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder('Residence Address proof', 'image 5', '',
                    _homeAddressProof, null, false, true, false),

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder('Shop Address proof', 'image 6', '',
                    _shopAddressProof, null, false, true, false),

                //----------------------------------------------------------------------------------------
                uploadDocHeaderBuilder('Add any one', 'image 7', '',
                    _optionalDoc, null, false, false, true),

                //===================================================================================================================================================================================================================================================
                sectionTextBuilder('Bank Details'),
                //===================================================================================================================================================================================================================================================

                //----------------------------------Personal Details----------------------------------------------------
                fieldName('Bank Name'),
                textField(_bankNameController, 'Enter Bank name', false, false,
                    false),

                //--------------------------------------------------------------------------------------
                fieldName('Account Number'),
                textField(_accountNumberController, 'Enter account no.', false,
                    false, true),

                //--------------------------------------------------------------------------------------
                fieldName('IFSC code'),
                textField(
                    _ifscCodeController, 'Enter IFSC', false, false, false),

                //--------------------------------------------------------------------------------------
                fieldName('Branch'),
                textField(
                    _branchController, 'Enter branch', false, false, false),

                //----------------------------------------------------------------------------------------

                _buildUploadPdfSlot('Bank Statement (1 year)', _bankStatement),

                //--------------------------------------------------------------------------------------
                fieldName('Password (if any)'),
                textField(_passwordController, '', false, false, false),

                //===================================================================================================================================================================================================================================================
                SizedBox(height: size.height * 0.04),

                //-------------------------------- button -------------------------------//
                Padding(
                  padding: const EdgeInsets.only(
                      right: 45, left: 45, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.blue,
                      disabledBackgroundColor: MyColors.blue,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            //-------------------------------------------//
                            if (_firstNameController.text.isEmpty) {
                              toastMsg("Please Enter First Name");
                            } else if (_lastNameController.text.isEmpty) {
                              toastMsg("Please Enter Last Name");
                            } else if (_mobileNumberController.text.isEmpty &&
                                _mobileNumberController.text.length != 10) {
                              toastMsg("Please Correct Mobile no.");
                            } else if (_otpController.text.isEmpty &&
                                _otpController.text.length != 4 &&
                                !isConsentOTPValid) {
                              toastMsg("Enter Correct OTP");
                            } else if (_dobController.text.isEmpty) {
                              toastMsg("Please Select Date of Birth");
                            } else if (_genderController.text.isEmpty) {
                              toastMsg("Please Select Gender");
                            } else if (_aadharController.text.isEmpty &&
                                _aadharController.text.length != 12) {
                              toastMsg("Please Enter Correct Aadhar no.");
                            } else if (_panController.text.isEmpty &&
                                _panController.text.length != 10) {
                              toastMsg("Please Enter Correct Pan no.");
                            } else if (_loanAmountController.text.isEmpty) {
                              toastMsg("Enter loan amount");
                            } else if (_nameController.text.isEmpty) {
                              toastMsg("Enter Merchant Name");
                            } else if (_emailController.text.isEmpty) {
                              toastMsg("Enter Merchant Email");
                            } else if (_residenceOwnershipController
                                .text.isEmpty) {
                              toastMsg("Select Residence Ownership");
                            } else if (_addressController.text.isEmpty) {
                              toastMsg("Enter Merchant address");
                            } else if (_cityController.text.isEmpty) {
                              toastMsg("Enter Merchant city");
                            } else if (_stateController.text.isEmpty) {
                              toastMsg("Enter Merchant state");
                            } else if (_pincodeController.text.isEmpty &&
                                _pincodeController.text.length != 6) {
                              toastMsg("Enter Valid pincode");
                            } else if (_residenceDateController.text.isEmpty) {
                              toastMsg("Select Residences incorporation date");
                            } else if (_storeNameController.text.isEmpty) {
                              toastMsg("Enter Store name");
                            } else if (_companyTypeController.text.isEmpty) {
                              toastMsg("Select Company type");
                            } else if (_categoryController.text.isEmpty) {
                              toastMsg("Select Category");
                            } else if (_productController.text.isEmpty) {
                              toastMsg("Select Product");
                            } else if (_storeOwnershipController.text.isEmpty) {
                              toastMsg("Select Store ownership");
                            } else if (_addressController.text.isEmpty) {
                              toastMsg("Enter shop address");
                            } else if (_shopLocalityController.text.isEmpty) {
                              toastMsg("Enter shop locality");
                            } else if (_shopStateController.text.isEmpty) {
                              toastMsg("Enter shop state");
                            } else if (_shopPincodeController.text.isEmpty &&
                                _shopPincodeController.text.length != 6) {
                              toastMsg("Enter valid shop pincode");
                            } else if (_businessDateController.text.isEmpty) {
                              toastMsg("Enter business incorporation date");
                            } else if (_pan == null) {
                              toastMsg("Upload pan photo");
                            } else if (_aadharFront == null) {
                              toastMsg("Upload aadhar front photo");
                            } else if (_aadharBack == null) {
                              toastMsg("Upload aadhar back photo");
                            } else if (_photo == null) {
                              toastMsg("Upload Merchant photo");
                            } else if (_homeAddressProof == null) {
                              toastMsg("Upload Residence address proof photo");
                            } else if (_shopAddressProof == null) {
                              toastMsg("Upload shop address proof photo");
                            } else if (_optionalDoc == null) {
                              toastMsg("Upload GST photo or Udyam certificate");
                            } else if (_bankNameController.text.isEmpty) {
                              toastMsg("Enter bank name");
                            } else if (_accountNumberController.text.isEmpty) {
                              toastMsg("Enter account number");
                            } else if (_ifscCodeController.text.isEmpty) {
                              toastMsg("Enter IFSC");
                            } else if (_branchController.text.isEmpty) {
                              toastMsg("Enter branch");
                            } else if (_bankStatement == null) {
                              toastMsg("Select bank statement");
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              var responseFTcash = await apiValue.ftCash(
                                _firstNameController.text,
                                _lastNameController.text,
                                _mobileNumberController.text,
                                _dobController.text,
                                _genderController.text,
                                _aadharController.text,
                                _panController.text,
                                _loanAmountController.text,
                                //
                                _nameController.text,
                                _emailController.text,
                                _residenceOwnershipController.text,
                                _addressController.text,
                                _cityController.text,
                                _stateController.text,
                                _pincodeController.text,
                                _residenceDateController.text,
                                //
                                _storeNameController.text,
                                _companyTypeController.text,
                                _categoryController.text,
                                _productController.text,
                                _storeOwnershipController.text,
                                _shopaddressController.text,
                                _shopLocalityController.text,
                                _shopStateController.text,
                                _shopPincodeController.text,
                                _businessDateController.text,
                                //
                                _pan,
                                _aadharFront,
                                _aadharBack,
                                _photo,
                                _shopAddressProof,
                                _homeAddressProof,
                                selectedIndex == 0 ? _optionalDoc : null,
                                selectedIndex == 1 ? _optionalDoc : null,
                                //
                                _bankNameController.text,
                                _accountNumberController.text,
                                _ifscCodeController.text,
                                _branchController.text,
                                _bankStatement,
                                _passwordController.text,
                                //
                                widget.loanType,
                              );

                              if (responseFTcash != null) {
                                if (responseFTcash['status'] == 'success') {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FTCashResult(
                                        askedAmount: _loanAmountController.text,
                                        imgUrl: widget.imgUrl,
                                        message: responseFTcash['message']
                                            .toString(),
                                        title: widget.landerName,
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: (EdgeInsets.zero),
                                        content: popupDialog(
                                          widget.imgUrl,
                                          responseFTcash['message'].toString(),
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                toastMsg("Server Timeout! try again");
                                setState(() {
                                  isLoading = false;
                                });
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }
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
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito',
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget fieldName(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 5, bottom: 10, top: 25),
  //     child: Text(
  //       text,
  //       style: GoogleFonts.roboto(
  //         textStyle: const TextStyle(
  //           fontSize: 14,
  //           color: Color.fromRGBO(54, 54, 54, 0.8),
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget textField(controller, String hintText, bool isDateSelection,
      bool ispan, bool isNumber) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        decoration: textfieldDecoration(hintText: hintText),
        textAlign: TextAlign.start,
        controller: controller,
        cursorColor: MyColors.blue,
        keyboardType: isDateSelection
            ? TextInputType.none
            : isNumber
                ? TextInputType.number
                : TextInputType.text,
        inputFormatters: ispan
            ? [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ]
            : [],
        onChanged: ispan
            ? (text) {
                controller.value = controller.value.copyWith(
                  text: text.toUpperCase(),
                );
              }
            : null,
        onTap: !isDateSelection
            ? () {}
            : () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1901),
                  lastDate: DateTime.now(),
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
                      final DateFormat outputFormat = DateFormat('dd-MM-yyyy');
                      setState(
                        () {
                          controller.text =
                              outputFormat.format(value).toString();
                        },
                      );
                    }
                  },
                );
              },
      ),
    );
  }

  Widget dropDownBuilder(
      String hintText, controller, List<String> type, String? value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonFormField(
        value: value,
        padding: const EdgeInsets.all(0),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromRGBO(142, 142, 142, 1),
          size: 17,
        ),
        onChanged: (value) {
          setState(() {
            value = value!;
            controller.text = value!;
          });
        },
        items: type.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(54, 54, 54, 0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
        isExpanded: true,
        menuMaxHeight: 400,
        isDense: true,
        decoration: textfieldDecoration(hintText: hintText),
      ),
    );
  }

  Widget uploadDocHeaderBuilder(String text, String docText1, String docText2,
      File? file1, File? file2, bool isTwo, bool isFullSize, bool isAnyOne) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 25, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.image_outlined, size: 24),
                  const SizedBox(width: 7),
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (file1 != null && !isTwo)
                Row(
                  children: [
                    Image(
                      image: const AssetImage(
                          'assets/uploadDocument/uploaded_doc.png'),
                      width: size.width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (docText1 == 'image 1') {
                            _pan = null;
                          }
                          if (docText1 == 'image 2') {
                            _aadharFront = null;
                          }
                          if (docText1 == 'image 3') {
                            _aadharBack = null;
                          }
                          if (docText1 == 'image 4') {
                            _photo = null;
                          }
                          if (docText1 == 'image 5') {
                            _homeAddressProof = null;
                          }
                          if (docText1 == 'image 6') {
                            _shopAddressProof = null;
                          }
                          if (docText1 == 'image 7') {
                            _optionalDoc = null;
                            selectedIndex = 0;
                          }
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              if (file1 != null && isTwo)
                if (file2 != null)
                  Row(
                    children: [
                      Image(
                        image: const AssetImage(
                            'assets/uploadDocument/uploaded_doc.png'),
                        width: size.width * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _aadharFront = null;
                            _aadharBack = null;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
          const Divider(color: Colors.black, thickness: 1),
          const SizedBox(height: 10),
          if (!isAnyOne)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // _getFromGallery(docText1);

                    _showImageSourceBottomSheet(docText1);
                  },
                  child: SizedBox(
                    // color: Colors.amber,
                    width: isFullSize ? size.width * 0.86 : size.width / 2.4,
                    height: isFullSize ? 120 : 85,
                    child: file1 != null
                        ? Image.file(
                            file1,
                            fit: BoxFit.fill,
                          )
                        : Image(
                            image: isFullSize
                                ? const AssetImage(
                                    'assets/uploadFiles/upload2.png')
                                : const AssetImage(
                                    'assets/uploadFiles/upload1.png'),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                if (isTwo)
                  GestureDetector(
                    onTap: () {
                      // _getFromGallery(docText2);
                      _showImageSourceBottomSheet(docText2);
                    },
                    child: SizedBox(
                      width: isFullSize ? size.width * 0.86 : size.width / 2.4,
                      height: isFullSize ? 120 : 85,
                      child: file2 != null
                          ? Image.file(
                              file2,
                              fit: BoxFit.fill,
                            )
                          : const Image(
                              image:
                                  AssetImage('assets/uploadFiles/upload1.png'),
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
              ],
            ),
          if (isAnyOne)
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 20, top: 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 245, 245, 1),
                border: Border.all(
                  color: const Color.fromRGBO(173, 173, 173, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width / 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 0,
                              groupValue: selectedIndex,
                              activeColor: MyColors.blue,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedIndex = value!;
                                });
                              },
                            ),
                            Text(
                              'GST photo',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                              file1 = null;
                            });
                            // _getFromGallery(docText1);
                            _showImageSourceBottomSheet(docText1);
                          },
                          child: SizedBox(
                            height: 75,
                            width: size.width / 2.7,
                            child: file1 != null && selectedIndex == 0
                                ? Image.file(
                                    file1,
                                    fit: BoxFit.fill,
                                  )
                                : const Image(
                                    image: AssetImage(
                                        'assets/uploadFiles/upload1.png'),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //----------------------------------------------------------------------------------------
                  SizedBox(
                    width: size.width / 2.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: 1,
                                groupValue: selectedIndex,
                                activeColor: MyColors.blue,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedIndex = value!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              'Udyam Certificate',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                              file1 = null;
                            });
                            // _getFromGallery(docText1);

                            _showImageSourceBottomSheet(docText1);
                          },
                          child: SizedBox(
                            height: 75,
                            width: size.width / 2.7,
                            child: file1 != null && selectedIndex == 1
                                ? Image.file(
                                    file1!,
                                    fit: BoxFit.fill,
                                  )
                                : const Image(
                                    image: AssetImage(
                                        'assets/uploadFiles/upload1.png'),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUploadPdfSlot(String text, File? file) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 25, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.image_outlined, size: 24),
                  const SizedBox(width: 7),
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (file != null)
                Row(
                  children: [
                    Image(
                      image: const AssetImage(
                          'assets/uploadDocument/uploaded_doc.png'),
                      width: size.width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          setState(() {
                            _bankStatement = null;
                          });
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const Divider(color: Colors.black, thickness: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: file != null
                    ? () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => PdfScreen(
                              initialUrl: file.path,
                              titleText: 'Bank Statement',
                            ),
                          ),
                        );
                      }
                    : () {
                        _getpdf();
                      },
                child: SizedBox(
                  // color: Colors.amber,
                  width: size.width * 0.84,
                  height: 120,
                  child: file != null
                      ? Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/uploadFiles/upload2.png'),
                            ),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: MyColors.blue,
                            size: size.height * 0.14,
                          ),
                        )
                      : const Image(
                          image: AssetImage('assets/uploadFiles/upload2.png'),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration textfieldDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(224, 224, 224, 1),
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
      ),
      contentPadding: const EdgeInsets.all(11),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        gapPadding: 0,
        borderSide: const BorderSide(
          color: Color.fromRGBO(142, 142, 142, 1),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        gapPadding: 0,
        borderSide: BorderSide(
          color: MyColors.blue,
          width: 1,
        ),
      ),
    );
  }

  Widget sectionTextBuilder(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: MyColors.dullWhite,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Divider(
                color: MyColors.blue,
                thickness: 1,
              )),
              Text(
                '  $text  ',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                  child: Divider(
                color: MyColors.blue,
                thickness: 1,
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet(String doc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                title: const Text(
                  'From Camera',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getFromCamera(doc);
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                title: const Text(
                  'From Gallery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _getFromGallery(doc);
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget popupDialog(String url, String text) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(url),
                  fit: BoxFit.contain,
                  onError: (exception, stackTrace) => const SizedBox(),
                ),
              ),
            ),
          ),
          Container(
            height: 180,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                text == "Case already exists"
                    ? "Customer already exists. Please try another lead."
                    : text,
                textAlign: TextAlign.center,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.blue,
                disabledBackgroundColor: MyColors.veryLightBlue,
                minimumSize: const Size(100, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

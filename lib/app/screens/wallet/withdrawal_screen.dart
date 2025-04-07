// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitra_fintech_agent/app/screens/login%20screens/upload_doc.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/screens/wallet/transactions.dart';
import 'package:mitra_fintech_agent/app/controller/commission_controller.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';

// ignore: must_be_immutable
class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  late CommissionController commissionController;
  TextEditingController amountController = TextEditingController();
  int selectedIndex = 0;
  String selectedID = '';
  List upiIDs = [];
  bool caseLoading = false;
  bool isLoading = false;

  void fetchUPIIDs() async {
    var responseUPIList = await apiValue.getUPI();
    if (responseUPIList != null) {
      setState(() {
        upiIDs = responseUPIList;
        caseLoading = false;
        selectedID = upiIDs[0]['_id'];
      });
      box.put("upiIDs");
    } else {
      if (mounted) {
        setState(() {
          caseLoading = false;
        });
      }
    }
  }

  Future<void> initializePrefs() async {
    setState(() {
      caseLoading = true;
    });
    await Future.wait([
      commissionController.getCommissionDetails(),
    ]);
    if (mounted) {
      setState(() {});
    }

    setState(() {
      caseLoading = false;
    });
  }

  @override
  void initState() {
    upiIDs = box.get("upiIDs") ?? [];

    commissionController = Get.put(CommissionController());

    if (upiIDs.isEmpty) {
      fetchUPIIDs();
    }

    initializePrefs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
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
        centerTitle: true,
        title: Text(
          'Withdrawal',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: MyColors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyColors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: RefreshIndicator(
        color: MyColors.blue,
        onRefresh: () async {
          initializePrefs();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: MyColors.dullWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColors.blue, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'How Much?',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 58,
                          margin: const EdgeInsets.only(top: 15, bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                spreadRadius: 0,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '₹',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.firaSans(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: amountController,
                                    cursorColor: MyColors.blue,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    style: GoogleFonts.firaSans(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: GoogleFonts.firaSans(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      isDense: true,
                                      alignLabelWithHint: false,
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      contentPadding:
                                          const EdgeInsets.only(left: 5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (!SharedPreferencesHelper.getAadhaar()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UploadDocScreen(
                                              isfromInside: true,
                                            ),
                                          ));
                                    } else if (!SharedPreferencesHelper
                                        .getPan()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UploadDocScreen(
                                            isfromInside: true,
                                          ),
                                        ),
                                      );
                                    } else if (!SharedPreferencesHelper
                                        .getAggrement()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UploadDocScreen(
                                            isfromInside: true,
                                          ),
                                        ),
                                      );
                                    } else {
                                    if (upiIDs.isEmpty) {
                                      toastMsg('Add UPI id');
                                    } else if (selectedIndex == -1) {
                                      toastMsg('Select UPI id');
                                    } else if (amountController.text.isEmpty) {
                                      toastMsg('Enter Amount');
                                    } else if (int.parse(
                                            amountController.text) <
                                        10) {
                                      toastMsg('Min permitted amount is Rs.10');
                                    } else if (int.parse(
                                            amountController.text) >
                                        int.parse(
                                          commissionController
                                              .commissionAmount.value,
                                        )) {
                                      toastMsg(
                                          'Max amount should be less than Rs.${NumberFormat('#,##,###').format(int.parse(
                                        commissionController
                                            .commissionAmount.value,
                                      ))}');
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (await apiValue.withdrawal(selectedID,
                                              amountController.text) ==
                                          'success') {
                                        toastMsg(
                                            'Withdrawal request placed successfully');
                                        setState(() {
                                          isLoading = false;
                                          amountController.clear();
                                        });
                                      } else {
                                        toastMsg('Something went wrong');
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.blue,
                              onPrimary: MyColors.blue,
                              disabledBackgroundColor: MyColors.blue,
                              minimumSize: const Size(160, 37),
                              maximumSize: const Size(160, 37),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: isLoading
                                ? const Align(
                                    alignment: Alignment.center,
                                    child: SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  )
                                : Text(
                                    "Withdraw Now",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.white,
                                    ),
                                  ),
                          ),
                        ),
                        Text(
                          'Commission balance: ₹ ${NumberFormat('#,##,###').format(int.parse(
                            commissionController.commissionAmount.value,
                          ))}',
                          style: GoogleFonts.firaSans(
                            textStyle: TextStyle(
                              color: MyColors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 40, right: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'UPI',
                            style: GoogleFonts.firaSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                enableDrag: true,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const BottomSheetWidget();
                                },
                              ).then(
                                (value) {
                                  initializePrefs();
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  caseLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyColors.blue,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(240, 240, 240, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                spreadRadius: 0,
                                offset: Offset(2, 3),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: size.width,
                                height: 8,
                                child: const Divider(
                                    color: Colors.white, thickness: 1.5),
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: upiIDs.length,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedID = upiIDs[index]['_id'];
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: index,
                                            groupValue: selectedIndex,
                                            activeColor: MyColors.blue,
                                            onChanged: (int? value) {
                                              setState(() {
                                                selectedIndex = value!;
                                                selectedID =
                                                    upiIDs[index]['_id'];
                                              });
                                            },
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                upiIDs[index]['upi'],
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 1),
                                              Text(
                                                upiIDs[index]['name'],
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DeleteDialog(
                                                  id: upiIDs[index]['_id'],
                                                  upiId: upiIDs[index]['upi'],
                                                );
                                              }).then(
                                            (value) {
                                              setState(() {
                                                initializePrefs();
                                              });
                                            },
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.delete_outline,
                                            size: 20,
                                            color: Color.fromRGBO(0, 0, 0, 0.6),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Transactions',
                        style: GoogleFonts.firaSans(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      splashColor: MyColors.veryLightBlue,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TransacrtionsScreen()));
                      },
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.all(10),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              spreadRadius: 0,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Transaction History',
                                  style: GoogleFonts.firaSans(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(62, 52, 62, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //toast
  void toastMsg(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: MyColors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

// ignore: must_be_immutable
class DeleteDialog extends StatefulWidget {
  String id;
  String upiId;
  DeleteDialog({required this.id, required this.upiId, super.key});

  @override
  DeleteDialogState createState() => DeleteDialogState();
}

class DeleteDialogState extends State<DeleteDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.transparent,
                offset: Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Delete',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "DM_Sans",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(88, 88, 88, 0.68),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Are you sure you want to delete below UPI id\n${widget.upiId}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "DM_Sans",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: MyColors.blue,
                        ),
                      ),
                      width: 79,
                      height: 32,
                      child: const Center(
                        child: Text(
                          "Go back",
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'DM_Sans',
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          await apiValue.deleteUPI(widget.id);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.blue,
                      ),
                      width: 79,
                      height: 32,
                      child: Center(
                        child: isLoading
                            ? const Align(
                                alignment: Alignment.center,
                                child: SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            : const Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'DM_Sans',
                                    fontWeight: FontWeight.w400),
                              ),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
  });
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final TextEditingController _idController = TextEditingController();
  bool isLoading = false;
  bool isIdValid = false;
  String nameAtBank = '';
  String message = 'Invalid UPI ID';

  @override
  void initState() {
    super.initState();
    _idController.addListener(() {
      getIdDetails(_idController.text);
    });
  }

  Future<void> getIdDetails(String id) async {
    try {
      if (_idController.text.contains('@') && _idController.text.length > 10) {
        var response = await apiValue.checkUpiId(id);
        if (response != null) {
          setState(() {
            isIdValid = true;
            nameAtBank = response['data'][0]['nameAtBank'];
          });
        } else {
          setState(() {
            isIdValid = false;
          });
        }
      } else {
        setState(() {
          isIdValid = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
  }

  double _containerHeight = 300;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: _containerHeight,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------------------------text------------------------------------------//
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, bottom: 10, top: 30),
                child: Text(
                  'Enter UPI ID',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            //------------------------------------------textfield----------------------------------------
            Center(
              child: Container(
                width: size.width * 0.85,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(130, 130, 130, 1),
                        width: 0.3),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(217, 217, 217, 0.25)),
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    isDense: true,
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  // onChanged: (value) async {
                  //   if (value.contains('@') && value.length > 10) {
                  //     await getIdDetails(value);
                  //   }
                  //   setState(() {});
                  // },
                  onTap: () {
                    setState(() {
                      _containerHeight = size.height * 0.67;
                    });
                  },
                  onTapOutside: (event) {
                    setState(() {
                      _containerHeight = 300;
                      FocusScope.of(context).unfocus();
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      _containerHeight = 300;
                      FocusScope.of(context).unfocus();
                    });
                  },
                  controller: _idController,
                  textAlign: TextAlign.start,
                  cursorColor: MyColors.blue,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_idController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 5),
                child: Row(
                  children: [
                    if (isIdValid)
                      const Image(
                        image: AssetImage('assets/icons/verify.png'),
                        fit: BoxFit.contain,
                        height: 18,
                      ),
                    const SizedBox(width: 5),
                    Text(
                      isIdValid ? nameAtBank : message,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: isIdValid ? Colors.black : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),
            //-----------------------------------button----------------------------------//
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue,
                  onPrimary: MyColors.blue,
                  disabledBackgroundColor: MyColors.blue,
                  minimumSize: const Size(160, 37),
                  maximumSize: const Size(160, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (_idController.text.isEmpty) {
                          toastMsg('Please enter Upi Id');
                        } else if (!_idController.text.contains('@') &&
                            _idController.text.length < 10) {
                          toastMsg('Please enter valid Upi Id');
                        } else if (!isIdValid) {
                          toastMsg('Please enter valid Upi Id');
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          if (await apiValue.addUPI(
                                  _idController.text, nameAtBank) ==
                              'success') {
                            Navigator.pop(context);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            toastMsg('error');
                            setState(() {
                              isLoading = false;
                            });
                          }
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
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito',
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //toast
  void toastMsg(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: MyColors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

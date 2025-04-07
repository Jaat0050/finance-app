import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';

InputDecoration textfieldDecoration(String hintText) {
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

Widget fieldNameForUploadDoc(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      textStyle: const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(54, 54, 54, 0.8),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget fieldName(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, bottom: 10, top: 25),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(54, 54, 54, 0.8),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

//-------------------------------------------------toast-------------------------------------------------//

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

//-------------------------------------------------common app bar----------------------------------------------//

PreferredSizeWidget appBarBuilder(String text) {
  return AppBar(
    centerTitle: false,
    backgroundColor: MyColors.dullWhite,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    automaticallyImplyLeading: true,
    scrolledUnderElevation: 0,
    title: appBarTextBuilder(text),
  );
}

//-------------------------------------------------app bar text----------------------------------------------//

Widget appBarTextBuilder(String text) {
  return Text(
    text,
    style: GoogleFonts.rubik(
      textStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

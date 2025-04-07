import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/edit_profile.dart';
import 'package:mitra_fintech_agent/app/utils/common_widgets.dart';
import 'package:mitra_fintech_agent/app/utils/get_user_data.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';

import '../../utils/constants.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  // String? name;
  // String? dob;
  // String? gender;

  // Future<void> initializePrefs() async {
  //   try {
  //     setState(() {
  //       name =
  //           '${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}';
  //       dob = SharedPreferencesHelper.getUserDob();
  //       gender = SharedPreferencesHelper.getUserGender();
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initializePrefs();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: appBarTextBuilder(' Personal Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const EditProfile(),
                  ),
                ).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              child: Icon(Icons.edit_note_rounded, color: Colors.black),
            ),
          )
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: MyColors.dullWhite,
        child: RefreshIndicator(
          color: MyColors.blue,
          onRefresh: () async {
            await GetUserData()
                .getUserDetails();
        
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                //-----------------------------------------name-------------------------------------------//

                textRowBuilder('Full Name',
                    '${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}'),

                //-----------------------------------------DOB-------------------------------------------//

                textRowBuilder(
                    'Date of Birth', SharedPreferencesHelper.getUserDob()),

                //-----------------------------------------gender-------------------------------------------//

                textRowBuilder(
                    'Gender', SharedPreferencesHelper.getUserGender()),

                //-----------------------------------------phone-------------------------------------------//

                textRowBuilder('Phone no.',
                    "+91 ${SharedPreferencesHelper.getUserPhone()}"),

                //-----------------------------------------email-------------------------------------------//

                textRowBuilder(
                    'Email address', SharedPreferencesHelper.getUserEmail()),

                //-----------------------------------------city-------------------------------------------//

                textRowBuilder('City', SharedPreferencesHelper.getUserCity()),

                //-----------------------------------------State-------------------------------------------//

                textRowBuilder('State', SharedPreferencesHelper.getUserState()),

                //---------------------------------------Nationality----------------------------------------//

                textRowBuilder('Nationality', 'Indian'),

                //---------------------------------------aadhaar-------------------------------------------//

                if (SharedPreferencesHelper.getaadharNumber().isNotEmpty)
                  textRowBuilder(
                      'Aadhar No.',
                      SharedPreferencesHelper.getaadharNumber().isNotEmpty
                          ? SharedPreferencesHelper.getaadharNumber()
                          : '-'),

                //-----------------------------------------pan-------------------------------------------//

                if (SharedPreferencesHelper.getPanNumber().isNotEmpty)
                  textRowBuilder(
                      'PAN',
                      SharedPreferencesHelper.getPanNumber().isNotEmpty
                          ? SharedPreferencesHelper.getPanNumber()
                          : '-'),

                //-----------------------------------------gst-------------------------------------------//

                if (SharedPreferencesHelper.getUserGST().isNotEmpty)
                  textRowBuilder(
                      'GST no.',
                      SharedPreferencesHelper.getUserGST().isNotEmpty
                          ? SharedPreferencesHelper.getUserGST()
                          : '-'),

                //-----------------------------------------referral-------------------------------------------//

                textRowBuilder(
                    'Referral Code', SharedPreferencesHelper.getReferalCode()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textRowBuilder(String text1, String text2) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Text(
                  text1,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(122, 122, 122, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  text2,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}

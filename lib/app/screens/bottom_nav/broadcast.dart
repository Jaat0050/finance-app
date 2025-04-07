// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/controller/broadcast_controller.dart';
import 'package:mitra_fintech_agent/app/controller/profile_controller.dart';
import 'package:mitra_fintech_agent/app/screens/my_profile/profile.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';
import 'package:mitra_fintech_agent/app/utils/shared_pref_helper.dart';
import 'package:mitra_fintech_agent/main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  final profileController = Get.put(ProfileController());
  final broadcastController = Get.put(BroadcastController());

  Future<void> _shareImageAndText(imageUrl, message) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.jpg').create();
    await file.writeAsBytes(bytes);
    await Share.shareFiles(
      [file.path],
      text: '$message',
    );
  }

  @override
  void initState() {
    broadcastController.initializePrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: MyColors.dullWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text(
          'Broadcast',
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          // ======== DP ==========
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 15, top: 8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: SharedPreferencesHelper.getUserId() == ''
                  ? const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage('assets/profile/dummy_dp.png'),
                    )
                  : Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: CachedNetworkImageProvider(
                          profileController.imageUrl.value,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: size.height * 0.8,
          width: size.width,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Obx(
            () => broadcastController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.blue,
                    ),
                  )
                : broadcastController.posterList.isEmpty
                    ? RefreshIndicator(
                        color: MyColors.blue,
                        onRefresh: () async {
                          await broadcastController.initPosters();
                        },
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: SizedBox(
                              width: size.width,
                              height: size.height * 0.6,
                              child: OtherTabsContent(),
                            )))
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: RefreshIndicator(
                          color: MyColors.blue,
                          onRefresh: () async {
                            await broadcastController.initPosters();
                          },
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: broadcastController.posterList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 15);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.23,
                                    width: size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: TextEditorDialog(
                                                imageUrl: broadcastController
                                                    .posterList
                                                    .value[index]['icon'],
                                                text:
                                                    '🌟 *Your Loan Mitra, from Mitra Fintech* 🌟\n\n'
                                                    'This is ${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}, your trusted loan mitra (friend), here to assist you with any kind of Personal Loan, Home Loan, Mortgage, Startup Finance, and Credit Cards.\n\n'
                                                    '✅ No fees involved!\n'
                                                    '✅ Access finance from 50+ banks & NBFCs.\n'
                                                    '✅ Enjoy a purely digital process, taking just a few minutes to apply.\n\n'
                                                    "Feel free to reach out to me on ${SharedPreferencesHelper.getUserPhone()} for any of your financial requirements.",
                                              ),
                                            );

                                            // AlertDialog(
                                            //   backgroundColor:
                                            //       Colors.transparent,
                                            //   contentPadding: (EdgeInsets.zero),
                                            //   content: GestureDetector(
                                            //     onTap: () {
                                            //       FocusScope.of(context)
                                            //           .unfocus();
                                            //     },
                                            //     child: popupDialog(
                                            //         '🌟 *Your Loan Mitra, from Mitra Fintech* 🌟\n\n'
                                            //         'This is ${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}, your trusted loan mitra (friend), here to assist you with any kind of Personal Loan, Home Loan, Mortgage, Startup Finance, and Credit Cards.\n\n'
                                            //         '✅ No fees involved!\n'
                                            //         '✅ Access finance from 50+ banks & NBFCs.\n'
                                            //         '✅ Enjoy a purely digital process, taking just a few minutes to apply.\n\n'
                                            //         "Feel free to reach out to me on ${SharedPreferencesHelper.getUserPhone()} for any of your financial requirements.",
                                            //         posterList[index]['icon']),
                                            //   ),
                                            // );
                                          },
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: broadcastController
                                            .posterList.value[index]['icon'],
                                        fit: BoxFit.contain,
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: MyColors.blue,
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: broadcastController
                                                        .isTap.value
                                                    ? null
                                                    : () async {
                                                        setState(() {
                                                          broadcastController
                                                              .isTap
                                                              .value = true;
                                                        });
                                                        _shareImageAndText(
                                                          broadcastController
                                                                  .posterList
                                                                  .value[index]
                                                              ['icon'],
                                                          '🌟 *Your Loan Mitra, from Mitra Fintech* 🌟\n\n'
                                                          'This is ${SharedPreferencesHelper.getFirstName()} ${SharedPreferencesHelper.getLastName()}, your trusted loan mitra (friend), here to assist you with any kind of Personal Loan, Home Loan, Mortgage, Startup Finance, and Credit Cards.\n\n'
                                                          '✅ No fees involved!\n'
                                                          '✅ Access finance from 50+ banks & NBFCs.\n'
                                                          '✅ Enjoy a purely digital process, taking just a few minutes to apply.\n\n'
                                                          "Feel free to reach out to me on ${SharedPreferencesHelper.getUserPhone()} for any of your financial requirements.",
                                                        );
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 3));
                                                        setState(() {
                                                          broadcastController
                                                              .isTap
                                                              .value = false;
                                                        });
                                                      },
                                                child: const Icon(
                                                  Icons.share,
                                                  size: 22,
                                                )),
                                            const SizedBox(width: 10),
                                            Text(
                                              '',
                                              style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      57, 57, 57, 1),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (broadcastController
                                                .favouritePosters
                                                .contains(broadcastController
                                                    .posterList
                                                    .value[index]['_id'])) {
                                              broadcastController
                                                  .favouritePosters
                                                  .remove(broadcastController
                                                      .posterList
                                                      .value[index]['_id']);

                                              await box.put(
                                                  'favPosters',
                                                  broadcastController
                                                      .favouritePosters.value);
                                            } else {
                                              broadcastController
                                                  .favouritePosters
                                                  .add(broadcastController
                                                      .posterList
                                                      .value[index]['_id']);

                                              await box.put(
                                                  'favPosters',
                                                  broadcastController
                                                      .favouritePosters.value);
                                            }
                                            setState(() {
                                              broadcastController
                                                  .initializePrefs();
                                            });
                                          },
                                          child: Icon(
                                            broadcastController.favouritePosters
                                                    .contains(
                                                        broadcastController
                                                                .posterList
                                                                .value[index]
                                                            ['_id'])
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 24,
                                            color: broadcastController
                                                    .favouritePosters
                                                    .contains(
                                                        broadcastController
                                                                .posterList
                                                                .value[index]
                                                            ['_id'])
                                                ? Colors.amber
                                                : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget OtherTabsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          height: 250,
          width: 250,
          image: AssetImage('assets/mycases/mycasesfall.png'),
        ),
        Text(
          SharedPreferencesHelper.getUserId() == ''
              ? 'Login first to see posters'
              : 'No posters Found',
          style: const TextStyle(
            color: Color.fromRGBO(126, 126, 126, 1),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            // =======
            //         child: SingleChildScrollView(
            //           physics: const BouncingScrollPhysics(),
            //           child: Container(
            //             height: size.height,
            //             width: size.width,
            //             padding: const EdgeInsets.only(
            //                 left: 15, right: 15, top: 20, bottom: 150),
            //             child: isLoading
            //                 ? Center(
            //                     child: CircularProgressIndicator(
            //                       color: MyColors.blue,
            //                     ),
            //                   )
            //                 : posterList.isEmpty
            //                     ? Column(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           SizedBox(height: size.height * 0.105),
            //                           const Image(
            //                             height: 250,
            //                             width: 250,
            //                             image: AssetImage('assets/mycases/mycasesfall.png'),
            //                           ),
            //                           Text(
            //                             SharedPreferencesHelper.getUserId() == ''
            //                                 ? 'Login first to see posters'
            //                                 : 'No posters Found',
            //                             style: const TextStyle(
            //                               color: Color.fromRGBO(126, 126, 126, 1),
            //                               fontSize: 14,
            //                               fontWeight: FontWeight.w700,
            //                             ),
            // >>>>>>> arjun
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class TextEditorDialog extends StatefulWidget {
  String imageUrl;
  String text;
  TextEditorDialog({super.key, required this.imageUrl, required this.text});

  @override
  State<TextEditorDialog> createState() => _TextEditorDialogState();
}

class _TextEditorDialogState extends State<TextEditorDialog> {
  TextEditingController textEditingController = TextEditingController();
  bool isSendTap = false;
  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text;
  }

  Future<void> _shareImageAndText(imageUrl, message) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.jpg').create();
    await file.writeAsBytes(bytes);
    await Share.shareFiles(
      [file.path],
      text: '$message',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 370,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 80,
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    color: MyColors.blue,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLines: 30,
                controller: textEditingController,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                scrollPadding: const EdgeInsets.all(10),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: InputBorder.none,
                  hintText: 'Enter your text',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: GestureDetector(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.blue,
                    disabledBackgroundColor: MyColors.blue,
                    minimumSize: const Size(100, 35),
                    maximumSize: const Size(100, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isSendTap
                      ? null
                      : () async {
                          setState(() {
                            isSendTap = true;
                          });
                          _shareImageAndText(
                            widget.imageUrl,
                            textEditingController.text,
                          );
                          await Future.delayed(const Duration(seconds: 3)).then(
                            (value) {
                              setState(() {
                                isSendTap = false;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                  child: isSendTap
                      ? const Align(
                          alignment: Alignment.center,
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : const Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito',
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

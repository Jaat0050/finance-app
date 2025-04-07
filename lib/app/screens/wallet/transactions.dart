import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitra_fintech_agent/app/services/api_value.dart';
import 'package:mitra_fintech_agent/app/utils/constants.dart';

class TransacrtionsScreen extends StatefulWidget {
  const TransacrtionsScreen({super.key});

  @override
  State<TransacrtionsScreen> createState() => _TransacrtionsScreenState();
}

class _TransacrtionsScreenState extends State<TransacrtionsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  bool transactionsLoading = false;

  List<dynamic> transactions = [];
  List<dynamic> withdrawalReq = [];

  Future<void> _fetchTransactions() async {
    var withdrawalReqData = await apiValue.fetchWithdrawalRequest();
    if (withdrawalReqData != null) {
      setState(() {
        withdrawalReq = withdrawalReqData.reversed.toList();
        transactionsLoading = false;
      });
    } else {
      setState(() {
        transactionsLoading = false;
      });
    }

    var transactionData = await apiValue.getAllTransaction();
    if (transactionData != null) {
      setState(() {
        transactions = transactionData.reversed.toList();
        transactionsLoading = false;
      });
    } else {
      setState(() {
        transactionsLoading = false;
      });
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _fetchTransactions();
    super.initState();
    setState(() {
      transactionsLoading = true;
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
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
        title: Text(
          'My Transcations',
          style: TextStyle(
            color: MyColors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
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
          _fetchTransactions();
          await Future.delayed(
            const Duration(seconds: 1),
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //-----------------------------tab container--------------------------------//
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //===============================tabs--------------------------------------//
                      transactions.isEmpty && withdrawalReq.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              width: size.width,
                              height: size.height * 0.052,
                              // padding:
                              //     const EdgeInsets.symmetric(horizontal: 20),
                              child: TabBar(
                                controller: tabController,
                                // physics: const BouncingScrollPhysics(),
                                labelColor: MyColors.white,
                                unselectedLabelColor:
                                    const Color.fromRGBO(0, 0, 0, 0.4),
                                indicatorSize: TabBarIndicatorSize.label,
                                isScrollable: true,
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                indicator: BoxDecoration(
                                  color: MyColors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(142, 142, 142, 0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                ),
                                dividerColor: Colors.white,
                                tabs: [
                                  tabContainerBuilder('Withdrawal Request'),
                                  tabContainerBuilder('Withdrawals'),
                                  tabContainerBuilder('Earnings'),
                                ],
                              ),
                            ),

                      const SizedBox(height: 20),
                      transactions.isEmpty && withdrawalReq.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 1,
                              color: Colors.grey,
                            ),

                      Expanded(
                        child: transactions.isEmpty && withdrawalReq.isEmpty
                            ? transactionsLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: MyColors.blue,
                                    ),
                                  )
                                : otherTabsContent()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                child: TabBarView(
                                  controller: tabController,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    allTabContent(withdrawalReq),
                                    allTabContent(transactions
                                        .where((element) =>
                                            element['type'] == 'debit')
                                        .toList()),
                                    allTabContent(transactions
                                        .where((element) =>
                                            element['type'] == 'credit')
                                        .toList()),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allTabContent(List transactionList) {
    Size size = MediaQuery.of(context).size;
    return transactionList.isEmpty
        ? otherTabsContent()
        : Container(
            padding: const EdgeInsets.only(top: 10),
            color: MyColors.dullWhite,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionList.length,
              itemBuilder: (context, index) {
                var transaction = transactionList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.13,
                        child: CircleAvatar(
                          radius: size.width * 0.06,
                          backgroundColor: const Color(0xffE4E4E4),
                          child: ClipOval(
                            child: Image(
                              image: transaction['type'] == 'credit'
                                  ? const AssetImage(
                                      "assets/wallet/receive.png")
                                  : transaction['type'] == 'debit'
                                      ? const AssetImage(
                                          "assets/wallet/send.png")
                                      : transaction['status'] == 'processed'
                                          ? const AssetImage(
                                              "assets/wallet/send.png")
                                          : transaction['status'] == 'failed'
                                              ? const AssetImage(
                                                  "assets/mycases/rejected.png")
                                              : const AssetImage(
                                                  "assets/wallet/pending.png"),
                              width: size.width * 0.06,
                              height: size.height * 0.06,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['type'] == 'credit'
                                  ? 'Commission Earned'
                                  : transaction['type'] == 'debit'
                                      ? 'Commission Withdrawn'
                                      : transaction['type'] == 'pending'
                                          ? 'In Process'
                                          : transaction['status'] == 'pending'
                                              ? 'Withdrawal requested'
                                              : transaction['status'] ==
                                                      'processed'
                                                  ? 'Withdrawal processed'
                                                  : 'Withdrawal declined',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: transaction['type'] == 'credit'
                                      ? transaction['type'] == 'pending'
                                          ? Colors.grey
                                          : MyColors.blue
                                      : transaction['type'] == 'pending'
                                          ? const Color.fromRGBO(0, 0, 0, 0.6)
                                          : transaction['status'] == 'pending'
                                              ? const Color.fromRGBO(
                                                  0, 0, 0, 0.6)
                                              : transaction['status'] ==
                                                      'failed'
                                                  ? const Color.fromRGBO(
                                                      255, 114, 94, 1)
                                                  : transaction['status'] ==
                                                          'processed'
                                                      ? Colors.green
                                                      : const Color.fromRGBO(
                                                          255, 114, 94, 1),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              formatDate(
                                  DateTime.parse(transaction['updatedAt'])),
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: const Color.fromRGBO(132, 132, 132, 1),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${transaction['type'] == 'credit' || transaction['type'] == 'debit' ? '+' : transaction['type'] == 'upi' ? '-' : '+'} ₹${transaction['amount'].toString()}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  color: transaction['type'] == 'credit'
                                      ? transaction['type'] == 'pending'
                                          ? Colors.grey
                                          : MyColors.blue
                                      : transaction['type'] == 'pending'
                                          ? const Color.fromRGBO(0, 0, 0, 0.6)
                                          : transaction['status'] == 'pending'
                                              ? const Color.fromRGBO(
                                                  0, 0, 0, 0.6)
                                              : transaction['status'] ==
                                                      'failed'
                                                  ? const Color.fromRGBO(
                                                      255, 114, 94, 1)
                                                  : transaction['status'] ==
                                                          'processed'
                                                      ? Colors.green
                                                      : const Color.fromRGBO(
                                                          255, 114, 94, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  Widget otherTabsContent() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.16),
          const Image(
            height: 250,
            image: AssetImage('assets/mycases/mycasesfall.png'),
            fit: BoxFit.contain,
          ),
          const Text(
            'No transaction found',
            style: TextStyle(
              color: Color.fromRGBO(126, 126, 126, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget tabContainerBuilder(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MyColors.blue,
            width: 1,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${_monthName(date.month)} ${date.day} ${date.year}, at ${date.hour}:${date.minute}';
  }

  String _monthName(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return monthNames[month - 1];
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:mitra_fintech_agent/app/screens/wallet/withdraw.dart';

// import '../../api/api_value.dart';
// import '../../utils/commission_controller.dart';
// import '../../utils/constants.dart';

// // ignore: must_be_immutable
// class Wallet extends StatefulWidget {
//   int tabIndex;
//   Wallet({required this.tabIndex, super.key});

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> with SingleTickerProviderStateMixin {
//   TabController? tabController;
//   late CommissionController commissionController;

//   List<dynamic> transactions = [];

//   Future<void> _fetchTransactions() async {
//     commissionController = Get.put(CommissionController());
//     initializePrefs();
//     var transactionData = await apiValue.getAllTransaction();
//     if (transactionData != null) {
//       setState(() {
//         transactions = transactionData.reversed.toList();
//       });
//     }
//   }

//   Future<void> initializePrefs() async {
//     await Future.wait([
//       commissionController.getCommissionDetails(),
//     ]);

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     commissionController = Get.put(CommissionController());
//     initializePrefs();

//     tabController =
//         TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);
//     _fetchTransactions();
//     // _fetchCommission();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: MyColors.dullWhite,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         title: Text(
//           'My Wallet',
//           style: TextStyle(
//             color: MyColors.black,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: MyColors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: RefreshIndicator(
//         color: MyColors.blue,
//         onRefresh: () async {
//           _fetchTransactions();
//           await Future.delayed(
//             Duration(seconds: 1),
//           );
//         },
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Container(
//             height: size.height,
//             width: size.width,
//             padding: EdgeInsets.only(top: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //-----------------------------------commission container---------------------------//
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   width: size.width * 0.85,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: MyGradients.linearGradient,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Total Commission Earned",
//                         style: TextStyle(
//                             color: MyColors.white, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.009,
//                       ),
//                       Text(
//                         '₹${NumberFormat('#,##,###').format(
//                           int.parse(
//                             commissionController.commissionAmount.value,
//                           ),
//                         )}',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: MyColors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.02,
//                       ),
//                       ElevatedButton(
//                         onPressed: NumberFormat('#,##,###').format(
//                                   int.parse(
//                                     commissionController.commissionAmount.value,
//                                   ),
//                                 ) !=
//                                 0
//                             ? null
//                             : () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Withdraw(tabIndex: 1)));
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           onPrimary: MyColors.white,
//                           disabledBackgroundColor: Colors.white,
//                           minimumSize: Size(size.width * 0.4, 40),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           "Withdraw",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: MyColors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.036),
//                 //-----------------------------tab container--------------------------------//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Text(
//                           "My Transactions",
//                           style: GoogleFonts.nunito(
//                             textStyle: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                               color: Color.fromRGBO(0, 0, 0, 1),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       //===============================tabs--------------------------------------//
//                       Container(
//                         width: size.width,
//                         height: size.height * 0.045,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Container(
//                           child: TabBar(
//                             controller: tabController,
//                             physics: NeverScrollableScrollPhysics(),
//                             labelColor: MyColors.white,
//                             unselectedLabelColor:
//                                 const Color.fromRGBO(0, 0, 0, 0.4),
//                             indicatorSize: TabBarIndicatorSize.label,
//                             labelPadding: EdgeInsets.all(0),
//                             indicator: BoxDecoration(
//                               color: MyColors.blue,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Color.fromRGBO(142, 142, 142, 0.5),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             labelStyle: GoogleFonts.nunito(
//                               textStyle: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14,
//                                 color: Color.fromRGBO(0, 0, 0, 0.4),
//                               ),
//                             ),
//                             dividerColor: Colors.white,
//                             tabs: [
//                               Tab(
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 6, horizontal: 25),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: MyColors.blue,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: const Text('All'),
//                                 ),
//                               ),
//                               Tab(
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 6, horizontal: 25),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: MyColors.blue,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: const Text('Withdrawal'),
//                                 ),
//                               ),
//                               Tab(
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 6, horizontal: 25),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                       color: MyColors.blue,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: const Text('Earnings'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 20),
//                       Container(
//                         width: size.width,
//                         margin: const EdgeInsets.symmetric(horizontal: 15),
//                         height: 1,
//                         color: Colors.grey,
//                       ),

//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 20, right: 20, top: 8),
//                           child: TabBarView(
//                             controller: tabController,
//                             physics: BouncingScrollPhysics(),
//                             children: [
//                               TransactionsView(
//                                 transactions: transactions,
//                                 transactionType: TransactionType.all,
//                               ),
//                               TransactionsView(
//                                 transactions: transactions,
//                                 transactionType: TransactionType.debit,
//                               ),
//                               TransactionsView(
//                                 transactions: transactions,
//                                 transactionType: TransactionType.credit,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum TransactionType { all, debit, credit }

// class TransactionsView extends StatefulWidget {
//   final List<dynamic> transactions;
//   final TransactionType transactionType;

//   const TransactionsView({
//     required this.transactions,
//     required this.transactionType,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TransactionsView> createState() => _TransactionsViewState();
// }

// class _TransactionsViewState extends State<TransactionsView> {
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> transactions = widget.transactions;
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         // height: size.height * 0.4,
//         color: MyColors.dullWhite,
//         child: transactions.isEmpty
//             ? isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(
//                       color: MyColors.blue,
//                     ),
//                   )
//                 : Padding(
//                     padding: EdgeInsets.only(top: size.height * 0.06),
//                     child: Image(
//                       image: AssetImage('assets/mycases/transfall.png'),
//                       width: size.width,
//                       height: 250,
//                       fit: BoxFit.contain,
//                     ),
//                   )
//             : ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   var transaction = transactions[index];
//                   if (widget.transactionType == TransactionType.all ||
//                       (widget.transactionType == TransactionType.debit &&
//                           transaction['type'] == 'debit') ||
//                       (widget.transactionType == TransactionType.credit &&
//                           transaction['type'] == 'credit')) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             width: size.width * 0.13,
//                             child: CircleAvatar(
//                               radius: size.width * 0.06,
//                               backgroundColor: const Color(0xffE4E4E4),
//                               child: ClipOval(
//                                 child: Image(
//                                   image: transaction['type'] == 'credit'
//                                       ? AssetImage("assets/wallet/receive.png")
//                                       : transaction['type'] == 'debit'
//                                           ? AssetImage("assets/wallet/send.png")
//                                           : transaction['type'] == 'pending'
//                                               ? AssetImage(
//                                                   "assets/wallet/pending.png")
//                                               : AssetImage(
//                                                   "assets/wallet/pending.png"),
//                                   width: size.width * 0.032,
//                                   height: size.height * 0.032,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Container(
//                             width: size.width * 0.5,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   transaction['type'] == 'credit'
//                                       ? 'Commission Received'
//                                       : transaction['type'] == 'debit'
//                                           ? 'Amount Withdrawn'
//                                           : transaction['type'] == 'pending'
//                                               ? 'In Process'
//                                               : 'Request Declined',
//                                   style: GoogleFonts.nunito(
//                                     textStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 3),
//                                 Text(
//                                   formatDate(
//                                     DateTime.parse(transaction['createdAt']),
//                                   ),
//                                   style: GoogleFonts.nunito(
//                                     textStyle: TextStyle(
//                                       color: Color.fromRGBO(132, 132, 132, 1),
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: size.width * 0.2,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   '${transaction['type'] == 'credit' ? '+' : '-'} ₹${transaction['amount'].toString()}',
//                                   textAlign: TextAlign.right,
//                                   style: GoogleFonts.nunito(
//                                     textStyle: TextStyle(
//                                       color: transaction['type'] == 'credit'
//                                           ? transaction['type'] == 'pending'
//                                               ? Colors.grey
//                                               : MyColors.blue
//                                           : transaction['type'] == 'pending'
//                                               ? Color.fromRGBO(0, 0, 0, 0.2)
//                                               : Color.fromRGBO(255, 114, 94, 1),
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return SizedBox();
//                   }
//                 },
//               ),
//       ),
//     );
//   }
// }

// String _monthName(int month) {
//   const monthNames = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Aug",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ];
//   return monthNames[month - 1];
// }

// String formatDate(DateTime date) {
//   return '${_monthName(date.month)} ${date.day} ${date.year}, at ${date.hour}:${date.minute}';
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/enums.dart';
import 'package:money2me/src/dashboard/screens/loan_details/interest_payment.dart';
import 'package:money2me/src/dashboard/screens/loan_details/loan_closer.dart';

class LoanDetailsScreen extends StatefulWidget {
  final bool showButton;
  final int loanId;
  const LoanDetailsScreen({super.key, required this.loanId,required this.showButton});

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen>
    with TickerProviderStateMixin {
  late List<Widget> _body;
  @override
  void initState() {
    _body = [
      InterestPayment(
        showButton: widget.showButton,
        receiptType: ReceiptType.interestPayment,
        loanId: widget.loanId.toString(),
      ),
      LoanCloser(
        showButton: widget.showButton,
        receiptType: ReceiptType.loanCloser,
        loanId: widget.loanId.toString(),
      ),
    ];
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                elevation: 0,
                centerTitle: true,
                title: const Text("Loan Information"),
                flexibleSpace: Container(
                  height: 120.h,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: const Image(
                    // height: 60.h,
                    image: AssetImage('assets/images/app_transparent_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(color: kWhiteColor, boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 2,
                  )
                ]),
                margin: const EdgeInsets.symmetric(horizontal: 20).r,
                child: TabBar(
                  labelColor: kBlackColor,
                  labelStyle:Theme.of(context).textTheme.titleMedium,
                  indicatorColor: kPrimaryColor,
                  tabs: [
                    Tab(
                      text: "Interest Payment",
                      height: 40.h,
                    ),
                    Tab(
                      text: "Loan Closer",
                      height: 40.h,
                    ),
                  ],
                  onTap: (index) {
                    setState(() {});
                  },
                  controller: controller,
                ),
              ),
            )
          ],
        ),
      ),
      body: _body[controller!.index],
    );
  }
}


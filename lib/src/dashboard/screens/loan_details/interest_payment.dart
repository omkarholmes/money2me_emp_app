import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/enums.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/dashboard/controller/loan_details_controller.dart';
import 'package:money2me/src/dashboard/controller/payment_controller.dart';
import 'package:money2me/src/dashboard/models/loan_detail_request.dart';
import 'package:money2me/src/dashboard/models/loan_details.dart';
import 'package:money2me/src/dashboard/screens/loan_details/payment.dart';
import 'package:money2me/src/razorpay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class InterestPayment extends ConsumerStatefulWidget {
  final String loanId;
  final bool showButton;
  final ReceiptType receiptType;
  final LoanDetailRequest loanDetailRequest = LoanDetailRequest();

  InterestPayment(
      {super.key,
      required this.receiptType,
      required this.loanId,
      required this.showButton}) {
    loanDetailRequest.receiptType = receiptType;
    loanDetailRequest.loanId = loanId;
  }

  @override
  ConsumerState createState() => InterestPaymentState();
}

class InterestPaymentState extends ConsumerState<InterestPayment> {
  bool isPaymentLoading = false;
  late double amount = 0;
  late String orderId;
  LoanDetails? loanDetails;
  LoanRepayProvider loanRepayProvider = LoanRepayProvider();
  RazorpayIntegration razorpayIntegration = RazorpayIntegration();

  @override
  void initState() {
    razorpayIntegration.initiateRazorPay(
        _handlePaymentSuccess, _handlePaymentError, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    PaymentController paymentController = PaymentController();
    DateTime transTime = DateTime.now();
    paymentController
        .postPayment(
            loanDetails: loanDetails!,
            amount: amount,
            receiptType: widget.receiptType,
            transTime: transTime,
            status: 'S',
            transId: orderId)
        .then((value) {
      setState(() {
        isPaymentLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            amount: amount,
            transId: response.orderId!,
            transTime: transTime,
            loanNo: loanDetails!.loanNo,
          ),
        ),
      );
    }).catchError((onError) {
      setState(() {
        isPaymentLoading = false;
      });
      if (kDebugMode) {
        print(onError);
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
    print(response.code);
    print(response.error);

    setState(() {
      isPaymentLoading = false;
    });
    PaymentController paymentController = PaymentController();
    DateTime transTime = DateTime.now();
    paymentController.postPayment(
        loanDetails: loanDetails!,
        amount: amount,
        receiptType: widget.receiptType,
        transTime: transTime,
        status: 'F',
        transId: orderId);
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "Payment Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kPrimaryColor,
        textColor: kWhiteColor,
        fontSize: 16.0.sp);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: ref.watch(interestPaymentProvider(widget.loanDetailRequest)).when(
            data: (data) {
      loanDetails = data.data;
      return isPaymentLoading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 32).r,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: kWhiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                          blurRadius: 2,
                        )
                      ]),
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: kBlackColor))),
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14)
                          .r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Loan Number",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(data.data!.loanNo,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kBlackColor)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: kBlackColor, width: 0.5))),
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14)
                          .r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Balance Principle",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(data.data!.balancePrinciple.toStringAsFixed(2),
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kBlackColor)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: kBlackColor, width: 0.5))),
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14)
                          .r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Interest and Other Charges",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                              (data.data!.delayCharge +
                                      data.data!.noticeCharges)
                                  .toStringAsFixed(2),
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kBlackColor)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: kBlackColor, width: 0.5))),
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14)
                          .r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No of days",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text("${data.data!.noOfDays}",
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kBlackColor)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14)
                          .r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pay",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text("${data.data!.totalPay}",
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kBlackColor)),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text('Transaction',
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(
                  height: 16.h,
                ),
                Consumer(builder: (context, ref, child) {
                  return ref
                      .watch(transactionProvider(
                          widget.loanDetailRequest.loanId.toString()))
                      .when(data: (data) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10).r,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kWhiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                  )
                                ]),
                            child: ExpansionTile(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: kLightGrey),
                                    borderRadius: BorderRadius.circular(6)),
                                tilePadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 14)
                                    .r,
                                childrenPadding:
                                    const EdgeInsets.fromLTRB(14, 0, 14, 12).r,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.data![index].voucherNo,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(data.data![index].voucherDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text(
                                        'Disbursed amount: ${data.data![index].balancePriniple.toStringAsFixed(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Principle:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                          data.data![index].priniciple
                                              .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Interest Amount:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                          data.data![index].interestAmount
                                              .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Delay Amount:",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //     Text(
                                  //         data.data![index].dealyAmount
                                  //             .toStringAsFixed(2),
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.w400)),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Legal Charges:",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //     Text(
                                  //         data.data![index].legalCharge
                                  //             .toStringAsFixed(2),
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.w400)),
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pre. Unpaid Amount:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                          data.data![index].prevunpaidAmount
                                              .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Notice Charges:",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //     Text(
                                  //         data.data![index].noticeCharges
                                  //             .toStringAsFixed(2),
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.w400)),
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "No of Days:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text("${data.data![index].noOfDays}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "ROI:",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //     Text(
                                  //         data.data![index].roi
                                  //             .toStringAsFixed(2),
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.w400)),
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Balance  Principle:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                          data.data![index].balancePriniple
                                              .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500)),
                                    ],
                                  )
                                ]));
                      },
                    );
                  }, error: (error, stacktrace) {
                    if (kDebugMode) {
                      print(error);
                      print(stacktrace);
                    }
                    return Container();
                  }, loading: () {
                    return Container();
                  });
                }),
                SizedBox(
                  height: 16.h,
                ),
                widget.showButton
                    ? KTextButton(
                        onPressed: () {
                          paymentSheet(data.data!.totalPay);
                        },
                        text: 'Proceed')
                    : Container()
              ],
            );
    }, error: (error, stacktrace) {
      if (kDebugMode) {
        print(error);
      }
      return Container();
    }, loading: () {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }));
  }

  @override
  void dispose() {
    razorpayIntegration.dispose();
    super.dispose();
  }

  paymentSheet(double totalPay) {
    bool isLoading = false;
    bool isAuctionActive = true;
    amount = totalPay;
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        elevation: 10,
        barrierColor: Colors.black12,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 200.h + MediaQuery.of(context).viewInsets.bottom,
              padding: const EdgeInsets.only(
                      top: 16, right: 16, left: 16, bottom: 10)
                  .r,
              decoration: const BoxDecoration(
                color: kWhiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Payment"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Enter the amount you wish to repay and tap on. Proceed to pay button",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: kBlackColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        enabled: !isLoading,
                        initialValue: totalPay.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: Theme.of(context).textTheme.labelLarge,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12)
                              .r,
                          label: Text(
                            "Amount",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          focusColor: kSecondaryColor,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            amount = 0;
                          } else {
                            amount = double.parse(value);
                          }
                          setState() {}
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            if (mounted) {
                              if (amount < 1) {
                                DialogHelper.showAlert(context, "",
                                    "Amount should be greater than 1.00", () {
                                  Navigator.pop(context);
                                });
                                return;
                              }
                              if (isLoading) {
                                return;
                              }
                              setState(() {
                                isLoading = true;
                              });

                              await loanRepayProvider
                                  .checkAuction(loanDetails!.loanNo)
                                  .then((value) {
                                isAuctionActive = true;
                              }).catchError((onError) {
                                isAuctionActive = false;
                              });

                              if (isAuctionActive) {
                                setState(() {
                                  isLoading = false;
                                });

                                DialogHelper.showAlert(
                                    context,
                                    "",
                                    "You will not be able to do the transaction, "
                                        "since the Loan is in Auction. "
                                        "Kindly contact to concern Branch.",
                                    () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              } else {
                                loanRepayProvider
                                    .checkLimit(widget.loanDetailRequest)
                                    .whenComplete(() {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }).then(
                                  (value) {
                                    if (amount > value.data!.todaysLimit) {
                                      DialogHelper.showAlert(
                                        context,
                                        "",
                                        "Your Today's Pending Limit is ${value.data!.todaysLimit.toStringAsFixed(2)}",
                                        () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    } else {
                                      setState(
                                        () {
                                          isPaymentLoading = true;
                                        },
                                      );
                                      Navigator.pop(context);
                                      razorpayIntegration.createOrder(
                                        loanId: "${loanDetails?.loanId ?? ""}",
                                        loanNumber: loanDetails?.loanNo ?? "",
                                        amount: amount,
                                        onComplete: (String orderId) {
                                          this.orderId = orderId;
                                        },
                                      );
                                    }
                                  },
                                ).catchError(
                                  (error) {
                                    if (error is AppException) {
                                      DialogHelper.showAlert(
                                          context, "", error.message.toString(),
                                          () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                );
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: kWhiteColor,
                            backgroundColor: kPrimaryColor,
                            fixedSize: Size(200.w, 36.h),
                            shape: const ContinuousRectangleBorder(),
                          ),
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Please wait...",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      // height: 36.h,
                                      width: 10.h,
                                      height: 10.h,
                                      child: const CircularProgressIndicator(
                                        color: kWhiteColor,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "PROCEED TO PAY",
                                ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}

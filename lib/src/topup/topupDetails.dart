import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/dashboard/controller/home_controller.dart';
import 'package:money2me/src/dashboard/dashboard.dart';
import 'package:money2me/src/new_loan/controller/new_loan.dart';
import 'package:money2me/src/topup/models/SchemeWiseRepledge.dart';
import 'package:money2me/src/topup/models/topup_request.dart';
import 'package:money2me/src/topup/topup_controller.dart';

class TopupDetailsPage extends StatefulWidget {
  TopupRequest topupRequest;
  TopupDetailsPage({super.key, required this.topupRequest});

  @override
  State<TopupDetailsPage> createState() => _TopupDetailsPageState();
}

class _TopupDetailsPageState extends State<TopupDetailsPage> {
  bool isPaymentLoading = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: kWhiteColor),
          backgroundColor: kPrimaryColor,
          title: Text(
            "Topup Details",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kWhiteColor),
          )),
      body: Consumer(builder: (context, ref, child) {
        return ref
            .watch(topUpDetailsProvider(widget.topupRequest.loanId!))
            .when(data: (data) {
          return ListView.builder(
              padding: const EdgeInsets.all(16).r,
              itemCount: data.data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.topupRequest.schemeId =
                        data.data![index].schemeId.toString();
                    TopupController topupController = TopupController();
                    topupController
                        .requestTopup(widget.topupRequest)
                        .then((value) => print(value))
                        .catchError((onError) => print(onError));
                    showRequestSheet(data.data![index]);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                            .r,
                    margin: const EdgeInsets.symmetric(vertical: 8).r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhiteColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 2,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data.data![index].schemeName}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: kPrimaryColor),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Maximum Loan",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0).r,
                                        child: Text(
                                            "${data.data![index].maxLoan}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Loan Amt Eligible",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text(
                                          "${data.data![index].loanAmtEligible}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Existing Settlement",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0).r,
                                        child: Text(
                                            "${data.data![index].existingLoanSettlement}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Final DisAmt",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text("${data.data![index].finalDisAmt}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Days",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0).r,
                                        child: Text("${data.data![index].days}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Repledge",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text("${data.data![index].repledge}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Rate",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0).r,
                                        child: Text("${data.data![index].rate}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Rate per gram",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text("${data.data![index].ratePerGram}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }, error: (error, stacktrace) {
          return Container();
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      }),
    );
  }

  showRequestSheet(SchemeWiseRepledge schemeWiseRepledge) {
    int amount = 0;
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        elevation: 10,
        barrierColor: Colors.black12,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Container(
                height: 250.h + MediaQuery.of(context).viewInsets.bottom,
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
                    const Text("Request Top-up"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Enter the amount you wish to Top-up and tap on. Proceed to pay button",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: kBlackColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d*')),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                          amount = int.parse(value);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return ref.watch(consentProvider).when(
                        data: (data) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: isChecked,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    return kPrimaryColor;
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  }),
                              SizedBox(width: 4.w),
                              SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.75,
                                  child: Text(
                                    data.data?.consentDesc ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ))
                            ],
                          );
                        },
                        error: (error, stacktrace) {
                          print(error);
                          return Container();
                        },
                        loading: () {
                          return Container();
                        },
                      );
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Consumer(builder: (context, ref, child) {
                        return TextButton(
                            onPressed: isChecked
                                ? () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (amount < 1) {
                                      DialogHelper.showAlert(context, "",
                                          "Amount can't be less than 1.00", () {
                                        Navigator.pop(context);
                                      });
                                    } else if ((schemeWiseRepledge.repledge ??
                                            0) <
                                        amount) {
                                      DialogHelper.showAlert(context, "",
                                          "The Repledge amount is ${schemeWiseRepledge.repledge?.toStringAsFixed(2) ?? 0.00}",
                                          () {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      widget.topupRequest.amt =
                                          amount.toString();
                                      TopupController topupController =
                                          TopupController();
                                      DialogHelper.showLoadingIndicator(
                                          context);
                                      topupController
                                          .requestTopup(widget.topupRequest)
                                          .then((value) {
                                        DialogHelper.hide(context);
                                        DialogHelper.showAlert(
                                            context,
                                            "Success",
                                            "Top-up requested successfully",
                                            () {
                                          ref.refresh(topUpAlertProvider);
                                          Navigator.popUntil(context,
                                              ModalRoute.withName("/home"));
                                        });
                                      }).catchError((onError) {
                                        DialogHelper.hide(context);
                                        if (onError is AppException) {
                                          DialogHelper.showAlert(
                                              context,
                                              "Error",
                                              onError.message ?? "", () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        }

                                        print(onError);
                                      });
                                    }
                                  }
                                : () {},
                            style: TextButton.styleFrom(
                              foregroundColor: kWhiteColor,
                              backgroundColor:
                                  isChecked ? kPrimaryColor : kGreyColor,
                              fixedSize: Size(200.w, 36.h),
                              shape: const ContinuousRectangleBorder(),
                            ),
                            child: const Text(
                              "Request",
                            ));
                      }),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}

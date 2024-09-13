import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/my_loan_controller.dart';
import 'package:money2me/src/dashboard/models/ornament.dart';
import 'package:money2me/src/dashboard/screens/loan_details/loan_details.dart';

class MyLoanScreen extends StatefulWidget {
  const MyLoanScreen({
    super.key,
  });

  @override
  State<MyLoanScreen> createState() => _MyLoanScreenState();
}

class _MyLoanScreenState extends State<MyLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "My Loan",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: kWhiteColor),
        ),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(loanProvider(sharedPref.getInt(SharedPref.partyIdKey)))
              .when(data: (value) {
            return ListView.builder(
              itemCount: value.data!.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 16).r,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanDetailsScreen(
                                  loanId: value.data![index].loanId,
                                  showButton: false,
                                )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 6).r,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8)
                            .r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: kShadowColor,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 2,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.data![index].schemeName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: kPrimaryColor),
                        ),
                        Text(
                          "No: ${value.data![index].loanNo}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kBlackColor),
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(value.data![index].loanDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kMidGrey),
                        ),
                        Text(
                          "Due Date ${DateFormat.yMMMd().format(value.data![index].loanDueDate)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kRedColor),
                        ),
                        Text(
                          "Loan amount is ${value.data![index].loanAmount.toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kBlackColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: value.data![index].forPartRelease
                                  ? InkWell(
                                      onTap: () {
                                        _partRelease(
                                          context,
                                          value.data![index].loanId,
                                        );
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                              child: Text(
                                            "Part Release",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: value.data![index].forCloser
                                  ? Container(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Text(
                                            "Loan Closer",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }, error: (error, stacktrace) {
            if (kDebugMode) {
              print(error);
              print(stacktrace);
            }
            return Container();
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        },
      ),
    );
  }

  _partRelease(context, loanId) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(15),
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(ornamentProvider(loanId)).when(data: (value) {
                  List<Ornament> selectedOrnaments = [];
                  return StatefulBuilder(
                    builder: (context, updateState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Select Items For Part Release :",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.data!.length,
                            padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16)
                                .r,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedOrnaments
                                      .where((element) =>
                                          element.cAMItemID ==
                                          value.data![index].cAMItemID)
                                      .length >
                                  0;
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? selectedOrnaments.removeWhere(
                                          (element) =>
                                              element.cAMItemID ==
                                              value.data![index].cAMItemID,
                                        )
                                      : selectedOrnaments
                                          .add(value.data![index]);
                                  updateState(() {});
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6).r,
                                  padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 8)
                                      .r,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: kShadowColor,
                                          offset: const Offset(0, 0),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${value.data![index].itemName} : (${value.data![index].itemID})",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "No. Of Items : ${value.data![index].noOfItems.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: kBlackColor),
                                            ),
                                            Text(
                                              "Cam Id : ${value.data![index].cAMID.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: kBlackColor),
                                            ),
                                            Text(
                                              "Cam Item Id : ${value.data![index].cAMID.toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: kBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isSelected
                                          ? Icon(
                                              Icons.check_box,
                                              color: kPrimaryColor,
                                            )
                                          : Icon(
                                              Icons.check_box_outline_blank,
                                              color: kGreyColor,
                                            )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Proceed with ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "${selectedOrnaments.length} items",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }, error: (error, stacktrace) {
                  if (kDebugMode) {
                    print(error);
                    print(stacktrace);
                  }
                  return Container();
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
              },
            ),
          );
        });
  }
}

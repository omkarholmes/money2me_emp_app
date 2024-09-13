import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/enums.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/src/dashboard/controller/loan_details_controller.dart';
import 'package:money2me/src/dashboard/controller/statementController.dart';
import 'package:money2me/src/dashboard/models/loan_detail_request.dart';
import 'package:url_launcher/url_launcher.dart';


class LoanStatementScreen extends StatefulWidget {
  final String loanId;
  const LoanStatementScreen({super.key,required this.loanId});

  @override
  State<LoanStatementScreen> createState() => _LoanStatementScreenState();
}

class _LoanStatementScreenState extends State<LoanStatementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300.h),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                centerTitle: true,
                title: const Text("Loan Statement"),
                flexibleSpace: Container(
                  height: 140.h,
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
              child: Consumer(
                builder: (context,ref,child) {
                  LoanDetailRequest loanDetailRequest = LoanDetailRequest();
                  loanDetailRequest.loanId = widget.loanId;
                  loanDetailRequest.receiptType = ReceiptType.interestPayment;
                  return ref.watch(interestPaymentProvider(loanDetailRequest)).when(data: (data){
                    return Container(
                      decoration: const BoxDecoration(color: kWhiteColor, boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                          blurRadius: 2,
                        )
                      ]),
                      margin: const EdgeInsets.symmetric(horizontal: 20).r,
                      child: Container(
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
                                Text(data.data!.tillDateInterestAmt.toStringAsFixed(2),
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
                                Text(data.data!.totalPay.toStringAsFixed(2),
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
                    );
                  }, error: (error,stacktrace){
                    if(kDebugMode){
                      print(error);
                      print(stacktrace);
                    }
                    return Container();

                  }, loading: (){
                    return Container();
                  });

                }
              ),
            )
          ],
        ),
      ),
      body: Consumer(
        builder: (context,ref,child) {
          return ref.watch(statementProvider(widget.loanId)).when(data: (data){
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Statement",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: kBlackColor, fontWeight: FontWeight.w600),
                      ),
                      TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: kWhiteColor,
                          ),
                          onPressed: () async {
                            try {
                              await launchUrl(
                                  Uri.parse(
                                    "${ApiConfig.downloadStatementUrl}${widget.loanId}",
                                  ),
                                  mode: LaunchMode.externalApplication);
                            } catch (onError) {
                              if(kDebugMode) {
                                print(onError);
                              }
                            }
                          },
                          icon:Icon(Icons.download,size: 14.sp,),
                          label: Text(
                            "Download",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium?.copyWith(color: kWhiteColor,fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.data?.length,
                      itemBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 2).r,
                            height: 100.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kWhiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                  )
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Row(children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4).r,
                                    alignment: Alignment.center,
                                    color: kLightGrey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(intl.DateFormat.d().format(data.data![index].receiptDate),
                                            textAlign:TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              color: kGreyColor,
                                              fontWeight: FontWeight.w600),
                                        ),  Text(intl.DateFormat.MMM().format(data.data![index].receiptDate),
                                            textAlign:TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              color: kGreyColor,
                                              fontWeight: FontWeight.w600),
                                        ),  Text(intl.DateFormat.y().format(data.data![index].receiptDate),
                                            textAlign:TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              color: kGreyColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 6, right: 6, left: 6)
                                              .r,
                                          padding: const EdgeInsets.only(bottom: 2).r,
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: kGreyColor, width: 0.5)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Principle Paid",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(color: kGreyColor),
                                              ),
                                              Text(
                                                data.data![index].principlepaid?.toStringAsFixed(2)??"",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: kGreyColor),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 6, right: 6, left: 6)
                                              .r,
                                          padding: const EdgeInsets.only(bottom: 2).r,
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: kGreyColor, width: 0.5)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Interest Paid",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(color: kGreyColor),
                                              ),
                                              Text(
                                                data.data![index].interestPaid?.toStringAsFixed(2)??"",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: kGreyColor),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 6, right: 6, left: 6)
                                              .r,
                                          padding: const EdgeInsets.only(bottom: 2).r,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Paid Days",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(color: kGreyColor),
                                              ),
                                              Text("${data.data![index].paidDays}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(color: kGreyColor),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0)
                                        .r,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.info_outline,
                                            size: 16.sp,
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Rs${data.data![index].totalPay?.toStringAsFixed(2)}",
                                              maxLines: 3,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                  color: kGreyColor,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ));
                      },
                    ),
                  )
                ],
              ),
            );
          }, error: (error,stacktrace){
            if(kDebugMode){
              print(error);
              print(stacktrace);
            }
            return Container();
          }, loading: (){
            return Container(alignment: Alignment.center,
              child: const CircularProgressIndicator(),);
          });

        }
      ),
    );
  }
}

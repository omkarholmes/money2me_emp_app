import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/controller/home_controller.dart';
import 'package:money2me/src/topup/models/topup_request.dart';
import 'package:money2me/src/topup/topupDetails.dart';
import 'package:money2me/src/topup/topup_controller.dart';

class TopupLoansPage extends StatefulWidget {
  TopupRequest topupRequest;
  TopupLoansPage({super.key, required this.topupRequest});

  @override
  State<TopupLoansPage> createState() => _TopupLoansPageState();
}

class _TopupLoansPageState extends State<TopupLoansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: kWhiteColor),
          backgroundColor: kPrimaryColor,
          title: Text(
            "Topup Loans",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kWhiteColor),
          )),
      body: Consumer(builder: (context, ref, child) {
        return ref.watch(topUpAlertProvider).when(data: (data) {
          return ListView.builder(
              padding: const EdgeInsets.all(16).r,
              itemCount: data.data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (!data.data![index].isProcessed!) {
                      widget.topupRequest.loanId =
                          data.data![index].loanId.toString();
                      TopupController topupController = TopupController();
                      topupController
                          .requestTopup(widget.topupRequest)
                          .then((value) {})
                          .catchError((onError) {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopupDetailsPage(
                                  topupRequest: widget.topupRequest)));
                    }
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
                        data.data![index].isProcessed ?? false
                            ? Text(
                                "${data.data![index].loanNo}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: kGreyColor),
                              )
                            : Text(
                                "${data.data![index].loanNo}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: kPrimaryColor),
                              ),
                        Text(
                            DateFormat.yMMMMd()
                                .format(data.data![index].loanDate),
                            style: Theme.of(context).textTheme.bodyMedium),
                        if (data.data![index].isProcessed!) ...[
                          Text("Topup request already applied.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: kRedColor)),
                        ],
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
}

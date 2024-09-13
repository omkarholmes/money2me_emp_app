import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/controller/home_controller.dart';

class RequestDetailPage extends StatefulWidget {
  const RequestDetailPage({super.key});

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Loan Request Details",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kWhiteColor),)
      ),
      body:    Consumer(builder: (context, ref, child) {
        return ref.watch(loanRequestDetailProvider).when(data: (data) {
        return Padding(
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: kLightGrey,
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kLightGrey)),
                padding: const EdgeInsets.symmetric(horizontal: 16).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16).r,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kGreyColor, width: 0.5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Loan Amount"),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "${data.data?.loanamount}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16).r,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kGreyColor, width: 0.5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loan Scheme",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "${data.data?.schemeid}",
                            style:
                            Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16).r,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kGreyColor, width: 0.5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loan Date/Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "${DateFormat.yMMMEd().format(data.data!.scheduledate!)} ${DateFormat.jm().format(data.data!.scheduledate!)}",
                            style:
                            Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16).r,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kGreyColor, width: 0.5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "${data.data?.streetaddress}",
                            style:
                            Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        }, error: (error, stacktrace) {
          print(error);
          print(stacktrace);
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

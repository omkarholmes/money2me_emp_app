import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/my_loan_controller.dart';
import 'package:money2me/src/dashboard/screens/statement/loan_statement.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Statement",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: kWhiteColor),
          ),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Consumer(
            builder: (context,ref,child) {
              return ref.watch(loanProvider(sharedPref.getInt(SharedPref.partyIdKey))).when(data: (value){
                return ListView.builder(
                  itemCount: value.data!.length,
                  padding: const EdgeInsets.symmetric(vertical:6,horizontal: 16).r,
                  itemBuilder: (context,index){
                    return  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoanStatementScreen(loanId: value.data![index].loanId.toString())));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 6).r,
                        padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8).r,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(value.data![index].schemeName,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor),),
                            Text("No: ${value.data![index].loanNo}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kBlackColor),),
                            Text(DateFormat.yMMMd().format(value.data![index].loanDate),style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kMidGrey),),
                            Text("Due Date ${DateFormat.yMMMd().format(value.data![index].loanDueDate)}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kRedColor),),
                            Text("Loan amount is ${value.data![index].loanAmount.toStringAsFixed(2)}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kBlackColor),)
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
                  error: (error,stacktrace){
                    print(error);
                    print(stacktrace);
                    return Container();
                  },
                  loading: (){
                    return Center(child: CircularProgressIndicator(),);
                  });
            }));



        // ListView(
        //
        //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16).r,
        //   children: [
        //     InkWell(
        //       onTap: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoanStatementScreen(loanId: '',)));
        //       },
        //       child: Container(
        //         width: MediaQuery.of(context).size.width,
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 12, horizontal: 8).r,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(6),
        //             color: kWhiteColor,
        //             boxShadow: const [
        //               BoxShadow(
        //                 color: Colors.black12,
        //                 offset: Offset(0, 0),
        //                 spreadRadius: 0,
        //                 blurRadius: 2,
        //               )
        //             ]),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "HINI REBATE SCHEME 2.17%",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodyMedium
        //                   ?.copyWith(color: kPrimaryColor),
        //             ),
        //             Text(
        //               "No: GLWHOAA00001",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodySmall
        //                   ?.copyWith(color: kBlackColor),
        //             ),
        //             Text(
        //               "Thu, Apr 14 2022",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodySmall
        //                   ?.copyWith(color: kMidGrey),
        //             ),
        //             Text(
        //               "Due Date Fri, May 13 2022",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodySmall
        //                   ?.copyWith(color: kRedColor),
        //             ),
        //             Text(
        //               "Loan amount is 16040.00",
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .bodySmall
        //                   ?.copyWith(color: kBlackColor),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ));
  }

  @override

  bool get wantKeepAlive => true;
}



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/my_loan_controller.dart';
import 'package:money2me/src/dashboard/screens/loan_details/loan_details.dart';


class RepayLoanScreen extends StatefulWidget {

  const RepayLoanScreen({
    super.key,
  });

  @override
  State<RepayLoanScreen> createState() => _RepayLoanScreenState();
}

class _RepayLoanScreenState extends State<RepayLoanScreen> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
          child:Container(
            decoration: const BoxDecoration(
              color: kWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0,2),
                  blurRadius: 2,
                )
              ]
            ),
            width: double.infinity,

            padding: const EdgeInsets.all(10).r,
              child: Text("Select the Loan you want to pay for",style: Theme.of(context).textTheme.bodyMedium,)),),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          elevation: 1,
        ),
        body:Consumer(
        builder: (context,ref,child) {
      return ref.watch(loanProvider(sharedPref.getInt(SharedPref.partyIdKey))).when(data: (value){
        return ListView.builder(
          itemCount: value.data!.length,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16).r,
          itemBuilder: (context,index){
            return  InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoanDetailsScreen(loanId: value.data![index].loanId,showButton: true,)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6).r,
                width: MediaQuery.of(context).size.width,
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
        if(kDebugMode) {
          print(error);
          print(stacktrace);
        }
        return Container();
      },
          loading: (){
        return const Center(child: CircularProgressIndicator(),);
      });
  }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

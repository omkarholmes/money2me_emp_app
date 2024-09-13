import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/home_controller.dart';
import 'package:money2me/src/new_loan/new_loan_form.dart';
import 'package:money2me/src/new_loan/request_detail.dart';
import 'package:money2me/src/topup/models/topup_request.dart';
import 'package:money2me/src/topup/topup_controller.dart';
import 'package:money2me/src/topup/topup_loans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: kWhiteColor),
          ),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16).r,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Consumer(builder: (context, ref, child) {

              return ref.watch(loanRequestDetailProvider).when(data: (data) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RequestDetailPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                            .r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: kShadowColor,
                            spreadRadius: 0,
                            blurRadius: 3,
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width-65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Loan Request Received!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "we have received your loan application and we will connect with very shortly",
                                      maxLines: 3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: kMidGrey)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        EasyStepper(
                          reachedSteps: {0},
                          lineLength: 30,
                          lineThickness: 2,
                          // lineSpace: 6,
                          lineType: LineType.normal,
                          defaultLineColor: kGreyColor,
                          finishedLineColor: kPrimaryColor,
                          internalPadding: 6,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          showLoadingAnimation: false,
                          showScrollbar: false,
                          stepRadius: 16.r,
                          showStepBorder: true,
                          steps: [
                            EasyStep(
                                icon: Icon(
                                  Icons.check,
                                  color: kGreyColor,
                                ),
                                customTitle: SizedBox(
                                  width: 40,
                                  child: Text(
                                    "Request Recieved",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: kBlackColor),
                                    maxLines: 3,
                                  ),
                                )),
                            EasyStep(
                                icon: const Icon(
                                  Icons.check,
                                  size: 28,
                                ),
                                customTitle: SizedBox(
                                  width: 40,
                                  child: Text(
                                    "Loan Application Forwarded",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: kBlackColor),
                                    maxLines: 3,
                                  ),
                                )),
                            EasyStep(
                                icon: Icon(
                                  Icons.check,
                                  size: 28,
                                ),
                                customTitle: SizedBox(
                                  width: 40,
                                  child: Text(
                                    "Loan In Progress",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: kBlackColor),
                                    maxLines: 3,
                                  ),
                                )),
                            EasyStep(
                                icon: Icon(
                                  Icons.check,
                                  size: 28,
                                ),
                                customTitle: SizedBox(
                                  width: 40,
                                  child: Text(
                                    "Loan Disbursal Initiated",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: kBlackColor, fontSize: 14),
                                    maxLines: 3,
                                  ),
                                )),
                            EasyStep(
                                icon: Icon(
                                  Icons.check,
                                  size: 28,
                                ),
                                customTitle: SizedBox(
                                  width: 40,
                                  child: Text(
                                    "Loan Disbursal Successful",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: kBlackColor),
                                    maxLines: 3,
                                  ),
                                )),
                          ],
                          activeStep: 0,
                        ),
                      ],
                    ),
                  ),
                );
              }, error: (error, stacktrace) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                       "/home/new_loan");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8)
                            .r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: kShadowColor,
                            spreadRadius: 0,
                            blurRadius: 3,
                          )
                        ]),
                    child: Row(
                      children: [
                        // SizedBox(
                        //   height: 65.r,
                        //   width: 65.r,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     clipBehavior: Clip.antiAliasWithSaveLayer,
                        //     child: const Placeholder(),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Loan",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text("Create a request for new loan",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: kMidGrey)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }, loading: () {
                return Container();
              });
            }),
            SizedBox(
              height: 16.h,
            ),
            Consumer(builder: (context, ref, child) {
              return ref.watch(bannerProvider).when(data: (data) {
                List<Widget> images = List.from(data.data!.map(
                  (e) => CachedNetworkImage(
                    imageUrl: e.imageUrl ?? "",
                    fit: BoxFit.fill,
                  ),
                ));
                return CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 200,
                      enlargeFactor: 1,
                      autoPlay: true,
                    ));
              }, error: (error, stacktrace) {
                return Container();
              }, loading: () {
                return Container();
              });
            }),
            SizedBox(
              height: 10.h,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final highestRateAndLowerROIAsync =
                    ref.watch(highestRateAndLowerROIProvider);
                return highestRateAndLowerROIAsync.when(
                  data: (highestRateAndLowerROI) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8)
                          .r,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Lowest Interest Rate ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: kBlackColor),
                              ),
                              Text(
                                "${highestRateAndLowerROI.data!.roi?.toStringAsFixed(2)}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: kBlackColor,
                                        fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Highest Rate Per Gram ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: kBlackColor)),
                              Text("${highestRateAndLowerROI.data?.maxRate}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: kBlackColor,
                                          fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    if (kDebugMode) {
                      print(error);
                      print(stackTrace.toString());
                    }
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Consumer(builder: (context, ref, child) {
              return ref.watch(topUpAlertProvider).when(data: (data) {
                return InkWell(
                  onTap: () {
                    TopupRequest topupRequest = TopupRequest();
                    topupRequest.partyId =
                        sharedPref.getInt(SharedPref.partyIdKey);
                    TopupController topupController = TopupController();
                    topupController
                        .requestTopup(topupRequest)
                        .then((value){})
                        .catchError((onError){});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopupLoansPage(
                                  topupRequest: topupRequest,
                                )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8)
                            .r,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Congratulation!",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "You can now TopUp the Loan. Tap here to know more.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: kBlackColor),
                        )
                      ],
                    ),
                  ),
                );
              }, error: (error, stacktrace) {
                return Container();
              }, loading: () {
                return Container();
              });
            }),

            SizedBox(
              height: 16.h,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 12, horizontal: 8).r,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       color: kWhiteColor,
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.black12,
            //           offset: Offset(0, 0),
            //           spreadRadius: 0,
            //           blurRadius: 2,
            //         )
            //       ]),
            //   child: const Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [Text("Costumer Review"), Text("")],
            //   ),
            // ),
          ]),
        ));
  }
}

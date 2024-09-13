import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/auth/Model/LoginRequestModel.dart';
import 'package:money2me/src/dashboard/Controller/dashboard_controller.dart';
import 'package:money2me/src/dashboard/controller/profile_controller.dart';
import 'package:money2me/src/dashboard/screens/profile/contact_us.dart';
import 'package:money2me/src/dashboard/screens/profile/profile_details.dart';
import 'package:money2me/src/splashscreen.dart';
import 'faq.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/app_transparent_logo.png",
                    ),
                    fit: BoxFit.fitWidth),
              ),
              child: Consumer(builder: (context, ref, child) {
                LoginRequestModel loginRequestModel = LoginRequestModel(
                  mobileNo: sharedPref.getString(SharedPref.mobileKey),
                  partyCode: sharedPref.getString(SharedPref.partyCodeKey),
                );
                return ref.watch(userProfile(loginRequestModel)).when(
                    data: (data) {
                  return SafeArea(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileDetailsScreen(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 65.r,
                            width: 65.r,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: (data.data?.partyprofilepic ?? "").isEmpty
                                  ? null
                                  : Image.network(
                                      data.data!.partyprofilepic!,
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.center,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            "${data.data?.partyfullname}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kWhiteColor),
                          ),
                          Text(
                            data.data?.emailId ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kWhiteColor),
                          ),
                          Text(
                            "CRN Number: ${data.data?.partyCode ?? ""}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kWhiteColor),
                          ),
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
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16).r,
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FaqScreen(),
                        ),
                      );
                    },
                    shape: const ContinuousRectangleBorder(
                        side: BorderSide(color: kBlackColor, width: 0.2)),
                    leading: Icon(
                      Icons.question_mark_rounded,
                      size: 28.sp,
                    ),
                    title: Text(
                      "Help and FAQs",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsScreen(),
                        ),
                      );
                    },
                    shape: const ContinuousRectangleBorder(
                        side: BorderSide(color: kBlackColor, width: 0.2)),
                    leading: Icon(
                      Icons.inbox_rounded,
                      size: 28.sp,
                    ),
                    title: Text(
                      "Contact us",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.sp,
                    ),
                  )
                ],
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                style: TextButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                      side: BorderSide(
                        color: kRedColor,
                      ),
                    ),
                    fixedSize: Size(120.w, 36.h)),
                child: Text(
                  "LOGOUT",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: kRedColor),
                ),
                onPressed: () {
                  DialogHelper.showAlertWithActions(
                      context, "Alert", "Are you sure, you want to logout?",
                      () {
                    sharedPref.clear();
                    ref.read(dashboardProvider).changeIndex(0);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (route) => false);
                  }, () {
                    Navigator.pop(context);
                  }, 'Yes', 'No');
                },
              );
            }),
            SizedBox(
              height: 10.h,
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

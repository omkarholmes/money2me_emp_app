import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/WorkingTimeController.dart';
import 'package:money2me/src/dashboard/controller/loan_address_controller.dart';
import 'package:money2me/src/dashboard/screens/profile/address_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressListScreen())),
              child: Text(
                "Nearest Branch",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kWhiteColor, decoration: TextDecoration.underline),
              ),
            ),
          ],
          backgroundColor: kPrimaryColor,
          iconTheme: const IconThemeData(
            color: kWhiteColor,
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) => ref
              .watch(
                  loanAddressProvider(sharedPref.getInt(SharedPref.partyIdKey)))
              .when(data: (value) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.contact_mail,
                          size: 100,
                          color: kWhiteColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12).r,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: kPrimaryColor,
                            size: 40,
                          ),
                          Text(
                            value.data!.first.branchAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => launchUrl(
                              Uri.parse(
                                  "$googleUrl${value.data!.first.lat},${value.data!.first.long}"),
                              mode: LaunchMode.externalApplication,
                            ),
                            child: const Text(
                              'Open Map',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(
                            Icons.phone_android,
                            color: kPrimaryColor,
                            size: 40,
                          ),
                          Text(
                            value.data!.first.contactNo,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Icon(
                            Icons.watch_later_outlined,
                            color: kPrimaryColor,
                            size: 40,
                          ),
                          SizedBox(height: 6.h,),
                          Consumer(builder: (context, ref, child) {
                            return ref.watch(workTimingProvider).when(
                                data: (data) {
                              return ListView.builder(
                                shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      data.data?[index].officeTiming??"",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kGreyColor),
                                    );
                                  });

                            }, error: (Object error, StackTrace stackTrace) {
                              return Container();
                            }, loading: () {
                              return Container();
                            });
                          }),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://www.facebook.com/Money2me.in'),
                                  mode: LaunchMode.externalApplication,
                                ),
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  width: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => launchUrl(
                                  Uri.parse('https://twitter.com/money2me_'),
                                  mode: LaunchMode.externalApplication,
                                ),
                                child: Image.asset(
                                  'assets/icons/twitter.png',
                                  width: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://www.linkedin.com/company/money2me-finance/ '),
                                  mode: LaunchMode.externalApplication,
                                ),
                                child: Image.asset(
                                  'assets/icons/linkedin.png',
                                  width: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://www.instagram.com/money2me.in/'),
                                  mode: LaunchMode.externalApplication,
                                ),
                                child: Image.asset(
                                  'assets/icons/instagram.png',
                                  width: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://www.youtube.com/channel/UCr3jDu7kkYxUAInyuW9gMjA'),
                                  mode: LaunchMode.externalApplication,
                                ),
                                child: Image.asset(
                                  'assets/icons/youtube.png',
                                  width: 35,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
          }),
        ));
  }
  @override
  void dispose(){
    super.dispose();


  }
}

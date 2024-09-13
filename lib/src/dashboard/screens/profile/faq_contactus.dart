import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/controller/WorkingTimeController.dart';
import 'package:money2me/src/dashboard/screens/profile/callback_form.dart';

class FaqContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Help and FAQs'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.15,
                width: MediaQuery.sizeOf(context).width,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/app_transparent_logo.png",
                      ),
                      fit: BoxFit.fitWidth),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kWhiteColor),
                                  );
                                });

                          }, error: (Object error, StackTrace stackTrace) {
                        return Container();
                      }, loading: () {
                        return Container();
                      });
                    }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12).r,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  surfaceTintColor: Colors.transparent,
                  color: kWhiteColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallBackFormScreen(),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.phone_callback,
                              color: kWhiteColor,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            'Request a Callback',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            'We will contact you within 1 hour',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: kGreyColor,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18.sp,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: kPrimaryColor,
                            child: Icon(
                              Icons.phone,
                              color: kWhiteColor,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            'Call us 022 2811 8000 / 6544',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            'Contact our support team',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: kGreyColor,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/widget/contact.dart';
import 'package:money2me/src/dashboard/controller/faq_controller.dart';
import 'package:money2me/src/dashboard/models/faq.dart';
import 'package:money2me/src/dashboard/screens/profile/faq_details.dart';

class FaqScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Faq> faqs = ref.read(faqProvider).faqs;
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
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 12.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/app_transparent_logo.png",
                      ),
                      fit: BoxFit.fitWidth),
                ),
                child: Text(
                  "How can we help you today?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
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
                        Text(
                          'Common FAQs',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kBlackColor,
                            fontSize: 16,
                          ),
                        ),
                        ...faqs.asMap().entries.map(
                              (e) => Column(
                                children: [
                                  ListTile(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FaqDetailsScreen(
                                          faq: e.value,
                                        ),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(0),
                                    dense: true,
                                    title: Text(
                                      e.value.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: kBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      e.value.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: kGreyColor,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18.sp,
                                    ),
                                  ),
                                  if (e.key != faqs.length - 1)
                                    Divider(
                                      color: kLightGrey,
                                    ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              Contact(),
            ],
          ),
        ));
  }
}

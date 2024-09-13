import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/models/faq.dart';

import '../../../../common/widget/contact.dart';

class FaqDetailsScreen extends StatelessWidget {
  final Faq faq;

  FaqDetailsScreen({required this.faq});

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
                      "Loan application related",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "FAGs on Money2Me branches, schemes, documents required and others.",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
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
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          title: Text(
                            faq.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            faq.description,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: kGreyColor,
                            ),
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

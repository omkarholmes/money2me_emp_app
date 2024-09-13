import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

import '../../src/dashboard/screens/profile/faq_contactus.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12).r,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        surfaceTintColor: Colors.transparent,
        color: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: kPrimaryColor,
                child: Icon(
                  Icons.help_outline,
                  color: kWhiteColor,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need Help?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: kBlackColor,
                    ),
                  ),
                  Text(
                    'Feel free to  get in touch with us',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: kGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FaqContactScreen(),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: kLightGrey),
                    ),
                    child: Text(
                      'CONTACT US',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

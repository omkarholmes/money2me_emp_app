import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

class KTextButton extends StatelessWidget{
  const KTextButton({super.key,required this.onPressed,required this.text, this.backgroundColor});

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor:backgroundColor??kPrimaryColor,
            fixedSize: Size(310.w,36.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed, child: Text(text,style: Theme.of(context).textTheme.labelLarge?.copyWith(color: kWhiteColor),)),
    );
  }

}
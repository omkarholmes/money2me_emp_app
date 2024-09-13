import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData kAppTheme() {
  ThemeData base = ThemeData();
  return base.copyWith(
    // useMaterial3: true,
    primaryColor: kPrimaryColor,
    canvasColor: kRedColor,
    dividerColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
        primary: kPrimaryColor,
        seedColor: kPrimaryColor,
        outlineVariant: kWhiteColor,
        background: kWhiteColor),
    scaffoldBackgroundColor: kWhiteColor,
    dialogBackgroundColor: kWhiteColor,

    bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: kWhiteColor, backgroundColor: kWhiteColor),
    textTheme: GoogleFonts.robotoTextTheme(Typography.englishLike2018
        .apply(fontSizeFactor: 1.sp, bodyColor: kBlackColor)),
    // datePickerTheme: DatePickerThemeData(),
  );
}

const Color kWhiteColor = Colors.white;
const Color kBlackColor = Colors.black;
Color kShadowColor = Colors.black26;
Color kGreyColor = Colors.grey;
Color kMidGrey = Colors.grey.shade500;
Color kLightGrey = Colors.grey.shade300;
const Color kPrimaryColor = Colors.green;
const Color kSecondaryColor = Colors.amber;
Color kRedColor = Colors.red;

String googleUrl = 'https://www.google.com/maps/search/?api=1&query=';

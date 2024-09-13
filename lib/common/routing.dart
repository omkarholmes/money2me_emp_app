import 'package:flutter/material.dart';
import 'package:money2me/src/auth/getting_started.dart';
import 'package:money2me/src/auth/login.dart';
import 'package:money2me/src/auth/mpin_screen.dart';
import 'package:money2me/src/dashboard/dashboard.dart';
import 'package:money2me/src/new_loan/new_loan_form.dart';
import 'package:money2me/src/splashscreen.dart';

import '../src/auth/otp_verification.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => const SplashScreen(),
  "/m_pin": (context) => const MpinScreen(),
  "/login": (context) => const LoginScreen(),
  "/login/otp_verify": (context) => OtpVerifyScreen(
        argument:
            ModalRoute.of(context)!.settings.arguments! as OtpScreenArgument,
      ),
  "/get_started": (context) => const GetStartedScreen(),
  "/get_started/otp_verify": (context) => OtpVerifyScreen(
    argument:
    ModalRoute.of(context)!.settings.arguments! as OtpScreenArgument,
  ),
  "/get_started/new_loan": (context) => const NewLoanForm(),
  "/home": (context) => const Dashboard(),
  "/home/new_loan": (context) => const NewLoanForm(),
};

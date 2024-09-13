import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/db_helper.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/auth/Model/VerifyMpinRequestModel.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';
import 'package:money2me/src/auth/login.dart';
import 'package:money2me/src/dashboard/dashboard.dart';
import 'package:pinput/pinput.dart';

class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  VerifyMPINRequestModel verifyMPINRequestModel = VerifyMPINRequestModel();
  AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getId();
  }

  getId() async {
    verifyMPINRequestModel.deviceId = await authController.getId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 24.sp,
              color: kBlackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: Background(
          child: SafeArea(
            minimum: const EdgeInsets.all(16).r,
            maintainBottomViewPadding: true,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 28.h,
                  ),
                  Expanded(
                    flex: 5,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verify M-PIN",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Enter M-pin to Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 16.r,
                          ),
                          Pinput(
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: "*",
                            errorTextStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kRedColor),
                            onCompleted: (String? pin) {
                              verifyMPINRequestModel.mpin = pin;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the pin";
                              } else if (value.length < 6) {
                                return "Please enter 6 digit pin.";
                              }
                              return null;
                            },
                            defaultPinTheme: pinTheme(kPrimaryColor),
                            focusedPinTheme: pinTheme(kBlackColor),
                            followingPinTheme: pinTheme(kLightGrey),
                            errorPinTheme: pinTheme(kRedColor),
                          ),
                          SizedBox(
                            height: 16.r,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                   "/login");
                              },
                              child: Text(
                                "Forget M-Pin?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          )
                        : KTextButton(
                            text: "NEXT",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  isLoading = true;
                                });
                                authController
                                    .verifyMPin(verifyMPINRequestModel)
                                    .then((value) {
                                  DbHelper.saveUserdata(value.data);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                     "/home",
                                      (route) => false);
                                }).catchError((onError) {
                                  print(onError);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (onError is AppException) {
                                    DialogHelper.showAlert(
                                        context, "Error", onError.message ?? "",
                                        () {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                              }
                            },
                          ),
                  ),
                ]),
          ),
        ));
  }

  PinTheme pinTheme(Color borderColor) {
    return PinTheme(
      height: 50.r,
      width: 50.r,
      textStyle:
          Theme.of(context).textTheme.labelLarge?.copyWith(color: kBlackColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12).r,
        border: Border.all(color: borderColor, width: 2),
      ),
    );
  }
}

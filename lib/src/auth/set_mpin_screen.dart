import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/auth/Model/SetMpinRequestModel.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';
import 'package:money2me/src/auth/mpin_screen.dart';
import 'package:pinput/pinput.dart';

class SetMpinScreen extends StatefulWidget {
  final String partyCode;
  const SetMpinScreen({super.key, required this.partyCode});

  @override
  State<SetMpinScreen> createState() => _SetMpinScreenState();
}

class _SetMpinScreenState extends State<SetMpinScreen> {
  SetMPINRequestModel setMPINRequestModel = SetMPINRequestModel();
  AuthController authController = AuthController();
  TextEditingController mPinController = TextEditingController();
  TextEditingController confirmMPinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getId();
  }

  getId() async {
    setMPINRequestModel.deviceId = await authController.getId();
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
                            "Set a M-PIN",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "New M-Pin",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 6.r,
                          ),
                          Pinput(
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: "*",
                            controller: mPinController,
                            errorTextStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kRedColor),
                            onCompleted: (String? pin) {
                              setMPINRequestModel.mpin = pin;
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
                            height: 10.h,
                          ),
                          Text(
                            "Confirm M-Pin",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 6.r,
                          ),
                          Pinput(
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: "*",
                            errorTextStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kRedColor),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the pin";
                              } else if (value.length != 6) {
                                return "Please enter 6 digit pin.";
                              } else if (value.trim() !=
                                  mPinController.text.trim()) {
                                return "M-Pin and Confirm M-Pin is not same";
                              }
                              return null;
                            },
                            defaultPinTheme: pinTheme(kPrimaryColor),
                            focusedPinTheme: pinTheme(kBlackColor),
                            followingPinTheme: pinTheme(kLightGrey),
                            errorPinTheme: pinTheme(kRedColor),
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
                            child:
                                CircularProgressIndicator(color: kPrimaryColor))
                        : KTextButton(
                            text: "NEXT",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setMPINRequestModel.partyCode =
                                    widget.partyCode;
                                _formKey.currentState!.save();
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await authController
                                      .setMPin(setMPINRequestModel)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MpinScreen()));
                                  });
                                } on AppException catch (e) {
                                  DialogHelper.showAlert(
                                      context, "Error", e.message ?? "", () {
                                    Navigator.pop(context);
                                  });
                                } on PlatformException catch (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
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

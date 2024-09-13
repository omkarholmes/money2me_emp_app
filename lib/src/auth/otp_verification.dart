import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/auth/Model/otp_request_model.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';
import 'package:money2me/src/auth/set_mpin_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';


class OtpScreenArgument {
  final String mobileNo;
  final String?  partyCode;
  const OtpScreenArgument({
    required this.mobileNo,
    this.partyCode
  });
}

class OtpVerifyScreen extends StatefulWidget {
 final OtpScreenArgument argument ;

  const OtpVerifyScreen({
    super.key,
   required this.argument,
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  OTPRequestModel otpRequestModel = OTPRequestModel();
  AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CountdownController? countdownController;
  bool isCountdown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpRequestModel.mobileNo = widget.argument.mobileNo;
    countdownController = CountdownController(autoStart: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 28.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: Background(
          child: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verify CRN Number",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                        Text(
                            "OTP has been sent to your registered mobile number.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: kBlackColor)),
                        SizedBox(
                          height: 10.r,
                        ),
                        Pinput(
                          length: 6,
                          errorTextStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kRedColor),
                          onCompleted: (String? pin) {
                            otpRequestModel.otp = pin;
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
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: (){
                              if(!isCountdown) {
                                authController.sendOTP(widget.argument.mobileNo).then((
                                    value) {
                                  countdownController?.restart();
                                  setState(() {
                                    isCountdown = true;
                                  });
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 12.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("Request another OTP",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: isCountdown?kGreyColor:kBlackColor)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.r,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Countdown(
                            seconds: 120,
                            interval: const Duration(seconds: 1),
                            controller: countdownController,
                            onFinished: (){
                              setState(() {
                                isCountdown = false;
                              });
                            },
                            build: (BuildContext context, double time) {
                              return Text("${time.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: kRedColor));
                          },
                          ),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                      ],
                    ),
                  ),
                  KTextButton(
                    text: "NEXT",
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        authController.verifyOTP(otpRequestModel).then((value) {
                         if(widget.argument.partyCode == null){
                           sharedPref.setString(SharedPref.mobileKey, widget.argument.mobileNo);
                           Navigator.pushNamed(context, "/get_started/new_loan");
                         }
                         else {
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) =>
                                   SetMpinScreen(
                                       partyCode: widget.argument.partyCode ?? "")));
                         }}).catchError((onError) {
                          if (onError is AppException) {
                            DialogHelper.showAlert(context, "Error", onError
                                .message!, () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      }
                       },
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

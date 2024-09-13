import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/common/widget/webpage_viewer.dart';
import 'package:money2me/src/auth/Model/LoginRequestModel.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';
import 'package:money2me/src/auth/otp_verification.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({
    super.key,
  });

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  LoginRequestModel loginRequestModel = LoginRequestModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  bool isLoading = false;

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
                          "Start with!",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                        // TextFormField(
                        //   controller: _crnController,
                        //   style: Theme.of(context).textTheme.labelLarge,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         vertical: 6, horizontal: 12)
                        //         .r,
                        //     label: Text(
                        //       "CRN Number",
                        //       style: Theme.of(context).textTheme.labelMedium,
                        //     ),
                        //     focusColor: kSecondaryColor,
                        //     border: const OutlineInputBorder(),
                        //   ),
                        //   onSaved: (String? value) {
                        //     loginRequestModel.partyCode = value;
                        //   },
                        //   validator: (String? value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "required";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 16.r,
                        // ),
                        TextFormField(
                          controller: _mobileController,
                          maxLength: 10,
                          style: Theme.of(context).textTheme.labelLarge,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Mobile Number",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (String? value) {
                            loginRequestModel.mobileNo = value;
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            } else if (value.length != 10) {
                              return "10 digit required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By using Money2Me app I agree to the",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: kBlackColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              String url = ApiConfig.termsCondition;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebpageViewer(
                                          url, "Terms and Conditions")));
                            },
                            child: Text(
                              "Terms and Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor),
                            ),
                          ),
                          Text(
                            " & ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                          ),
                          InkWell(
                            onTap: () {
                              String url = ApiConfig.privacyPolicyUrl;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebpageViewer(
                                          url, "Privacy Policy")));
                            },
                            child: Text(
                              "Privacy Policy",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      isLoading
                          ? Container(
                              height: 36.h,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            )
                          : KTextButton(
                              text: "Get Otp",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  AuthController authController =
                                      AuthController();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  authController
                                      .sendOTP(loginRequestModel.mobileNo!)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushNamed(
                                        context, "/get_started/otp_verify",
                                        arguments: OtpScreenArgument(
                                          mobileNo: loginRequestModel.mobileNo!,
                                        ));
                                  }).catchError((onError) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (onError is AppException) {
                                      DialogHelper.showAlert(
                                          context, "", onError.message ?? "",
                                          () {
                                        Navigator.pop(context);
                                      });
                                    }
                                    if (kDebugMode) {
                                      print(onError);
                                    }
                                  });
                                }
                                // getData();
                              },
                            ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}

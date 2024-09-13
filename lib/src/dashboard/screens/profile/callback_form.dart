import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/models/callback_model.dart';

import '../../controller/callback_controller.dart';

class CallBackFormScreen extends StatefulWidget {
  @override
  State<CallBackFormScreen> createState() => _CallBackFormScreenState();
}

class _CallBackFormScreenState extends State<CallBackFormScreen> {
  CallbackModel callbackModel = CallbackModel(reason: '', partyId: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  bool isLoading = false;

  void submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      _formKey.currentState!.save();
      CallbackController controller = CallbackController();
      setState(() {
        isLoading = true;
      });
      callbackModel.partyId = sharedPref.getInt(SharedPref.partyIdKey).toString();
      controller.submitCallback(callbackModel).then((value) {
        setState(() {
          isLoading = false;
        });
        DialogHelper.showAlert(
            context, "Successful!!", "Thanks we will get back to you", () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        if (onError is AppException) {
          DialogHelper.showAlert(context, "", onError.message ?? "", () {
            Navigator.pop(context);
          });
        }
        if (kDebugMode) {
          print(onError);
        }
      });
    }
  }

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
                      "Contact Us",
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
                      "Monday - Saturday : 8am - 7pm",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "Sunday : 9:30am - 6:30pm",
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Describe your reason"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _reasonController,
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 5,
                            onSaved: (String? value) {
                              callbackModel.reason = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12)
                                  .r,
                              hintText: "Please enter your reason",
                              focusColor: kSecondaryColor,
                              border: const OutlineInputBorder(),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: isLoading
                                ? CircularProgressIndicator()
                                : OutlinedButton(
                                    onPressed: submit,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1.0, color: kLightGrey),
                                    ),
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/common/widget/background.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/auth/Model/ForgetCRNModel.dart';
import 'package:money2me/src/auth/controller/auth_controller.dart';

class ForgetCRNScreen extends StatefulWidget {
  const ForgetCRNScreen({
    super.key,
  });

  @override
  State<ForgetCRNScreen> createState() => _ForgetCRNScreenState();
}

class _ForgetCRNScreenState extends State<ForgetCRNScreen> {

  ForgetCRNModel forgetCrnModel = ForgetCRNModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  DateTime? selectedDate;
  bool isLoading= false;


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
                          "Forget CRN Number?",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.r,
                        ),
                    Text(
                      "No worries! Just complete the quick verification process & get your CRN number on your Registered mobile number.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: kMidGrey,fontWeight: FontWeight.w600),
                    ),
                        SizedBox(
                          height: 30.r,
                        ),
                        TextFormField(
                          controller: _mobileController,
                          maxLength: 10,
                          style: Theme.of(context).textTheme.labelLarge,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Registered Mobile Number",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (String? value){
                            forgetCrnModel.mobileNo = value;
                          },
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return "required";
                            }else if(value.length != 10 ){
                              return "10 digit required";
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 16.r,
                        ),
                        TextFormField(
                          controller: _dateController,
                          style: Theme.of(context).textTheme.labelLarge,
                          readOnly: true,
                          onTap: () async {
                            final df= DateFormat('dd/MM/yyyy');
                            selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100),);
                            _dateController.text = selectedDate != null ? df.format(selectedDate!):"";
                          },
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.datetime,

                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Date Of Birth",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          onSaved: (String? value){
                            forgetCrnModel.dob = selectedDate;
                          },
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return "required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Container(height: 36.h,alignment: Alignment.center,
                    child: const CircularProgressIndicator(),)
                      :KTextButton(

                    text: "Send",
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        AuthController authController = AuthController();
                        setState(() {
                          isLoading = true;
                        });
                        authController.forgetCrn(forgetCrnModel).then((value)  {
                          setState(() {
                            isLoading = false;
                          });
                          DialogHelper.showAlert(context, "Success!!", "Party code sent successfully to your registered mobile number", () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        }).catchError((onError){
                          print(onError);
                          setState(() {
                            isLoading = false;
                          });
                          if(onError is AppException){
                            DialogHelper.showAlert(context, "", onError.message??"", () {
                              Navigator.pop(context);
                            });
                          }
                          if(kDebugMode) {
                            print(onError);
                          }
                        });
                      }
                      // getData();
                    },
                  ),
                ]),
          ),
        ));
  }

// getData() async {
//   ApiService apiService = ApiService();
//   Map<String, String> headers = {
//     'Content-Type': 'application/x-www-form-urlencoded',
//
//   };
//   apiService
//       .post(
//           Uri.parse(
//               "https://lms.money2me.in:8001/Andflutter.asmx/CheckPartyJSON"),
//           {"MobileNo": "8286302558"},
//           headers)
//       .then((value) {
//         print(value);
//     print(value);
//   }).catchError((onError) {
//     print("error");
//     print(onError);
//   });
// }
}

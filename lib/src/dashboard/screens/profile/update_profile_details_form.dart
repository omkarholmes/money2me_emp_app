import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Database/sharedPref.dart';
import '../../../../common/config/theme.dart';
import '../../../../main.dart';
import '../../../auth/Model/kyc_details_model.dart';
import '../../controller/profile_controller.dart';
import '../../models/kyc_details.dart';
import 'profile_details/address_details_form.dart';
import 'profile_details/bank_details_form.dart';
import 'profile_details/basic_details_form.dart';
import 'profile_details/documents_upload_form.dart';

class UpdateProfielDetailsForms extends StatefulWidget {
  const UpdateProfielDetailsForms({super.key});

  @override
  State<UpdateProfielDetailsForms> createState() =>
      _UpdateProfielDetailsFormsState();
}

class _UpdateProfielDetailsFormsState extends State<UpdateProfielDetailsForms> {
  int step = 0;
  List<String> forms = [
    "Basic Details",
    "Address Details",
    "Bank Details",
    "Doccument Upload"
  ];
  late KYCDetails myDetails;

  GlobalKey<FormState> _basicFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Edit Profile Details'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return ref
                .watch(profielDetails(KYCRequestModel(
                    partyId:
                        sharedPref.getInt(SharedPref.partyIdKey).toString())))
                .when(data: (data) {
              myDetails = data.data!;
              return Column(
                children: [
                  Expanded(
                    child: step == 0
                        ? BasicDetailsForm(
                            basicFormKey: _basicFormKey,
                            details: myDetails,
                            onSubmit: (formData) {
                              setState(() {
                                myDetails = formData;
                                step = 1;
                              });
                            },
                          )
                        : step == 1
                            ? AddressDetailsForm(
                                details: myDetails,
                                onSubmit: (formData) {
                                  setState(() {
                                    myDetails = formData;
                                    step = 2;
                                  });
                                },
                              )
                            : step == 2
                                ? BankDetailsForm(
                                    details: myDetails,
                                    onSubmit: (formData) {
                                      setState(() {
                                        myDetails = formData;
                                        step = 3;
                                      });
                                    },
                                  )
                                : DocumentUploadForm(
                                    onSubmit: (docuemnts) async {
                                      myDetails.docuemnts = docuemnts;
                                      myDetails.partyId = sharedPref
                                          .getInt(SharedPref.partyIdKey)
                                          .toString();
                                      await submitKYCDetails(myDetails)
                                          .then((value) {
                                        if (value) {
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                  ),
                  ),
                ],
              );
            }, error: (Object error, StackTrace stackTrace) {
              return Container();
            }, loading: () {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            });
          },
        ));
  }
}

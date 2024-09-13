import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

import '../../../models/kyc_details.dart';

class BankDetailsForm extends StatelessWidget {
  final KYCDetails details;
  final Function(KYCDetails formData) onSubmit;
  const BankDetailsForm(
      {super.key, required this.onSubmit, required this.details});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Text(
                "Bank Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: kBlackColor, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.bankname,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Bank Name",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      details.bankname = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.branchname,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Bank Branch",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      details.branchname = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.accounttype,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Account Type Drop Down",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      details.accounttype = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.accountno,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Account no.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      details.accountno = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.ifsccode,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "IFSC Code",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      details.ifsccode = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.receipientname,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Receipient Name",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      details.receipientname = value;
                    },
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      onSubmit(details);
                    },
                    child: Container(
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

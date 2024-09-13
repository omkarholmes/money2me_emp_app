import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/src/dashboard/models/document_type.dart';
import 'package:money2me/src/dashboard/models/kyc_details.dart';

import '../../../controller/profile_controller.dart';

class BasicDetailsForm extends StatelessWidget {
  final KYCDetails details;
  final Function(KYCDetails formData) onSubmit;
  final GlobalKey<FormState> basicFormKey;
  const BasicDetailsForm(
      {super.key,
      required this.onSubmit,
      required this.details,
      required this.basicFormKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: basicFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Text(
                "Basic Details",
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
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 150.r,
                              width: 150.r,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(color: kBlackColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(200),
                                    // border: Border.all(color: kBlackColor),
                                  ),
                                  child: ClipRRect(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    borderRadius: BorderRadius.circular(50),
                                    child:
                                        (details.profilepicpath ?? "").isEmpty
                                            ? null
                                            : Image.network(
                                                details.profilepicpath ?? "",
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  showImagePickerBottomSheet(context, (value) {
                                    uploadDocument(DocumentType(
                                      documentID: -1,
                                      documentname: "ProfileImage",
                                    )..filePath = value)
                                        .then((value) {
                                      setState(() {
                                        details.profilepicpath = value;
                                      });
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: kPrimaryColor,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: kWhiteColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: details.mobileno,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
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
                    keyboardType: TextInputType.number,
                    onSaved: (String? value) {},
                    maxLength: 10,
                    onChanged: (value) {
                      details.mobileno = value;
                    },
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
                    initialValue: details.landlineno,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Alternate Number",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    maxLength: 10,
                    onChanged: (value) {
                      details.landlineno = value;
                    },
                    keyboardType: TextInputType.number,
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
                    initialValue: details.emailid,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Email Id",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      details.emailid = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "required";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Invalid Email";
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
                      if (basicFormKey.currentState!.validate()) {
                        onSubmit(details);
                      }
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

  showImagePickerBottomSheet(
    BuildContext context,
    Function addImage,
  ) {
    ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.r,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          picker
                              .pickImage(source: ImageSource.camera)
                              .then((value) {
                            addImage(value!.path);
                            Navigator.pop(context);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(
                              height: 10.r,
                            ),
                            Text(
                              "Camera",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            addImage(value!.path);
                            Navigator.pop(context);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(
                              height: 10.r,
                            ),
                            Text(
                              "Gallery",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

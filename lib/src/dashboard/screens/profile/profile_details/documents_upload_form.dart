import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../Database/sharedPref.dart';
import '../../../../../common/config/theme.dart';
import '../../../../../main.dart';
import '../../../../auth/Model/kyc_details_model.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/document_type.dart';
import '../../../models/existing_doc.dart';

class DocumentUploadForm extends StatefulWidget {
  final Function(List<DocumentType> formData) onSubmit;
  const DocumentUploadForm({super.key, required this.onSubmit});

  @override
  State<DocumentUploadForm> createState() => _DocumentUploadFormState();
}

class _DocumentUploadFormState extends State<DocumentUploadForm> {
  List<DocumentType> docs = [];
  DocumentType selectedDoc = DocumentType();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Text(
                "Documents Upload",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: kBlackColor, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: kPrimaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Existing Documents",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5.r,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Doc. Name",
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                child: Text(
                              "Expiry Date",
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontWeight: FontWeight.bold),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(2.50),
                              child: Icon(
                                Icons.download,
                                color: kWhiteColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.r,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                return ref
                                    .watch(existingDocuments(KYCRequestModel(
                                        partyId: sharedPref
                                            .getInt(SharedPref.partyIdKey)
                                            .toString())))
                                    .when(data: (data) {
                                  return ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: data.data!.map((e) {
                                      ExistingDoc doc = e;
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.50),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: kPrimaryColor)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 5),
                                            child: Row(
                                              children: [
                                                // Text("${index + 1}. "),
                                                Expanded(
                                                  child: Text(
                                                    "${doc.documentname}",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    e.expirydate == null
                                                        ? ""
                                                        : DateFormat(
                                                                "dd MMM yyyy")
                                                            .format(DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(e
                                                                    .expirydate!)),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return Scaffold(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          body: SafeArea(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 50,
                                                                  child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundColor:
                                                                              kBlackColor,
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_back,
                                                                            color:
                                                                                kWhiteColor,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Center(
                                                                  child: Image
                                                                      .network(
                                                                    e.filepath!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.50),
                                                    child: Icon(
                                                      Icons.visibility,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }, error:
                                        (Object error, StackTrace stackTrace) {
                                  return Container(
                                    child: Text(
                                      "Something Went Worng !",
                                      style: TextStyle(
                                          color: kRedColor, fontSize: 14),
                                    ),
                                  );
                                }, loading: () {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.r,
            ),
            Divider(
              thickness: 2,
              height: 2,
              color: kBlackColor,
            ),
            SizedBox(
              height: 10.r,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.r,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Add New Document",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                return ref
                                    .watch(documentTypes(KYCRequestModel(
                                        partyId: sharedPref
                                            .getInt(SharedPref.partyIdKey)
                                            .toString())))
                                    .when(data: (data) {
                                  return DropdownButtonFormField<DocumentType>(
                                    dropdownColor: kWhiteColor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 12)
                                              .r,
                                      label: Text(
                                        "Document Type",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      focusColor: kSecondaryColor,
                                      border: const OutlineInputBorder(),
                                    ),
                                    value: selectedDoc.documentname == null
                                        ? null
                                        : selectedDoc,
                                    isExpanded: true,
                                    isDense: true,
                                    items: data.data!
                                        .map((e) =>
                                            DropdownMenuItem<DocumentType>(
                                                value: e,
                                                child: Text(
                                                  e.documentname!,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )))
                                        .toList(),
                                    onChanged: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      if (docs
                                          .map((e) => e.documentID)
                                          .toList()
                                          .contains(value!.documentID!)) {
                                        selectedDoc = DocumentType();
                                        setState(() {});
                                        Fluttertoast.showToast(
                                            msg:
                                                "Document Already Present in Documents to Upload!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kRedColor,
                                            textColor: kWhiteColor,
                                            fontSize: 16.0.sp);
                                      } else {
                                        selectedDoc = value;
                                        setState(() {});
                                      }
                                    },
                                  );
                                }, error:
                                        (Object error, StackTrace stackTrace) {
                                  return Container(
                                    child: Text(
                                      "Something Went Worng !",
                                      style: TextStyle(
                                          color: kRedColor, fontSize: 14),
                                    ),
                                  );
                                }, loading: () {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          if (selectedDoc.hasExpirydate ?? false) ...[
                            SizedBox(
                              width: 5.r,
                            ),
                            // EXPIRY DATE PICKER
                            Expanded(
                              child: InkWell(
                                  onTap: () async {
                                    var date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate: selectedDoc.expirydate ==
                                                null
                                            ? null
                                            : DateFormat("yyyy-MM-dd")
                                                .parse(selectedDoc.expirydate!),
                                        lastDate: DateTime.now()
                                            .add(Duration(days: 365 * 10)));

                                    // selectedDoc.expirydate =
                                    //     DateFormat("yyyy-MM-dd").format(date!);

                                    setState(() {
                                      selectedDoc.expirydate =
                                          DateFormat("yyyy-MM-dd")
                                              .format(date!);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kBlackColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 14),
                                      child: Text(
                                        selectedDoc.expirydate == null
                                            ? "Exipry Date"
                                            : DateFormat("dd MMM yyyy").format(
                                                DateFormat("yyyy-MM-dd").parse(
                                                    selectedDoc.expirydate!)),
                                        style: TextStyle(
                                            color: kBlackColor, fontSize: 14),
                                      ),
                                    ),
                                  )),
                            )
                          ]
                        ],
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      InkWell(
                        onTap: () {
                          showImagePickerBottomSheet((value) {
                            selectedDoc.filePath = value;
                            setState(() {});
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: kGreyColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                selectedDoc.filePath?.split("/").last ??
                                    "Upload Document",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.r,
                      ),
                      InkWell(
                        onTap: () {
                          var error = (selectedDoc.documentname ?? "") == ""
                              ? "Document Type is required."
                              : (selectedDoc.hasExpirydate ?? false) &&
                                      (selectedDoc.expirydate ?? "") == ""
                                  ? "Expiry Date is Required."
                                  : (selectedDoc.filePath ?? "") == ""
                                      ? "Please Select a Image."
                                      : "";
                          if (error != "") {
                            Fluttertoast.showToast(
                                msg: error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kRedColor,
                                textColor: kWhiteColor,
                                fontSize: 16.0.sp);
                          } else {
                            uploadDocument(selectedDoc).then((value) {
                              selectedDoc.filePath = value;
                              docs.add(selectedDoc);
                              setState(() {
                                selectedDoc = DocumentType();
                              });
                            });
                          }
                        },
                        child: Container(
                          color: kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      Divider(
                        thickness: 2,
                        height: 2,
                        color: kBlackColor,
                      ),
                      SizedBox(
                        height: 10.r,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Text(
                          "Documents to Add",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                "Doc. Name",
                                style: TextStyle(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "File",
                                style: TextStyle(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 50,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.r,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: docs
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: kPrimaryColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(e.documentname!)),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: 50,
                                                  child: Image.network(
                                                    e.filePath!,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Icon(
                                                        Icons.image,
                                                        size: 30,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    docs.remove(e);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    color: kRedColor,
                                                    child: Center(
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: kWhiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  )),
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
                      widget.onSubmit(docs);
                    },
                    child: Container(
                      color: kPrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Text(
                          "Submit",
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

  showImagePickerBottomSheet(Function addImage) {
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

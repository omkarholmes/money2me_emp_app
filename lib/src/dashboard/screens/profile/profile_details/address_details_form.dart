import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2me/common/config/theme.dart';

import '../../../models/kyc_details.dart';

class AddressDetailsForm extends StatefulWidget {
  final KYCDetails details;
  final Function(KYCDetails formData) onSubmit;
  const AddressDetailsForm(
      {super.key, required this.onSubmit, required this.details});

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  bool sameAsPermanent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sameAsPermanent = widget.details.commflatno == widget.details.flatno;
  }

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
                "Address Details",
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
                  Text(
                    "Permanent Address",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kBlackColor, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: widget.details.flatno,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Flat No.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {},
                    onChanged: (value) {
                      widget.details.flatno = value;
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
                    initialValue: widget.details.permanentstreet,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Street",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {},
                    onChanged: (value) {
                      widget.details.permanentstreet = value;
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
                    initialValue: widget.details.landmark,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Landmark",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String? value) {},
                    onChanged: (value) {
                      widget.details.landmark = value;
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
                    initialValue: widget.details.area,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Area",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      widget.details.area = value;
                    },
                    keyboardType: TextInputType.text,
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.details.city,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "City",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            widget.details.city = value;
                          },
                          keyboardType: TextInputType.text,
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16.r,
                      ),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.details.state,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "State",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            widget.details.state = value;
                          },
                          keyboardType: TextInputType.text,
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  TextFormField(
                    initialValue: widget.details.pincode,
                    // controller: _crnController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12)
                          .r,
                      label: Text(
                        "Pin Code",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      focusColor: kSecondaryColor,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      widget.details.pincode = value;
                    },
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty || value.length <= 6) {
                        return "required";
                      }
                      return null;
                    },
                  ),
                  // SizedBox(
                  //   height: 16.r,
                  // ),
                  SizedBox(
                    height: 16.r,
                  ),
                  Text(
                    "Communication Address",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kBlackColor, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  Row(
                    children: [
                      Text("Same As Permanent Address"),
                      SizedBox(
                        width: 16.r,
                      ),
                      InkWell(
                          onTap: () {
                            if (!sameAsPermanent) {
                              widget.details.commflatno = widget.details.flatno;
                              widget.details.commstreet =
                                  widget.details.permanentstreet;
                              widget.details.commlandmark =
                                  widget.details.landmark;
                              widget.details.commarea = widget.details.area;
                              widget.details.commcity = widget.details.city;
                              widget.details.commstate = widget.details.state;
                              widget.details.commpincode =
                                  widget.details.pincode;
                            }
                            setState(() {
                              sameAsPermanent = !sameAsPermanent;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(sameAsPermanent
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16.r,
                  ),
                  if (!sameAsPermanent)
                    Column(
                      children: [
                        TextFormField(
                          initialValue: widget.details.commflatno,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Flat No.",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            widget.details.commflatno = value;
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
                          initialValue: widget.details.commstreet,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Street",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            widget.details.commstreet = value;
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
                          initialValue: widget.details.commlandmark,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Landmark",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            widget.details.commlandmark = value;
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
                          initialValue: widget.details.commarea,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Area",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            widget.details.commarea = value;
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
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.details.commcity,
                                // controller: _crnController,
                                style: Theme.of(context).textTheme.labelLarge,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "City",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  widget.details.commcity = value;
                                },
                                onSaved: (String? value) {},
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 16.r,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.details.commstate,
                                // controller: _crnController,
                                style: Theme.of(context).textTheme.labelLarge,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "State",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  widget.details.commstate = value;
                                },
                                onSaved: (String? value) {},
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.r,
                        ),
                        TextFormField(
                          initialValue: widget.details.commpincode,
                          // controller: _crnController,
                          style: Theme.of(context).textTheme.labelLarge,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12)
                                .r,
                            label: Text(
                              "Pin Code",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            focusColor: kSecondaryColor,
                            border: const OutlineInputBorder(),
                          ),
                          maxLength: 6,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            widget.details.commpincode = value;
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
                    )
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
                      widget.onSubmit(widget.details);
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

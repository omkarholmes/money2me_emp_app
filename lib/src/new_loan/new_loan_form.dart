import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/response_model.dart';
import 'package:money2me/common/widget/button.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/controller/home_controller.dart';
import 'package:money2me/src/dashboard/dashboard.dart';
import 'package:money2me/src/new_loan/controller/new_loan.dart';
import 'package:money2me/src/new_loan/controller/step_controller.dart';
import 'package:money2me/src/new_loan/map.dart';
import 'package:money2me/src/new_loan/model/LoanRequest.dart';
import 'package:money2me/src/new_loan/model/map_address.dart';
import 'package:money2me/src/new_loan/model/schemes.dart';
import 'package:money2me/src/new_loan/model/time.dart';

class NewLoanForm extends StatefulWidget {
  const NewLoanForm({super.key});

  @override
  State<NewLoanForm> createState() => _NewLoanFormState();
}

class _NewLoanFormState extends State<NewLoanForm> {
  bool isChecked = false;
  List<Slot> morning = [];
  List<Slot> afternoon = [];
  List<Slot> evening = [];
  MapAddress? address;
  Slot? selectedTime;
  ControlsDetails? details;
  LoanRequest loanRequest = LoanRequest();
  NewLoanService newLoanService = NewLoanService();

  // RangeValues currentRange = const RangeValues(50000, 5000000);
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final GlobalKey<FormState> _informationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  init() {
    loanRequest.scheduleddatetime = DateUtils.dateOnly(DateTime.now());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final stepRef = ref.watch(stepProvider);
      int currentIndex = stepRef.currentIndex;
      return WillPopScope(
        onWillPop: () async {
          ref.read(stepProvider).backAction(context);
          return currentIndex == 0;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kWhiteColor,
            toolbarHeight: 34.h,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 24.sp,
                color: kBlackColor,
              ),
              onPressed: () {
                ref.read(stepProvider).backAction(context);
              },
            ),
            elevation: 0,
          ),
          body: Theme(
              data: kAppTheme().copyWith(canvasColor: kWhiteColor),
              child: Stepper(
                currentStep: stepRef.currentIndex,
                controlsBuilder: (context, details) {
                  this.details = details;
                  return Container();
                },
                onStepContinue: () {},
                physics:const BouncingScrollPhysics(),
                elevation: 0,
                type: StepperType.horizontal,
                steps: [
                  Step(
                      title: Text(
                        "Information",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Form(
                          key: _informationFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer(builder: (context, ref, child) {
                                  final schemesAsync =
                                      ref.watch(schemesProvider);
                                  return schemesAsync.when(
                                      data: (ListResponse<Scheme> data) {
                                    List<Scheme> schemes = data.data ?? [];
                                    List<DropdownMenuItem> item = List.generate(
                                        schemes.length,
                                        (index) => DropdownMenuItem(
                                            value: schemes[index].schemeName,
                                            child: Text(
                                                "${schemes[index].schemeName} Rate:${schemes[index].ratePerGram}/gm")));
                                    return DropdownButtonFormField(
                                      items: item,
                                      onChanged: (value) {
                                        if (value != null) {
                                          loanRequest.scheme =
                                              schemes.firstWhere((element) =>
                                                  element.schemeName == value);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                    vertical: 6, horizontal: 12)
                                                .r,
                                        label: Text(
                                          "Select Scheme",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        errorStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: kRedColor),
                                        focusColor: kSecondaryColor,
                                        border: const OutlineInputBorder(),
                                      ),
                                    );
                                  }, error: (error, stacktrace) {
                                    return Container();
                                  }, loading: () {
                                    return Container();
                                  });
                                }),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  controller: _loanAmountController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  style: Theme.of(context).textTheme.labelLarge,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 12)
                                        .r,
                                    label: Text(
                                      "Loan Amount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    focusColor: kSecondaryColor,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return "required";
                                    }
                                    else if(int.parse(value) <= 0){
                                      return "value c";
                                    }
                                    return null;
                                  },
                                ),
                                // Text(
                                //   "Select Loan Amount",
                                //   style: Theme.of(context).textTheme.bodyLarge,
                                // ),
                                // RangeSlider(
                                //     values: currentRange,
                                //     divisions: 5000,
                                //     min: 50000,
                                //     max: 5000000,
                                //     labels: RangeLabels(
                                //       currentRange.start.toStringAsFixed(0),
                                //       currentRange.end.toStringAsFixed(0),
                                //     ),
                                //     overlayColor: MaterialStateProperty.all(
                                //         Colors.grey.shade100),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         currentRange = value;
                                //       });
                                //     }),
                                // SizedBox(
                                //   height: 8.h,
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "50 Thousands",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .bodyMedium,
                                //     ),
                                //     Text("50 Lakhs",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyMedium)
                                //   ],
                                // ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  "When do you wish to avail loan?",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  "Select Date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: kBlackColor),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 75.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 60,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DateTime date =
                                            DateUtils.dateOnly(DateTime.now())
                                                .add(Duration(days: index));
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              loanRequest.scheduleddatetime =
                                                  date;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: loanRequest
                                                        .scheduleddatetime ==
                                                    date
                                                ? const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                kPrimaryColor,
                                                            width: 2)))
                                                : null,
                                            width: 70.w,
                                            margin:
                                                const EdgeInsets.only(right: 12)
                                                    .r,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "${DateFormat.LLL().format(date)} ${DateFormat.y().format(date)}"),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(
                                                    DateFormat.d().format(date),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Text(DateFormat.E()
                                                      .format(date)),
                                                ]),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: kGreyColor, width: 0.5)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Select Time",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: kBlackColor),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Consumer(builder: (context, ref, child) {
                                  return ref.watch(timeProvider).when(
                                      data: (data) {
                                    sortTime(data.data!);

                                    return Column(
                                      children: [
                                        if (morning.isNotEmpty) ...[
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.sunny,
                                                size: 18.sp,
                                              ),
                                              Text(
                                                "Morning",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: kGreyColor,
                                                            width: 0.5)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 60.h,
                                            child: ListView.builder(
                                                itemCount: morning.length,
                                                // shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                                right: 8.0)
                                                            .r,
                                                    child: FilterChip(
                                                      selected: selectedTime ==
                                                          morning[index],
                                                      showCheckmark: false,
                                                      selectedColor:
                                                          kPrimaryColor,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 4)
                                                              .r,
                                                      label: Text(morning[index]
                                                          .slotdesc!),
                                                      onSelected: (value) {
                                                        setState(() {
                                                          selectedTime = value
                                                              ? morning[index]
                                                              : null;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                        if (afternoon.isNotEmpty) ...[
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.sunny,
                                                size: 18.sp,
                                              ),
                                              Text(
                                                "Afternoon",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: kGreyColor,
                                                            width: 0.5)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 60.h,
                                            child: ListView.builder(
                                                itemCount: afternoon.length,
                                                // shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                                right: 8.0)
                                                            .r,
                                                    child: FilterChip(
                                                      selected: selectedTime ==
                                                          afternoon[index],
                                                      showCheckmark: false,
                                                      selectedColor:
                                                          kPrimaryColor,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 4)
                                                              .r,
                                                      label: Text(
                                                          afternoon[index]
                                                              .slotdesc!),
                                                      onSelected: (value) {
                                                        setState(() {
                                                          selectedTime = value
                                                              ? afternoon[index]
                                                              : null;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                        if (evening.isNotEmpty) ...[
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.nightlight_round_outlined,
                                                size: 18.sp,
                                              ),
                                              Text(
                                                "Evening",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: kGreyColor,
                                                            width: 0.5)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 60.h,
                                            child: ListView.builder(
                                                itemCount: evening.length,
                                                // shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                                right: 8.0)
                                                            .r,
                                                    child: FilterChip(
                                                      selected: selectedTime ==
                                                          evening[index],
                                                      showCheckmark: false,
                                                      selectedColor:
                                                          kPrimaryColor,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 4)
                                                              .r,
                                                      label: Text(evening[index]
                                                          .slotdesc!),
                                                      onSelected: (value) {
                                                        setState(() {
                                                          selectedTime = value
                                                              ? evening[index]
                                                              : null;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ]
                                      ],
                                    );
                                  }, error: (error, stacktrace) {
                                    return Container();
                                  }, loading: () {
                                    return Container();
                                  });
                                }),
                              ]),
                        ),
                      ),
                      isActive: currentIndex == 0),
                  Step(
                      title: Text(
                        "Address",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Form(
                          key: _addressFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _houseController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "House No. & Building Name",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  loanRequest.houseno = _houseController.text;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  MapAddress? address = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MapScreen()));
                                  if (address != null) {
                                    this.address = address;
                                    _houseController.text =
                                        this.address?.placemark.name ?? "";
                                    _streetController.text =
                                        this.address?.address ?? "";
                                    _landmarkController.text =
                                        this.address?.placemark.locality ?? "";
                                    _pincodeController.text =
                                        this.address?.placemark.postalCode ??
                                            "";
                                    setState(() {});
                                  }
                                },
                                controller: _streetController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "Select Street Address",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  loanRequest.streetaddress =
                                      _streetController.text;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _landmarkController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "Landmark",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  loanRequest.landmark =
                                      _landmarkController.text;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _pincodeController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12)
                                      .r,
                                  label: Text(
                                    "Pin code",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  focusColor: kSecondaryColor,
                                  border: const OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  loanRequest.pincode = _pincodeController.text;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      isActive: currentIndex == 1),
                  Step(
                      title: Text("Summary",
                          style: Theme.of(context).textTheme.titleMedium),
                      content: Container(
                        alignment: Alignment.topCenter,
                        height: MediaQuery.sizeOf(context).height,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: kLightGrey,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: kLightGrey)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16).r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16)
                                            .r,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: kGreyColor,
                                                width: 0.5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Loan Amount"),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          _numberToCurrency(int.parse(
                                              _loanAmountController.text.isEmpty
                                                  ? "0"
                                                  : _loanAmountController
                                                      .text)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16)
                                            .r,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: kGreyColor,
                                                width: 0.5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Loan Scheme",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          "${loanRequest.scheme?.schemeName} Rate:${loanRequest.scheme?.ratePerGram}/gm",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16)
                                            .r,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: kGreyColor,
                                                width: 0.5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Loan Date/Time",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          "${DateFormat.yMMMEd().format(loanRequest.scheduleddatetime ?? DateTime.now())}, ${selectedTime?.slotdesc}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16)
                                            .r,
                                    // decoration: BoxDecoration(
                                    //     border: Border(
                                    //         bottom: BorderSide(
                                    //             color: kGreyColor,
                                    //             width: 0.5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Address",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          "${address?.address}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Consumer(builder: (context, ref, child) {
                              return ref.watch(consentProvider).when(
                                data: (data) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          value: isChecked,
                                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      fillColor:MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                        return kPrimaryColor;
                                      }),
                                          onChanged: (value) {
                                            setState(() {
                                              isChecked = value ?? false;
                                            });
                                          }),
                                      SizedBox(width: 4.w),
                                      SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.75,
                                          child: Text(
                                            data.data?.consentDesc ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ))
                                    ],
                                  );
                                },
                                error: (error, stacktrace) {
                                  print(error);
                                  return Container();
                                },
                                loading: () {
                                  return Container();
                                },
                              );
                            })
                          ],
                        ),
                      ),
                      isActive: currentIndex == 2)
                ],
              )),
          persistentFooterButtons: [
            Consumer(
              builder: (context, ref, child) {
                return KTextButton(
                    onPressed: !isChecked && stepRef.currentIndex == 2?(){}:(){
                      if (stepRef.currentIndex == 0) {
                        if (_informationFormKey.currentState!.validate() &&
                            selectedTime != null) {
                          stepRef.continueAction(context);
                        }
                      } else if (stepRef.currentIndex == 1) {
                        if (_addressFormKey.currentState!.validate()) {
                          _addressFormKey.currentState!.save();
                          stepRef.continueAction(context);
                        }
                      } else {
                        loanRequest.scheduleddatetime = _mergeDateAndTime(
                            loanRequest.scheduleddatetime!,
                            selectedTime!.timevalue);
                        loanRequest.loanamount = _loanAmountController.text;
                        loanRequest.createdby =
                            sharedPref.getString(SharedPref.mobileKey);
                        DialogHelper.showLoadingIndicator(context);
                        newLoanService.requestLoan(loanRequest).then((value) {
                          DialogHelper.hide(context);
                          DialogHelper.showAlert(
                              context,
                              "Success!",
                              "Your request has been successfully received,"
                                  " we will contact you soon. Your reference number is:"
                                  " ${value.data?.referenceNumber}", () {
                            if (ModalRoute.of(context)!.settings.name!.contains("get_started")) {
                              Navigator.popUntil(
                                  context,ModalRoute.withName('/login'));
                            } else {
                              // ignore: unused_result
                              ref.refresh(loanRequestDetailProvider.future);
                              Navigator.popUntil(
                                  context,
                              ModalRoute.withName("/home"));
                            }
                          });
                        });
                      }
                    },
                    text: "Next",
                  backgroundColor: !isChecked && stepRef.currentIndex == 2?kGreyColor:kPrimaryColor,

                );
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sortTime(List<Slot> data) {
    morning = List.from(data.where(
        (e) => e.slottype == SlotType.MORNING && _compareTime(e.timevalue!)));
    afternoon = List.from(data.where(
        (e) => e.slottype == SlotType.AFTERNOON && _compareTime(e.timevalue!)));
    evening = List.from(data.where(
        (e) => e.slottype == SlotType.EVENING && _compareTime(e.timevalue!)));
  }

  // Compares the time value with current time.
  bool _compareTime(String value) {
    if (loanRequest.scheduleddatetime
            ?.compareTo(DateUtils.dateOnly(DateTime.now())) ==
        0) {
      int hour = int.parse(value.substring(0, 2));
      int min = int.parse(value.substring(3, 5));
      if (hour > DateTime.now().hour) {
        return true;
      } else if (hour == DateTime.now().hour) {
        return min >= DateTime.now().minute;
      } else {
        return false;
      }
    }
    return true;
  }

  //Coverts 10000 to 10thousand
  String _numberToCurrency(int value) {
    int lakh = value ~/ 100000;
    int thousand = value ~/ 1000;
    if (lakh > 0) {
      return "$lakh ${lakh == 1 ? "Lakh" : "Lakhs"}";
    } else {
      return "$thousand ${thousand == 1 ? "Thousand" : "Thousands"}";
    }
  }

  DateTime _mergeDateAndTime(DateTime date, time) {
    return DateTime.parse(date.toString().replaceFirst("00:00", time));
  }
}

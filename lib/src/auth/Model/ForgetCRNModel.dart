class ForgetCRNModel{
  String? mobileNo;
  DateTime? dob;

  ForgetCRNModel({this.mobileNo,this.dob});

  Map<String, dynamic> toJson() => {
    "DOB": dob?.toIso8601String(),
    "MobileNO":mobileNo,
  };

}
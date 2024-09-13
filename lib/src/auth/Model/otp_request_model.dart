class OTPRequestModel{
  String? mobileNo;
  String? otp;

  Map<String,dynamic> toJson()=>{
    "mobileNo":mobileNo,
    "otp":otp,
  };
}
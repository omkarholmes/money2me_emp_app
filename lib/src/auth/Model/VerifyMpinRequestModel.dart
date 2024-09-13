class VerifyMPINRequestModel{
  String? deviceId;
  String? mpin;

  Map<String,dynamic> toJson()=>{
    "deviceid":deviceId,
    "mpin":mpin,
  };
}
class SetMPINRequestModel{
  String? deviceId;
  String? partyCode;
  String? mpin;

  Map<String,dynamic> toJson()=>{
    "partycode":partyCode,
    "deviceid":deviceId,
    "mpin":mpin,
  };
}
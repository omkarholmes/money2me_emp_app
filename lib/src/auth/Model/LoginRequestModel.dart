import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable{
  String? partyCode;
  String? mobileNo;

  LoginRequestModel({this.mobileNo,this.partyCode});

  Map<String, dynamic> toJson() => {
    "PartyCode": partyCode,
    "MobileNO":mobileNo,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [partyCode,mobileNo];

}
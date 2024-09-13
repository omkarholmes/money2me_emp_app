import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class KYCRequestModel extends Equatable {
  String? partyId;
  String? mobileNo;

  KYCRequestModel({this.partyId});

  Map<String, dynamic> toJson() => {
        "partyid": partyId,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [partyId];
}

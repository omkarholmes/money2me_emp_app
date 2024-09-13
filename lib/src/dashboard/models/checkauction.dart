

import 'package:money2me/common/response_model.dart';

ApiResponse<Auction> auctionFromJson(Map<String,dynamic> data) => ApiResponse.fromJson(data, (data) => data == null?data : Auction.fromJson(data.first));

class Auction extends Serializable{
  int auctionId;
  String loanNo;
  dynamic firstNotice;
  dynamic secondNotice;
  dynamic thirdNotice;
  dynamic auctionAmount;
  dynamic publishDate;
  String auctionDate;
  bool isActive;

  Auction({
    required this.auctionId,
    required this.loanNo,
    this.firstNotice,
    this.secondNotice,
    this.thirdNotice,
    this.auctionAmount,
    this.publishDate,
    required this.auctionDate,
    required this.isActive,
  });

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
    auctionId: json["AuctionId"],
    loanNo: json["LoanNo"],
    firstNotice: json["FirstNotice"],
    secondNotice: json["SecondNotice"],
    thirdNotice: json["ThirdNotice"],
    auctionAmount: json["AuctionAmount"],
    publishDate: json["PublishDate"],
    auctionDate: json["AuctionDate"],
    isActive: json["iSACTIVE"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "AuctionId": auctionId,
    "LoanNo": loanNo,
    "FirstNotice": firstNotice,
    "SecondNotice": secondNotice,
    "ThirdNotice": thirdNotice,
    "AuctionAmount": auctionAmount,
    "PublishDate": publishDate,
    "AuctionDate": auctionDate,
    "iSACTIVE": isActive,
  };
}

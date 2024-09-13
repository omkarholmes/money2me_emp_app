class TopupRequest{
  String? loanId;
  String? schemeId;
  String? amt;
  int? partyId;

  TopupRequest({
    this.loanId,
    this.partyId,
    this.amt,
    this.schemeId,
});

  Map<String, dynamic> toJson() => {
    "PartyId": partyId?.toString(),
    "LoanId": loanId ?? "",
     "schemeid":schemeId??"",
     "topupamt":amt??"",
  };

}
import 'package:equatable/equatable.dart';
import 'package:money2me/common/enums.dart';

class LoanDetailRequest extends Equatable{
  String? loanId;
  ReceiptType? receiptType;
  LoanDetailRequest({this.loanId,this.receiptType});

  Map<String,dynamic>toJson()=>{
    "LoanId": loanId,
    "ReceiptType": receiptType?.toJson,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [loanId,receiptType];

}

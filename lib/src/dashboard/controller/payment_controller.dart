import 'package:money2me/Database/sharedPref.dart';
import 'package:money2me/common/enums.dart';
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/api_service.dart';
import 'package:money2me/main.dart';
import 'package:money2me/src/dashboard/models/loan_details.dart';
import 'package:money2me/src/dashboard/models/payment.dart';

class PaymentController {
  ApiService apiService = ApiService();

  Future<dynamic> postPayment(
      {required LoanDetails loanDetails,
      required double amount,
      required ReceiptType receiptType,
      String? transId,
      required DateTime transTime,
      required String status}) async {
    Payment payment = Payment();
    payment.orderId = transId;
    payment.amount = amount;
    payment.partyId = sharedPref.getInt(SharedPref.partyIdKey);
    payment.copyWithLoanData(loanDetails);
    payment.isPaymentRced = true;
    payment.isTransComp = true;
    payment.pgId = 1;
    payment.transDate = transTime.toIso8601String();
    payment.alteredDate = transTime.toIso8601String();
    payment.orderStatus = status;
    payment.inttype = receiptType.toJson;
    payment.paymentFlag = "M";
    payment.paymentgetway = 2;
    payment.unpaid = loanDetails.totalPay - amount;
    Uri uri = Uri.parse(ApiConfig.postPaymentUrl);
    final content = await apiService.post(uri, payment.toJson());
    print(content);
  }
}

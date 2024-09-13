import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money2me/Database/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:money2me/common/services/api_config.dart';
import 'package:money2me/common/services/app_exception.dart';
import 'package:money2me/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayIntegration {

  RazorpayIntegration();
  final Razorpay _razorpay = Razorpay();

  initiateRazorPay(
      Function(PaymentSuccessResponse) handlePaymentSuccess,
      Function(PaymentFailureResponse) handlePaymentError,
      Function(ExternalWalletResponse) handleExternalWallet) {
    // To handle different event with previous functions
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openGateway(String orderId, String loanId,
  String loanNumber,
  double amount) {
    Map<String, dynamic> options = {
      "order_id":orderId,
      'key': dotenv.env['RAZORPAY_KEY'],
      'currency': 'INR',
      'amount': amount * 100,
      'name': 'Money2me',
      'timeout': 300,
      'prefill': {
        'contact': sharedPref.getString(SharedPref.mobileKey),
        'email': sharedPref.getString(SharedPref.emailKey)
      },
      "notes":{
        "name":sharedPref.getString(SharedPref.userNameKey),
        "loan_number":loanNumber,
        "loanId":loanId,
        "orderId":orderId,
      },
      'allow_rotation': false,
    };
    try {
      _razorpay.open(options);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  createOrder( {required String loanId,
  required String loanNumber,
  required double amount, required Function(String) onComplete}) async {
    Map<String, dynamic> body = {
      "amount": amount * 100,
      "currency": "INR",
      "notes":{
        "name":sharedPref.getString(SharedPref.userNameKey),
        "loan_number":loanNumber,
        "loanId":loanId,
      },
    };

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${dotenv.env['RAZORPAY_KEY']}:${dotenv.env['RAZORPAY_SECRET_KEY']}'))}';

    final Map<String, String> headers = {
      'Accept': 'application/json',
      "Content-Type": "application/json",
      'authorization': basicAuth,
    };


    try {
      final response =  await http.post(Uri.parse(ApiConfig.orderURL),body:jsonEncode(body),headers: headers);
      if (response.statusCode == 200) {
        onComplete(jsonDecode(response.body)['id']);
        openGateway(jsonDecode(response.body)['id'],loanId,loanNumber,amount);
      }
    }on SocketException {
      throw FetchDataException("No Internet Connection.");
    }
  }


  dispose() {
    _razorpay.clear();
  }
}

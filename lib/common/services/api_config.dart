import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String _baseUrl =
      dotenv.env["BASE_URL"] ?? "https://lms.money2me.in";

  static final String _baseApiUrl = "$_baseUrl:${dotenv.env["API_URL"]}";
  static String downloadStatementUrl =
      "$_baseUrl:8005/CustAccountStatement.aspx?Id=";
  static String highestRateAndLowerROIUrl =
      "${_baseApiUrl}HighestRateandLowerROI";
  static String schemeListUrl = "${_baseApiUrl}SchemeList";
  static String loginUrl = "${_baseApiUrl}CustomerProfileupdated";
  static String callbackUrl = "${_baseApiUrl}AppCustomerQueries";
  static String loanUrl = "${_baseApiUrl}CustomerWiseLoan";
  static String addressUrl = "${_baseApiUrl}getbrancheslist";
  static String transactionDetailsUrl = "${_baseApiUrl}TransactionDetail";
  static String loanDetailsUrl = "${_baseApiUrl}LoanWiseDetail";
  static String loanAddressUrl = "${_baseApiUrl}getloanaddressbypartyid";
  static String checkTodaysLimitUrl = "${_baseApiUrl}checktodayslimit";
  static String loanWiseStatementUrl = "${_baseApiUrl}loanwisestatement";
  static String postPaymentUrl = "${_baseApiUrl}APPRePayment";
  static String forgetCrnUrl = "${_baseApiUrl}ProvidePartyCode";
  static String checkAuctionUrl = "${_baseApiUrl}checkauction";
  static String verifyMPinUrl = "${_baseApiUrl}VerifyPartyMPin";
  static String setMPinUrl = "${_baseApiUrl}SetPartyMPin";
  static String checkIfDeviceIdExistUrl = "${_baseApiUrl}Checkifdeviceidexist";
  static String verifyOTPUrl = "${_baseApiUrl}VerifyOTP";
  static String sendOTPUrl = "${_baseApiUrl}SendOTP";
  static String getTimeSlotsUrl = "${_baseApiUrl}GetTimeSlot";
  static String requestLoanUrl = "${_baseApiUrl}AppNewLoanRequest";
  static String getLoanRequestDetailsUrl =
      "${_baseApiUrl}GetLoanRequestDetails";
  static String bannerUrl = "${_baseApiUrl}GetHomeBanner";
  static String topUpAlertUrl = "${_baseApiUrl}TopUpAlert";
  static String schemeWiseRepledgeUrl = "${_baseApiUrl}SchemeWiseRepledge";
  static String requestTopupUrl = "${_baseApiUrl}getdataTopUpAlert";
  static String consentUrl = "${_baseApiUrl}GetCustomerConsent";
  static String workingTimeUrl = "${_baseApiUrl}GetOfficeTiming";
  static String versionUrl = "${_baseApiUrl}ReadAppVersion";
  static String partReleaseUrl = "${_baseApiUrl}partreleaserequest";
  static String profileDetailsUrl = "${_baseApiUrl}GetKYCChangeRequestData";
  static String existingDocuments = "${_baseApiUrl}GetPartyExistingDoc";
  static String documentTypes = "${_baseApiUrl}GetPartyDoctype";
  static String partyChangeRequest = "${_baseApiUrl}AppPartyChangeRequest";

  static String uploadImages =
      "https://lms.money2me.in:8001/Andflutter.asmx/postImage";

  static String orderURL = "https://api.razorpay.com/v1/orders";

  static String privacyPolicyUrl = "https://www.money2me.in/privacy-policy/";
  static String termsCondition = "https://www.money2me.in/terms-of-use/";
}

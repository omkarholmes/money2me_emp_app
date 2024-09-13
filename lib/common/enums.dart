enum ReceiptType {
  loanCloser,
  interestPayment;

  String get toJson {
    switch (this) {
      case ReceiptType.loanCloser:
        return "Loan-Closer";
      case ReceiptType.interestPayment:
        return "Interest-Payment";
    }
  }
}

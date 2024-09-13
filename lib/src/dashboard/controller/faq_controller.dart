import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money2me/src/dashboard/models/address.dart';

import '../models/faq.dart';

ChangeNotifierProvider<FaqController> faqProvider =
    ChangeNotifierProvider<FaqController>((ref) => FaqController());

class FaqController extends ChangeNotifier {
  List<Faq> _faqs = [
    Faq(
        title: 'What is a Gold Loan?',
        description:
            "The gold loan is a loan against pledge of Used gold Ornaments and is secured loan that a borrower takes from a lender in lieu of pledging gold ornaments. It enables people to utilize their gold assets instead of storing them in lockers Customers usually go for this loan for short Term to meet the requirement of their children's education, marriage and other financial needs. Turnaround time (TAT) taken by any lender is very lesser than any other loan which is 30 minutes."),
    Faq(
        title: 'What is the eligibility criterion to qualify for a gold loan?',
        description:
            "For a gold loan, applicants should be aged above 21 years and have ownership of gold ornaments that need to be pledged with the Bank/ NBFC. The ownership of gold should be either by way of purchase/ gift/ ancestral assets, etc."),
    Faq(
        title: 'What is the interest charge applicable on gold loan?',
        description:
            "The interest rate on your gold loan varies from scheme to scheme which depends on certain factors like the purity of Gold, loan requirement, tenure etc. Interest rates on gold loan ranges start from less than 1.00 % per month depending on scheme availed by the borrower."),
    Faq(
        title: 'How is the rate of interest calculated on a gold loan scheme?',
        description: "Rate of Interest on gold loan is charged on annual basis and there are some rebates provided based on the payment days basis.\nE.g. If the Annual ROI for Gold loan is 27% and the Rebates provided are as below:\n\nIf Paid within (days) : 0-30\nRebate : 17.52%\nEffective ROI ( Per Annum) : 9.48%\n\nIf Paid within (days) : 31-60\nRebate : 6.00%\nEffective ROI ( Per Annum) : 21.00%\n\nIf Paid within (days) : 61-365\nRebate : 0.00%\nEffective ROI ( Per Annum) : 27.00%\n\nIf Customer pays interest on due date i.e 30th day from the date of loan the Effective ROI will be 9.48 % p.a (as per chart above).But if the Customer makes a default in payment on due date the rebate provided for timely payment of 17.52% reduces to 6% and the effective ROI would be 21% p.a. Similarly, if customer did not pay the interest till 60th day from the date of loan, the rebate will be Nil and the Effective ROI would be 27% p.aWe also want to state that, this all calculation varies from scheme to scheme. Like, there are jumping interest as well that is fixed ROI in entire tenure of the loan"),
    Faq(
        title:
            'What is the maximum amount that can be sanctioned under the gold loan scheme?',
        description:
            "Gold loan amount ranges From Rs Rs.5000 to Rs. 50,00,000 . Maximum loan eligibility should not be greater than 75% LTV (Loan to value) as per RBI guidelines."),
    Faq(
        title:
            'How long does it take to complete the gold loan approval process?',
        description:
            "As Gold loan is known for the fastest processing loan, so If your Customer's KYC documents are proper and the quality of gold is acceptable, and all the terms are acceptable to borrower then it takes only 20 - 30 minutes for the Gold loan Process."),
    Faq(
        title: 'What is the repayment tenure of a gold loan?',
        description:
            "The Repayment tenure of Gold Loan is based on customer requirements and scheme selected by the customer. There are multiple options available ranging from 3 months to 12 months."),
    Faq(
        title:
            'What are the additional fees/ charges that I will need to pay at the time of taking a loan?',
        description:
            "There are No additional Charges in the gold loan , but in some of the scheme there are minimum Processing fee levied at the time of availing the loan. Apart from this, there are no other hidden charges levied at the time of availing loan though the company will charge notice charges/ Tenure extension charges and auction charges as and when applicable."),
    Faq(
        title: 'Are there any foreclosure charges on a gold loan?',
        description:
            "Generally, there are no foreclosing charges on gold loan closure, though it depends on scheme to scheme as some schemes have foreclosure charges."),
    Faq(
        title: 'How can the pledged gold against the loan be reclaimed?',
        description:
            "After the Settlement of all dues, the customer can reclaim his/ her gold packet by giving one day prior intimation. The lender will arrange the packet on within 24 to 48 hours from the date of payment and close the Gold loan."),
    Faq(
        title: 'What medium should I use to repay the loan?',
        description:
            "The company has offered multiple methods of payment for repayment of loan such as Cash (As permissible Limit), Cheque, Demand Draft, Online Fund Transfer and payment through Money2Me App\nURL for Online payment: https://payment.money2me.in/Customer/login.aspx"),
    Faq(
        title: 'What documents are required for approval of your gold loan?',
        description: "The documents for Kyc Purpose are given below:\n\n1.Passport\n2.Driving License\n3.Voters ID\n4.Aadhar Card\n5.Voter ID card\n6.Job card issued by NREGA (duly signed by an Officer of the state government)\n7.Letter issued by the NPR (containing details of name and address)\n8.One recent photograph\n9.PAN (Permanent Account Number) or Form No. 60\nJob card issued by NREGA duly signed by an Officer of the state government and letter issued by the NPR containing details of name and address, One recent photograph, The Permanent Account Number or Form No. 60 as defined in Income-tax Rules, 1962.\n\nDocuments required for approval of your gold loan are:\n\n1.Id proof, such as your Driving License, Pan Card, Form 60/61, Passport, and Voter ID card.\n2.Address proof, such as House Registration Documents, and Utility Bills"),
    Faq(
        title: 'What is the penalty for delay in repayment of loan?',
        description:
            "There is no penalty charged for delay in payment but due to reduction in rebate provided the ROI will increase. Please Refer point no. (4)"),
    Faq(
        title: 'Can I repay the loan partially?',
        description:
            "Yes, Company offers Part Release facility to its entire valuable customer. Any customer can repay their gold loan partially (upto the minimum amount) And get their pledged ornaments upto the value paid."),
    Faq(
        title: 'Is the gold pledged with banks/NBFCs safe?',
        description:
            "Yes, it is completely secure.\n\nNBFCs take all necessary measures and precautions for storing your valuables They understand and value the sentiments of an individual associated with gold Jewellery and act as custodians during the complete tenure of loan. For the benefit of borrower and lender as well, all pledged/ deposited valuables are covered with 100% insurance protection."),
    Faq(
        title: 'What are the benefits of Gold Loan?',
        description:
            "1.Low Interest Rate\n2.Minimal Documentation\n3.Quick processing\n4.End use freedom\n5.Multiple repayment Methods\n6.No Impact of Poor Credit history\n7.Security of Physical Gold"),
    Faq(
        title: 'Can Gold loan be availed against ETF and sovereign gold bonds?',
        description:
            "No, Gold loan cannot be availed against gold ETF and sovereign gold bonds."),
    Faq(
        title: 'Is there any pre-payment option in Gold loan?',
        description:
            "Yes, in a gold loan, the borrower can request for pre-payment of the loan amount (principal and interest)"),
    Faq(
        title: 'How will interest be calculated if I make a part payment?',
        description:
            "If you partly pay your loan amount then interest will be charged only on the remaining Principal balance after part-payment."),
    Faq(
        title: 'What happens if I am unable to make a loan payment?',
        description:
            "In case you are not able to make payment or miss making payment on due date, there will be reduction is rebate provided as per scheme mentioned in loan agreement and your effective rate of interest will increase Further, failure to repay the loan in the stipulated time will result in auctioning of your gold ornaments."),
    Faq(
        title: 'Do I need a guarantor to avail this loan?',
        description: "No, Guarantor is not required to avail Gold Loan."),
    Faq(
        title: 'What are the different modes of disbursement?',
        description:
            "Disbursement can happen by way of Cash, Demand Draft, Fund Transfer, NEFT & RTGS (to customer's other bank account)."),
    Faq(
        title: 'Are all gold items accepted?',
        description:
            "There is RBI Guidelines required to be followed while accepting Gold Ornaments for gold loan. Generally, only wearable gold ornaments from 18 k to 22 karat and bank minted coins (24 Karat) up to 50 Gms per customer can be funded.\n\nBorrower should confirm the same to the lender before availing the loan facility. If you are pledging your gold Jewellery, only the parts that are gold, will be considered for evaluation to ascertain net value\n\nMetals, stones and gems will be excluded from evaluation"),
    Faq(
        title: 'What is the assurance that the gold returned is the same?',
        description:
            "While processing the loan customer is been facilitated with sanction letter, Appraisal certificate, image of gold pledged along with a document (mentioning details related to count of articles, weight, etc \n\nWhenever a customer visits’ the branch for closure of gold loan he has to carry documents provided to him to confirm the pledged commodity"),
    Faq(
        title:
            'Do I need to be an existing customer of the Bank/NBFC to take gold loan?',
        description:
            "For availing Gold Loan, you need not be an existing customer\n\nNote: Borrower can repay their loan amount or due interest at any branch office but the pledged gold will be collected from the branch where the loan was taken"),
  ];

  List<Faq> get faqs => _faqs;

  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;
}

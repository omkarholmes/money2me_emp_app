import 'dart:convert';

import '../../../common/response_model.dart';
import 'document_type.dart';

ApiResponse<KYCDetails> kycDetailsFromJson(dynamic data) =>
    ApiResponse.fromJson(data, (value) {
      return KYCDetails.fromJson(value.first);
    });

class KYCDetails extends Serializable {
  String? partyId;
  String? partyfirstname;
  String? partymiddlename;
  String? partysurname;
  String? dob;
  String? fhname;
  String? fhmiddlename;
  String? fhsurname;
  String? nameasperpan;
  String? pandob;
  String? profilepicpath;
  String? mobileno;
  String? landlineno;
  String? emailid;
  String? flatno;
  String? permanentstreet;
  String? landmark;
  String? area;
  String? city;
  String? state;
  String? pincode;
  String? commflatno;
  String? commstreet;
  String? commlandmark;
  String? commcity;
  String? commarea;
  String? commstate;
  String? commpincode;
  String? bankname;
  String? branchname;
  String? accounttype;
  String? accountno;
  String? ifsccode;
  String? receipientname;
  List<DocumentType>? docuemnts;

  KYCDetails(
      {this.partyfirstname,
      this.partymiddlename,
      this.partysurname,
      this.dob,
      this.fhname,
      this.fhmiddlename,
      this.fhsurname,
      this.nameasperpan,
      this.pandob,
      this.profilepicpath,
      this.mobileno,
      this.landlineno,
      this.emailid,
      this.flatno,
      this.permanentstreet,
      this.landmark,
      this.area,
      this.city,
      this.state,
      this.pincode,
      this.commflatno,
      this.commstreet,
      this.commlandmark,
      this.commcity,
      this.commarea,
      this.commstate,
      this.commpincode,
      this.bankname,
      this.branchname,
      this.accounttype,
      this.accountno,
      this.ifsccode,
      this.receipientname});

  KYCDetails.fromJson(Map<String, dynamic> json) {
    partyfirstname = json['Partyfirstname'];
    partymiddlename = json['Partymiddlename'];
    partysurname = json['Partysurname'];
    dob = json['Dob'];
    fhname = json['Fhname'];
    fhmiddlename = json['Fhmiddlename'];
    fhsurname = json['Fhsurname'];
    nameasperpan = json['Nameasperpan'];
    pandob = json['Pandob'];
    profilepicpath = json['Profilepicpath'];
    mobileno = json['Mobileno'];
    landlineno = json['Landlineno'];
    emailid = json['Emailid'];
    flatno = json['Flatno'];
    permanentstreet = json['Permanentstreet'];
    landmark = json['Landmark'];
    area = json['Area'];
    city = json['City'];
    state = json['State'];
    pincode = json['Pincode'];
    commflatno = json['Commflatno'];
    commstreet = json['Commstreet'];
    commlandmark = json['Commlandmark'];
    commcity = json['Commcity'];
    commarea = json['Commarea'];
    commstate = json['Commstate'];
    commpincode = json['Commpincode'];
    bankname = json['Bankname'];
    branchname = json['Branchname'];
    accounttype = json['Accounttype'];
    accountno = json['Accountno'];
    ifsccode = json['Ifsccode'];
    receipientname = json['Receipientname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Partyfirstname'] = this.partyfirstname;
    data['Partymiddlename'] = this.partymiddlename;
    data['Partysurname'] = this.partysurname;
    data['Dob'] = this.dob;
    data['Fhname'] = this.fhname;
    data['Fhmiddlename'] = this.fhmiddlename;
    data['Fhsurname'] = this.fhsurname;
    data['Nameasperpan'] = this.nameasperpan;
    data['Pandob'] = this.pandob;
    data['Profilepicpath'] = this.profilepicpath;
    data['Mobileno'] = this.mobileno;
    data['Landlineno'] = this.landlineno;
    data['Emailid'] = this.emailid;
    data['Flatno'] = this.flatno;
    data['Permanentstreet'] = this.permanentstreet;
    data['Landmark'] = this.landmark;
    data['Area'] = this.area;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Pincode'] = this.pincode;
    data['Commflatno'] = this.commflatno;
    data['Commstreet'] = this.commstreet;
    data['Commlandmark'] = this.commlandmark;
    data['Commcity'] = this.commcity;
    data['Commarea'] = this.commarea;
    data['Commstate'] = this.commstate;
    data['Commpincode'] = this.commpincode;
    data['Bankname'] = this.bankname;
    data['Branchname'] = this.branchname;
    data['Accounttype'] = this.accounttype;
    data['Accountno'] = this.accountno;
    data['Ifsccode'] = this.ifsccode;
    data['Receipientname'] = this.receipientname;
    data["documents"] = docuemnts;
    return data;
  }

  PartyChangeRequest toPartyChaangeRequest() {
    PartyChangeRequest data = PartyChangeRequest();
    // data.partyid = this.;
    data.partyid = this.partyId;
    data.newprofilepicpath = this.profilepicpath;
    data.newmobno = this.mobileno;
    data.newaltmobno = this.landlineno;
    data.newemailid = this.emailid;
    data.newflatno = this.flatno;
    data.newstreet = this.permanentstreet;
    data.newlandmark = this.landmark;
    data.newarea = this.area;
    data.newcity = this.city;
    data.newpincode = this.pincode;
    data.newbankname = this.bankname;
    data.newbranchname = this.branchname;
    data.newaccountno = this.accountno;
    data.newifsccode = this.ifsccode;
    data.newreceipientname = this.receipientname;
    data.jsondocdetails = jsonEncode(this
        .docuemnts!
        .map(
          (e) => {
            "Doctypename": e.documentname,
            "Expirydate": e.expirydate,
            "Docpath": e.filePath,
            "Documentid": e.documentID
          },
        )
        .toList());
    return data;
  }
}

class PartyChangeRequest {
  String? partyid;
  String? newprofilepicpath;
  String? newmobno;
  String? newaltmobno;
  String? newemailid;
  String? newflatno;
  String? newstreet;
  String? newlandmark;
  String? newarea;
  String? newcity;
  String? newpincode;
  String? newbankname;
  String? newbranchname;
  String? newaccountno;
  String? newifsccode;
  String? newreceipientname;
  String? jsondocdetails;

  PartyChangeRequest(
      {this.partyid,
      this.newprofilepicpath,
      this.newmobno,
      this.newaltmobno,
      this.newemailid,
      this.newflatno,
      this.newstreet,
      this.newlandmark,
      this.newarea,
      this.newcity,
      this.newpincode,
      this.newbankname,
      this.newbranchname,
      this.newaccountno,
      this.newifsccode,
      this.newreceipientname,
      this.jsondocdetails});

  PartyChangeRequest.fromJson(Map<String, dynamic> json) {
    partyid = json['Partyid'];
    newprofilepicpath = json['Newprofilepicpath'];
    newmobno = json['Newmobno'];
    newaltmobno = json['Newaltmobno'];
    newemailid = json['Newemailid'];
    newflatno = json['Newflatno'];
    newstreet = json['Newstreet'];
    newlandmark = json['Newlandmark'];
    newarea = json['Newarea'];
    newcity = json['Newcity'];
    newpincode = json['Newpincode'];
    newbankname = json['Newbankname'];
    newbranchname = json['Newbranchname'];
    newaccountno = json['Newaccountno'];
    newifsccode = json['Newifsccode'];
    newreceipientname = json['Newreceipientname'];
    jsondocdetails = json['jsondocdetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Partyid'] = this.partyid;
    data['Newprofilepicpath'] = this.newprofilepicpath;
    data['Newmobno'] = this.newmobno;
    data['Newaltmobno'] = this.newaltmobno;
    data['Newemailid'] = this.newemailid;
    data['Newflatno'] = this.newflatno;
    data['Newstreet'] = this.newstreet;
    data['Newlandmark'] = this.newlandmark;
    data['Newarea'] = this.newarea;
    data['Newcity'] = this.newcity;
    data['Newpincode'] = this.newpincode;
    data['Newbankname'] = this.newbankname;
    data['Newbranchname'] = this.newbranchname;
    data['Newaccountno'] = this.newaccountno;
    data['Newifsccode'] = this.newifsccode;
    data['Newreceipientname'] = this.newreceipientname;
    data['jsondocdetails'] = this.jsondocdetails;
    return data;
  }
}

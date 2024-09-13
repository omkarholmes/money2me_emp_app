import 'package:money2me/common/response_model.dart';

ApiResponse<User> userFromJson(dynamic data) => ApiResponse.fromJson(data, (value)=> User.fromJson(value.first));
List<dynamic> userToJson(List<User> data) => List<dynamic>.from(data.map((x) => x.toJson()));

class User extends Serializable{
  String? branchId;
  int? partyId;
  String? partyCode;
  int? partyTypeId;
  String? partyTypeName;
  String? partyName;
  String? partyName1;
  String? partySurname;
  String? fhName;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? area;
  String? mobileNo;
  String? landlineNo;
  String? emailId;
  int? religiousBeliefId;
  String? name;
  int? educationId;
  String? educationName;
  int? resiStatusId;
  String? resiStatus;
  int? resiSince;
  int? categoryId;
  String? categoryName;
  int? companyTypeId;
  String? compTypeName;
  int? industryTypeId;
  String? domainName;
  int? businessSince;
  double? income;
  String? compAddress;
  String? compLandmark;
  String? compCity;
  String? compAddress4;
  String? compState;
  String? compPincode;
  int? documentId;
  String? identityName;
  String? identityNo;
  String? dob;
  int? age;
  int? actualAge;
  String? gender;
  int? maritalStatusId;
  String? maritalStatus;
  String? nominee;
  String? relation;
  String? refName1;
  String? contactNo1;
  String? refName2;
  String? contactNo2;
  String? landmark;
  String? compStdCode;
  String? compTeleNo;
  String? compExt;
  int? partyDocId;
  List<int>? partyImg;
  String? partyImgFilePath;
  String? adharNo;
  String? panNo;
  String? commAddress1;
  String? commAddress2;
  String? commAddress3;
  String? commAddress4;
  String? commState;
  String? commPincode;
  dynamic riskCategory;
  bool? sameAddress;
  dynamic riskCategoryId;
  String? partyBankName;
  String? partyBranchName;
  String? partyRecipientName;
  String? partyAccountNo;
  String? partyIfscCode;
  String? partyUpi;
  String? nomineeSurName;
  String? nomineeFhName;
  String? nomineeGender;
  String? nomineeDob;
  int? nomineeAge;
  String? gaurdianName;
  String? gaurdianSurName;
  String? gaurdianFhName;
  dynamic gaurdianGender;
  dynamic gaurdianDob;
  int? gaurdianAge;
  String? gaurdianRelation;
  bool? emailVerified;
  int? approved;
  int? form60;
  String? bankBeneName;
  String? bankRef;
  String? bankStatus;
  String? bankRemark;
  String? msgremakrs;
  dynamic typeofVehicle;
  dynamic typeofPolicy;
  String? partyprofilepic;
  String? partyfullname;
  bool? isMpinSet;

  User({
    this.branchId,
    this.partyId,
    this.partyCode,
    this.partyTypeId,
    this.partyTypeName,
    this.partyName,
    this.partyName1,
    this.partySurname,
    this.fhName,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.area,
    this.mobileNo,
    this.landlineNo,
    this.emailId,
    this.religiousBeliefId,
    this.name,
    this.educationId,
    this.educationName,
    this.resiStatusId,
    this.resiStatus,
    this.resiSince,
    this.categoryId,
    this.categoryName,
    this.companyTypeId,
    this.compTypeName,
    this.industryTypeId,
    this.domainName,
    this.businessSince,
    this.income,
    this.compAddress,
    this.compLandmark,
    this.compCity,
    this.compAddress4,
    this.compState,
    this.compPincode,
    this.documentId,
    this.identityName,
    this.identityNo,
    this.dob,
    this.age,
    this.actualAge,
    this.gender,
    this.maritalStatusId,
    this.maritalStatus,
    this.nominee,
    this.relation,
    this.refName1,
    this.contactNo1,
    this.refName2,
    this.contactNo2,
    this.landmark,
    this.compStdCode,
    this.compTeleNo,
    this.compExt,
    this.partyDocId,
    this.partyImg,
    this.partyImgFilePath,
    this.adharNo,
    this.panNo,
    this.commAddress1,
    this.commAddress2,
    this.commAddress3,
    this.commAddress4,
    this.commState,
    this.commPincode,
    this.riskCategory,
    this.sameAddress,
    this.riskCategoryId,
    this.partyBankName,
    this.partyBranchName,
    this.partyRecipientName,
    this.partyAccountNo,
    this.partyIfscCode,
    this.partyUpi,
    this.nomineeSurName,
    this.nomineeFhName,
    this.nomineeGender,
    this.nomineeDob,
    this.nomineeAge,
    this.gaurdianName,
    this.gaurdianSurName,
    this.gaurdianFhName,
    this.gaurdianGender,
    this.gaurdianDob,
    this.gaurdianAge,
    this.gaurdianRelation,
    this.emailVerified,
    this.approved,
    this.form60,
    this.bankBeneName,
    this.bankRef,
    this.bankStatus,
    this.bankRemark,
    this.msgremakrs,
    this.typeofVehicle,
    this.typeofPolicy,
    this.partyprofilepic,
    this.partyfullname,
    this.isMpinSet,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    branchId: json["BranchId"],
    partyId: json["PartyID"],
    partyCode: json["PartyCode"],
    partyTypeId: json["PartyTypeID"],
    partyTypeName: json["PartyTypeName"],
    partyName: json["PartyName"],
    partyName1: json["PartyName1"],
    partySurname: json["PartySurname"],
    fhName: json["FHName"],
    address: json["Address"],
    city: json["City"],
    state: json["State"],
    pincode: json["Pincode"],
    area: json["Area"],
    mobileNo: json["MobileNo"],
    landlineNo: json["LandlineNo"],
    emailId: json["EmailID"],
    religiousBeliefId: json["ReligiousBeliefID"],
    name: json["Name"],
    educationId: json["EducationID"],
    educationName: json["EducationName"],
    resiStatusId: json["ResiStatusID"],
    resiStatus: json["ResiStatus"],
    resiSince: json["ResiSince"],
    categoryId: json["CategoryID"],
    categoryName: json["CategoryName"],
    companyTypeId: json["CompanyTypeID"],
    compTypeName: json["CompTypeName"],
    industryTypeId: json["IndustryTypeID"],
    domainName: json["DomainName"],
    businessSince: json["BusinessSince"],
    income: json["Income"],
    compAddress: json["CompAddress"],
    compLandmark: json["CompLandmark"],
    compCity: json["CompCity"],
    compAddress4: json["CompAddress4"],
    compState: json["CompState"],
    compPincode: json["CompPincode"],
    documentId: json["DocumentID"],
    identityName: json["IdentityName"],
    identityNo: json["IdentityNo"],
    dob: json["DOB"],
    age: json["Age"],
    actualAge: json["ActualAge"],
    gender: json["Gender"],
    maritalStatusId: json["MaritalStatusID"],
    maritalStatus: json["MaritalStatus"],
    nominee: json["Nominee"],
    relation: json["Relation"],
    refName1: json["RefName1"],
    contactNo1: json["ContactNo1"],
    refName2: json["RefName2"],
    contactNo2: json["ContactNo2"],
    landmark: json["Landmark"],
    compStdCode: json["CompSTDCode"],
    compTeleNo: json["CompTeleNo"],
    compExt: json["CompExt"],
    partyDocId: json["PartyDocID"],
    partyImg: json["PartyImg"] == null ? [] : List<int>.from(json["PartyImg"]!.map((x) => x)),
    partyImgFilePath: json["PartyImgFilePath"],
    adharNo: json["AdharNo"],
    panNo: json["PanNo"],
    commAddress1: json["Comm_Address1"],
    commAddress2: json["Comm_Address2"],
    commAddress3: json["Comm_Address3"],
    commAddress4: json["Comm_Address4"],
    commState: json["Comm_State"],
    commPincode: json["Comm_Pincode"],
    riskCategory: json["RiskCategory"],
    sameAddress: json["SameAddress"],
    riskCategoryId: json["RiskCategoryId"],
    partyBankName: json["Party_BankName"],
    partyBranchName: json["Party_BranchName"],
    partyRecipientName: json["Party_RecipientName"],
    partyAccountNo: json["Party_AccountNo"],
    partyIfscCode: json["Party_IfscCode"],
    partyUpi: json["Party_UPI"],
    nomineeSurName: json["NomineeSurName"],
    nomineeFhName: json["NomineeFhName"],
    nomineeGender: json["NomineeGender"],
    nomineeDob: json["NomineeDOB"],
    nomineeAge: json["NomineeAge"],
    gaurdianName: json["GaurdianName"],
    gaurdianSurName: json["GaurdianSurName"],
    gaurdianFhName: json["GaurdianFhName"],
    gaurdianGender: json["GaurdianGender"],
    gaurdianDob: json["GaurdianDOB"],
    gaurdianAge: json["GaurdianAge"],
    gaurdianRelation: json["GaurdianRelation"],
    emailVerified: json["EmailVerified"],
    approved: json["Approved"],
    form60: json["Form60"],
    bankBeneName: json["bankBeneName"],
    bankRef: json["BankRef"],
    bankStatus: json["bankStatus"],
    bankRemark: json["bankRemark"],
    msgremakrs: json["msgremakrs"],
    typeofVehicle: json["TypeofVehicle"],
    typeofPolicy: json["TypeofPolicy"],
    partyprofilepic: json["Partyprofilepic"],
    partyfullname: json["Partyfullname"],
    isMpinSet: json["IsMpinSet"]=="true",
  );

  Map<String, dynamic> toJson() => {
    "BranchId": branchId,
    "PartyID": partyId,
    "PartyCode": partyCode,
    "PartyTypeID": partyTypeId,
    "PartyTypeName": partyTypeName,
    "PartyName": partyName,
    "PartyName1": partyName1,
    "PartySurname": partySurname,
    "FHName": fhName,
    "Address": address,
    "City": city,
    "State": state,
    "Pincode": pincode,
    "Area": area,
    "MobileNo": mobileNo,
    "LandlineNo": landlineNo,
    "EmailID": emailId,
    "ReligiousBeliefID": religiousBeliefId,
    "Name": name,
    "EducationID": educationId,
    "EducationName": educationName,
    "ResiStatusID": resiStatusId,
    "ResiStatus": resiStatus,
    "ResiSince": resiSince,
    "CategoryID": categoryId,
    "CategoryName": categoryName,
    "CompanyTypeID": companyTypeId,
    "CompTypeName": compTypeName,
    "IndustryTypeID": industryTypeId,
    "DomainName": domainName,
    "BusinessSince": businessSince,
    "Income": income,
    "CompAddress": compAddress,
    "CompLandmark": compLandmark,
    "CompCity": compCity,
    "CompAddress4": compAddress4,
    "CompState": compState,
    "CompPincode": compPincode,
    "DocumentID": documentId,
    "IdentityName": identityName,
    "IdentityNo": identityNo,
    "DOB": dob,
    "Age": age,
    "ActualAge": actualAge,
    "Gender": gender,
    "MaritalStatusID": maritalStatusId,
    "MaritalStatus": maritalStatus,
    "Nominee": nominee,
    "Relation": relation,
    "RefName1": refName1,
    "ContactNo1": contactNo1,
    "RefName2": refName2,
    "ContactNo2": contactNo2,
    "Landmark": landmark,
    "CompSTDCode": compStdCode,
    "CompTeleNo": compTeleNo,
    "CompExt": compExt,
    "PartyDocID": partyDocId,
    "PartyImg": partyImg == null ? [] : List<dynamic>.from(partyImg!.map((x) => x)),
    "PartyImgFilePath": partyImgFilePath,
    "AdharNo": adharNo,
    "PanNo": panNo,
    "Comm_Address1": commAddress1,
    "Comm_Address2": commAddress2,
    "Comm_Address3": commAddress3,
    "Comm_Address4": commAddress4,
    "Comm_State": commState,
    "Comm_Pincode": commPincode,
    "RiskCategory": riskCategory,
    "SameAddress": sameAddress,
    "RiskCategoryId": riskCategoryId,
    "Party_BankName": partyBankName,
    "Party_BranchName": partyBranchName,
    "Party_RecipientName": partyRecipientName,
    "Party_AccountNo": partyAccountNo,
    "Party_IfscCode": partyIfscCode,
    "Party_UPI": partyUpi,
    "NomineeSurName": nomineeSurName,
    "NomineeFhName": nomineeFhName,
    "NomineeGender": nomineeGender,
    "NomineeDOB": nomineeDob,
    "NomineeAge": nomineeAge,
    "GaurdianName": gaurdianName,
    "GaurdianSurName": gaurdianSurName,
    "GaurdianFhName": gaurdianFhName,
    "GaurdianGender": gaurdianGender,
    "GaurdianDOB": gaurdianDob,
    "GaurdianAge": gaurdianAge,
    "GaurdianRelation": gaurdianRelation,
    "EmailVerified": emailVerified,
    "Approved": approved,
    "Form60": form60,
    "bankBeneName": bankBeneName,
    "BankRef": bankRef,
    "bankStatus": bankStatus,
    "bankRemark": bankRemark,
    "msgremakrs": msgremakrs,
    "TypeofVehicle": typeofVehicle,
    "TypeofPolicy": typeofPolicy,
    "Partyprofilepic": partyprofilepic,
    "Partyfullname": partyfullname,
    "IsMpinSet": isMpinSet,
  };
}

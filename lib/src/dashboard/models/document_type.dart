import '../../../common/response_model.dart';

ListResponse<DocumentType> documentTypeFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
        data,
        (list) =>
            List<DocumentType>.from(list.map((x) => DocumentType.fromJson(x))));

class DocumentType extends Serializable {
  int? documentID;
  String? documentname;
  int? docUnderID;
  bool? hasExpirydate;
  String? expirydate;
  String? filePath;

  DocumentType(
      {this.documentID, this.documentname, this.docUnderID, this.expirydate});

  DocumentType.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    documentname = json['Documentname'];
    docUnderID = json['DocUnderID'];
    hasExpirydate = json['Expirydate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentID'] = this.documentID;
    data['Documentname'] = this.documentname;
    data['DocUnderID'] = this.docUnderID;
    data['Expirydate'] = this.expirydate;
    return data;
  }
}

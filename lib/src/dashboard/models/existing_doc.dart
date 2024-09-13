import '../../../common/response_model.dart';

ListResponse<ExistingDoc> existingDocsFromJson(Map<String, dynamic> data) =>
    ListResponse.fromJson(
        data,
        (list) =>
            List<ExistingDoc>.from(list.map((x) => ExistingDoc.fromJson(x))));

class ExistingDoc extends Serializable {
  int? docid;
  String? filetitle;
  String? expirydate;
  String? filepath;
  String? documentname;
  String? ttype;

  ExistingDoc(
      {this.docid,
      this.filetitle,
      this.expirydate,
      this.filepath,
      this.documentname,
      this.ttype});

  ExistingDoc.fromJson(Map<String, dynamic> json) {
    docid = json['Docid'];
    filetitle = json['Filetitle'];
    expirydate = json['Expirydate'];
    filepath = json['Filepath'];
    documentname = json['Documentname'];
    ttype = json['Ttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Docid'] = this.docid;
    data['Filetitle'] = this.filetitle;
    data['Expirydate'] = this.expirydate;
    data['Filepath'] = this.filepath;
    data['Documentname'] = this.documentname;
    data['Ttype'] = this.ttype;
    return data;
  }
}

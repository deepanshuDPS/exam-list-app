/// message : ""
/// status : false
/// data : {"termsTitles":["",""],"policyTitles":["",""],"termsConditions":["",""],"privacyPolicy":["",""]}

class TermsPolicyResponse {
  TermsPolicyResponse({
      String? message, 
      bool? status, 
      Data? data,}){
    _message = message;
    _status = status;
    _data = data;
}

  TermsPolicyResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  bool? _status;
  Data? _data;
TermsPolicyResponse copyWith({  String? message,
  bool? status,
  Data? data,
}) => TermsPolicyResponse(  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// termsTitles : ["",""]
/// policyTitles : ["",""]
/// termsConditions : ["",""]
/// privacyPolicy : ["",""]

class Data {
  Data({
      List<String>? termsTitles, 
      List<String>? policyTitles, 
      List<String>? termsConditions, 
      List<String>? privacyPolicy,}){
    _termsTitles = termsTitles;
    _policyTitles = policyTitles;
    _termsConditions = termsConditions;
    _privacyPolicy = privacyPolicy;
}

  Data.fromJson(dynamic json) {
    _termsTitles = json['termsTitles'] != null ? json['termsTitles'].cast<String>() : [];
    _policyTitles = json['policyTitles'] != null ? json['policyTitles'].cast<String>() : [];
    _termsConditions = json['termsConditions'] != null ? json['termsConditions'].cast<String>() : [];
    _privacyPolicy = json['privacyPolicy'] != null ? json['privacyPolicy'].cast<String>() : [];
  }
  List<String>? _termsTitles;
  List<String>? _policyTitles;
  List<String>? _termsConditions;
  List<String>? _privacyPolicy;
Data copyWith({  List<String>? termsTitles,
  List<String>? policyTitles,
  List<String>? termsConditions,
  List<String>? privacyPolicy,
}) => Data(  termsTitles: termsTitles ?? _termsTitles,
  policyTitles: policyTitles ?? _policyTitles,
  termsConditions: termsConditions ?? _termsConditions,
  privacyPolicy: privacyPolicy ?? _privacyPolicy,
);
  List<String>? get termsTitles => _termsTitles;
  List<String>? get policyTitles => _policyTitles;
  List<String>? get termsConditions => _termsConditions;
  List<String>? get privacyPolicy => _privacyPolicy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['termsTitles'] = _termsTitles;
    map['policyTitles'] = _policyTitles;
    map['termsConditions'] = _termsConditions;
    map['privacyPolicy'] = _privacyPolicy;
    return map;
  }

}
/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"doc_name":"48ca2b109dab51ba6d05bfe184b2f922.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Application Form","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/48ca2b109dab51ba6d05bfe184b2f922.jpg"},{"doc_name":"4adbbf4cafb74b441ae3a00acfd2d356.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Application Form","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/4adbbf4cafb74b441ae3a00acfd2d356.jpg"},{"doc_name":"ed51a591ecfd9919633230488d9ece04.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Agreement Form","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/ed51a591ecfd9919633230488d9ece04.jpg"},{"doc_name":"9157f9be3046591836034237ee3894eb.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Agreement Form","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/9157f9be3046591836034237ee3894eb.jpg"},{"doc_name":"350fad5456548b12b380a8e0f9f18603.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Agreement Form","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/350fad5456548b12b380a8e0f9f18603.jpg"},{"doc_name":"2edb5e42dd73651ec85f0659f1101d83.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Offer Page","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/2edb5e42dd73651ec85f0659f1101d83.jpg"},{"doc_name":"03de8954192032ef142e82c789ab4dc2.jpg","mime_type":"image/jpeg","company":"PHW","doc_type":"Credit Card Authorization","doc_url":"https://thepacificholidayworld.com/official/uploads/member_documents/03de8954192032ef142e82c789ab4dc2.jpg"}]

class DocumentsResponse {
  DocumentsResponse({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _code = code;
    _message = message;
    _data = data;
  }

  DocumentsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  num? _status;
  num? _code;
  String? _message;
  List<Data>? _data;

  DocumentsResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      DocumentsResponse(
        status: status ?? _status,
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get status => _status;

  num? get code => _code;

  String? get message => _message;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// doc_name : "48ca2b109dab51ba6d05bfe184b2f922.jpg"
/// mime_type : "image/jpeg"
/// company : "PHW"
/// doc_type : "Application Form"
/// doc_url : "https://thepacificholidayworld.com/official/uploads/member_documents/48ca2b109dab51ba6d05bfe184b2f922.jpg"

class Data {
  Data({
    String? docName,
    String? mimeType,
    String? company,
    String? docType,
    String? docUrl,
  }) {
    _docName = docName;
    _mimeType = mimeType;
    _company = company;
    _docType = docType;
    _docUrl = docUrl;
  }

  void setFilePath(String? filePath) {
    if (filePath != null) {
      _filePath = filePath;
      _isDownloaded = true;
    }
  }

  get isDownloaded => _isDownloaded;

  get filePath => _filePath;

  Data.fromJson(dynamic json) {
    _docName = json['doc_name'];
    _mimeType = json['mime_type'];
    _company = json['company'];
    _docType = json['doc_type'];
    _docUrl = json['doc_url'];
  }

  String? _docName;
  String? _mimeType;
  String? _company;
  String? _docType;
  String? _docUrl;
  bool _isDownloaded = false;
  String? _filePath;

  Data copyWith({
    String? docName,
    String? mimeType,
    String? company,
    String? docType,
    String? docUrl,
  }) =>
      Data(
        docName: docName ?? _docName,
        mimeType: mimeType ?? _mimeType,
        company: company ?? _company,
        docType: docType ?? _docType,
        docUrl: docUrl ?? _docUrl,
      );

  String? get docName => _docName;

  String? get mimeType => _mimeType;

  String? get company => _company;

  String? get docType => _docType;

  String? get docUrl => _docUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doc_name'] = _docName;
    map['mime_type'] = _mimeType;
    map['company'] = _company;
    map['doc_type'] = _docType;
    map['doc_url'] = _docUrl;
    return map;
  }
}

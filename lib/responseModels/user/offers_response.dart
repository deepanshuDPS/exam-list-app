/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"1","created_on":"2022-11-22 13:17:22","updated_on":null,"created_by":"1","mem_ms_num":"TESTER101","offer":"MOVIE FREE","v_from":"2022-11-25","v_to":"2022-11-30","detail":"test","book_date":"2022-12-23","status":"Booked","company":"PHW","cv_url":"https://thepacificholidayworld.com/official/uploads/vouchers/1669484178.pdf"}]

class OffersResponse {
  OffersResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  OffersResponse.fromJson(dynamic json) {
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
OffersResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => OffersResponse(  status: status ?? _status,
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

/// id : "1"
/// created_on : "2022-11-22 13:17:22"
/// updated_on : null
/// created_by : "1"
/// mem_ms_num : "TESTER101"
/// offer : "MOVIE FREE"
/// v_from : "2022-11-25"
/// v_to : "2022-11-30"
/// detail : "test"
/// book_date : "2022-12-23"
/// status : "Booked"
/// company : "PHW"
/// cv_url : "https://thepacificholidayworld.com/official/uploads/vouchers/1669484178.pdf"

class Data {
  Data({
      String? id, 
      String? createdOn, 
      dynamic updatedOn, 
      String? createdBy, 
      String? memMsNum, 
      String? offer, 
      String? vFrom, 
      String? vTo, 
      String? detail, 
      String? bookDate, 
      String? status, 
      String? company, 
      String? cvUrl,}){
    _id = id;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
    _createdBy = createdBy;
    _memMsNum = memMsNum;
    _offer = offer;
    _vFrom = vFrom;
    _vTo = vTo;
    _detail = detail;
    _bookDate = bookDate;
    _status = status;
    _company = company;
    _cvUrl = cvUrl;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _createdOn = json['created_on'];
    _updatedOn = json['updated_on'];
    _createdBy = json['created_by'];
    _memMsNum = json['mem_ms_num'];
    _offer = json['offer'];
    _vFrom = json['v_from'];
    _vTo = json['v_to'];
    _detail = json['detail'];
    _bookDate = json['book_date'];
    _status = json['status'];
    _company = json['company'];
    _cvUrl = json['cv_url'];
  }
  String? _id;
  String? _createdOn;
  dynamic _updatedOn;
  String? _createdBy;
  String? _memMsNum;
  String? _offer;
  String? _vFrom;
  String? _vTo;
  String? _detail;
  String? _bookDate;
  String? _status;
  String? _company;
  String? _cvUrl;
Data copyWith({  String? id,
  String? createdOn,
  dynamic updatedOn,
  String? createdBy,
  String? memMsNum,
  String? offer,
  String? vFrom,
  String? vTo,
  String? detail,
  String? bookDate,
  String? status,
  String? company,
  String? cvUrl,
}) => Data(  id: id ?? _id,
  createdOn: createdOn ?? _createdOn,
  updatedOn: updatedOn ?? _updatedOn,
  createdBy: createdBy ?? _createdBy,
  memMsNum: memMsNum ?? _memMsNum,
  offer: offer ?? _offer,
  vFrom: vFrom ?? _vFrom,
  vTo: vTo ?? _vTo,
  detail: detail ?? _detail,
  bookDate: bookDate ?? _bookDate,
  status: status ?? _status,
  company: company ?? _company,
  cvUrl: cvUrl ?? _cvUrl,
);
  String? get id => _id;
  String? get createdOn => _createdOn;
  dynamic get updatedOn => _updatedOn;
  String? get createdBy => _createdBy;
  String? get memMsNum => _memMsNum;
  String? get offer => _offer;
  String? get vFrom => _vFrom;
  String? get vTo => _vTo;
  String? get detail => _detail;
  String? get bookDate => _bookDate;
  String? get status => _status;
  String? get company => _company;
  String? get cvUrl => _cvUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_on'] = _createdOn;
    map['updated_on'] = _updatedOn;
    map['created_by'] = _createdBy;
    map['mem_ms_num'] = _memMsNum;
    map['offer'] = _offer;
    map['v_from'] = _vFrom;
    map['v_to'] = _vTo;
    map['detail'] = _detail;
    map['book_date'] = _bookDate;
    map['status'] = _status;
    map['company'] = _company;
    map['cv_url'] = _cvUrl;
    return map;
  }

}
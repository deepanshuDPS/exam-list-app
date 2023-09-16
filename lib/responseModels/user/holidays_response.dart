/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"2","created_on":"2022-11-19 15:55:06","updated_on":null,"created_by":"1","mem_ms_num":"TESTER101","night":"2","day":"3","v_from":"2023-11-01","v_to":"2024-10-31","location":"Jaipur","hotel":"Chokhi Dhani Ethnic Village Resort","book_date":"2022-11-25","status":"Booked","company":"PHW","cv_url":"https://thepacificholidayworld.com/official/uploads/vouchers/1669116313.pdf"},{"id":"194","created_on":"2022-11-22 16:51:34","updated_on":null,"created_by":"0","mem_ms_num":"TESTER101","night":"1","day":"2","v_from":"2023-11-01","v_to":"2024-10-31","location":"Agra","hotel":"Courtyard by Marriott Agra","book_date":"2023-02-23","status":"Booked","company":"PHW","cv_url":"https://thepacificholidayworld.com/official/uploads/vouchers/1676922601.pdf"},{"id":"1","created_on":"2022-11-19 15:55:06","updated_on":null,"created_by":"1","mem_ms_num":"TESTER101","night":"3","day":"4","v_from":"2022-11-01","v_to":"2023-10-31","location":null,"hotel":null,"book_date":null,"status":"Available","company":"PHW","cv_url":null}]

class HolidaysResponse {
  HolidaysResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  HolidaysResponse.fromJson(dynamic json) {
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
HolidaysResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => HolidaysResponse(  status: status ?? _status,
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

/// id : "2"
/// created_on : "2022-11-19 15:55:06"
/// updated_on : null
/// created_by : "1"
/// mem_ms_num : "TESTER101"
/// night : "2"
/// day : "3"
/// v_from : "2023-11-01"
/// v_to : "2024-10-31"
/// location : "Jaipur"
/// hotel : "Chokhi Dhani Ethnic Village Resort"
/// book_date : "2022-11-25"
/// status : "Booked"
/// company : "PHW"
/// cv_url : "https://thepacificholidayworld.com/official/uploads/vouchers/1669116313.pdf"

class Data {
  Data({
      String? id, 
      String? createdOn, 
      dynamic updatedOn, 
      String? createdBy, 
      String? memMsNum, 
      String? night, 
      String? day, 
      String? vFrom, 
      String? vTo, 
      String? location, 
      String? hotel, 
      String? bookDate, 
      String? status, 
      String? company, 
      String? cvUrl,}){
    _id = id;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
    _createdBy = createdBy;
    _memMsNum = memMsNum;
    _night = night;
    _day = day;
    _vFrom = vFrom;
    _vTo = vTo;
    _location = location;
    _hotel = hotel;
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
    _night = json['night'];
    _day = json['day'];
    _vFrom = json['v_from'];
    _vTo = json['v_to'];
    _location = json['location'];
    _hotel = json['hotel'];
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
  String? _night;
  String? _day;
  String? _vFrom;
  String? _vTo;
  String? _location;
  String? _hotel;
  String? _bookDate;
  String? _status;
  String? _company;
  String? _cvUrl;
Data copyWith({  String? id,
  String? createdOn,
  dynamic updatedOn,
  String? createdBy,
  String? memMsNum,
  String? night,
  String? day,
  String? vFrom,
  String? vTo,
  String? location,
  String? hotel,
  String? bookDate,
  String? status,
  String? company,
  String? cvUrl,
}) => Data(  id: id ?? _id,
  createdOn: createdOn ?? _createdOn,
  updatedOn: updatedOn ?? _updatedOn,
  createdBy: createdBy ?? _createdBy,
  memMsNum: memMsNum ?? _memMsNum,
  night: night ?? _night,
  day: day ?? _day,
  vFrom: vFrom ?? _vFrom,
  vTo: vTo ?? _vTo,
  location: location ?? _location,
  hotel: hotel ?? _hotel,
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
  String? get night => _night;
  String? get day => _day;
  String? get vFrom => _vFrom;
  String? get vTo => _vTo;
  String? get location => _location;
  String? get hotel => _hotel;
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
    map['night'] = _night;
    map['day'] = _day;
    map['v_from'] = _vFrom;
    map['v_to'] = _vTo;
    map['location'] = _location;
    map['hotel'] = _hotel;
    map['book_date'] = _bookDate;
    map['status'] = _status;
    map['company'] = _company;
    map['cv_url'] = _cvUrl;
    return map;
  }

}
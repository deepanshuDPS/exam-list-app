/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"status":"1","ms_num":"TESTER101","created_on":"2022-10-30 01:38:22","token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE2NDA5MDIsImV4cCI6MTY4NDIzMjkwMiwiaXNzIjoiUEhXIiwic3ViIjoiVEVTVEVSMTAxIiwiZGV2aWNlIjowLCJvcyI6IndlYiJ9.PYuH2PrA2Lrpxx3ANT_UmWOluyObDh34WFuFExFU4C4"}]

class LoginResponse {
  LoginResponse({
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

  LoginResponse.fromJson(dynamic json) {
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

  LoginResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      LoginResponse(
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

/// status : "1"
/// ms_num : "TESTER101"
/// created_on : "2022-10-30 01:38:22"
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE2NDA5MDIsImV4cCI6MTY4NDIzMjkwMiwiaXNzIjoiUEhXIiwic3ViIjoiVEVTVEVSMTAxIiwiZGV2aWNlIjowLCJvcyI6IndlYiJ9.PYuH2PrA2Lrpxx3ANT_UmWOluyObDh34WFuFExFU4C4"

class Data {
  Data(
      {String? status,
      String? msNum,
      String? createdOn,
      String? token,
      String? mobile}) {
    _status = status;
    _msNum = msNum;
    _createdOn = createdOn;
    _token = token;
    _mobile = mobile;
  }

  Data.fromJson(dynamic json) {
    _status = json['status'];
    _msNum = json['ms_num'];
    _createdOn = json['created_on'];
    _token = json['token'];
    _mobile = json['mobile'];
  }

  String? _status;
  String? _msNum;
  String? _createdOn;
  String? _token;
  String? _mobile;

  Data copyWith(
          {String? status,
          String? msNum,
          String? createdOn,
          String? token,
          String? mobile}) =>
      Data(
          status: status ?? _status,
          msNum: msNum ?? _msNum,
          createdOn: createdOn ?? _createdOn,
          token: token ?? _token,
          mobile: mobile ?? _mobile);

  String? get status => _status;

  String? get msNum => _msNum;

  String? get createdOn => _createdOn;

  String? get token => _token;

  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['ms_num'] = _msNum;
    map['created_on'] = _createdOn;
    map['token'] = _token;
    map['mobile'] = _mobile;
    return map;
  }
}

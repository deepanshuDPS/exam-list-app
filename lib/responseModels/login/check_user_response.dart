/// message : "successful"
/// status : true
/// data : {"_id":"anyid","mobile":"9843784378","onBoarded":false}

class CheckUserResponse {
  CheckUserResponse({
    String? message,
    bool? status,
    Data? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  CheckUserResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _message;
  bool? _status;
  Data? _data;

  CheckUserResponse copyWith({
    String? message,
    bool? status,
    Data? data,
  }) =>
      CheckUserResponse(
        message: message ?? _message,
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

/// _id : "anyid"
/// mobile : "9843784378"
/// onBoarded : false

class Data {
  Data({
    String? id,
    String? mobile,
    bool? onBoarded,
    String? customToken,
    int? accountType
  }) {
    _id = id;
    _mobile = mobile;
    _onBoarded = onBoarded;
    _customToken = customToken;
    _accountType = accountType;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _mobile = json['mobile'];
    _onBoarded = json['onBoarded'];
    _customToken = json['customToken'];
    _accountType = json['accountType'];
  }

  String? _id;
  String? _mobile;
  bool? _onBoarded;
  String? _customToken;
  int? _accountType;

  Data copyWith({
    String? id,
    String? mobile,
    bool? onBoarded,
    String? customToken,
    int? accountType
  }) =>
      Data(
        id: id ?? _id,
        mobile: mobile ?? _mobile,
        onBoarded: onBoarded ?? _onBoarded,
        customToken: customToken ?? _customToken,
        accountType: accountType ?? _accountType,
      );

  String? get id => _id;

  String? get mobile => _mobile;

  bool? get onBoarded => _onBoarded;

  int? get accountType => _accountType;

  String? get customToken => _customToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['mobile'] = _mobile;
    map['onBoarded'] = _onBoarded;
    map['customToken'] = _customToken;
    map['accountType'] = _accountType;
    return map;
  }
}

/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"9","created_on":"2022-11-13 17:58:02","updated_on":"2022-11-13 18:10:49","created_by":"11","issue_date":"2022-11-13","category":"Non-Member","subsidiary_id":"1","branch_id":"3","member_num":"","name":"VIJAY KUMAR","email":"avadrefrinery@gmail.com","phone":"9999377963","v_num":"PHW9999","v_price":"400","destination":"Agra\r\nJaipur\r\nKatra\r\nManali\r\nVrindavana","movie":"","holiday":"","status":"1","path":"https://official.thepacificholidayworld.com/uploads/vouchers/PHW9999.pdf"}]

class GlobalResponse {
  GlobalResponse({
      num? status, 
      num? code, 
      String? message,}){
    _status = status;
    _code = code;
    _message = message;
}

  GlobalResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];

  }
  num? _status;
  num? _code;
  String? _message;
GlobalResponse copyWith({  num? status,
  num? code,
  String? message,
}) => GlobalResponse(  status: status ?? _status,
  code: code ?? _code,
  message: message ?? _message,
);
  num? get status => _status;
  num? get code => _code;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }
}

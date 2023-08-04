import 'package:exam_list/responseModels/login/aspirant_data.dart';

/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"join_date":"2022-10-31","ms_num":"TESTER101","name":"Terster","email":"innovatoronline24x7@gmail.com","dob":"1989-10-30","marriage_anniversary":"1989-08-12","spouse":"","f_child_name":"","f_child_age":"0","s_child_name":"","s_child_age":"0","last_holiday":"","ms_category":"Test123","ms_year":"10","mobile":"8802628114","alt_mobile":"","address":"Dwarka, New Delhi","ms_amount":"100000","ms_advance":"0","ms_due":"0","ms_amc":"22","loc_id":"1","mem_subsidiary":"4r Season Holidays Pvt Ltd"}]

class AspirantProfileResponse {
  AspirantProfileResponse({
    bool? status,
    String? message,
    AspirantData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AspirantProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = AspirantData.fromJson(json['data']);
    }
  }

  bool? _status;
  String? _message;
  AspirantData? _data;

  AspirantProfileResponse copyWith({
    bool? status,
    String? message,
    AspirantData? data,
  }) =>
      AspirantProfileResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  AspirantData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data?.toJson();
    return map;
  }
}
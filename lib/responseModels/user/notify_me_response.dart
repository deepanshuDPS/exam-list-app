/// data : ["a1","a2"]
/// message : "successful"
/// status : true

class NotifyMeResponse {
  NotifyMeResponse({
    List<String>? data,
    String? message,
    bool? status,
  }) {
    _data = data;
    _message = message;
    _status = status;
  }

  NotifyMeResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? json['data'].cast<String>() : [];
    _message = json['message'];
    _status = json['status'];
  }

  List<String>? _data;
  String? _message;
  bool? _status;

  NotifyMeResponse copyWith({
    List<String>? data,
    String? message,
    bool? status,
  }) =>
      NotifyMeResponse(
        data: data ?? _data,
        message: message ?? _message,
        status: status ?? _status,
      );

  List<String>? get data => _data;

  String? get message => _message;

  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }
}

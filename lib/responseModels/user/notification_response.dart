/// message : "successful"
/// status : true
/// data : [{"_id":"","title":"","description":"","notificationType":"","imgUrl":"","adNumber":""}]

class NotificationResponse {
  NotificationResponse({
      String? message, 
      bool? status, 
      List<Notification>? data,}){
    _message = message;
    _status = status;
    _data = data;
}

  NotificationResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Notification.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _status;
  List<Notification>? _data;
NotificationResponse copyWith({  String? message,
  bool? status,
  List<Notification>? data,
}) => NotificationResponse(  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get status => _status;
  List<Notification>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : ""
/// title : ""
/// description : ""
/// notificationType : ""
/// imgUrl : ""
/// adNumber : ""

class Notification {
  Notification({
      String? id, 
      String? title, 
      String? description,
      num? notificationType,
      String? imgUrl, 
      String? adNumber,}){
    _id = id;
    _title = title;
    _description = description;
    _notificationType = notificationType;
    _imgUrl = imgUrl;
    _adNumber = adNumber;
}

  Notification.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _notificationType = json['notificationType'];
    _imgUrl = json['imgUrl'];
    _adNumber = json['adNumber'];
  }
  String? _id;
  String? _title;
  String? _description;
  num? _notificationType;
  String? _imgUrl;
  String? _adNumber;
Notification copyWith({  String? id,
  String? title,
  String? description,
  num? notificationType,
  String? imgUrl,
  String? adNumber,
}) => Notification(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  notificationType: notificationType ?? _notificationType,
  imgUrl: imgUrl ?? _imgUrl,
  adNumber: adNumber ?? _adNumber,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get notificationType => _notificationType;
  String? get imgUrl => _imgUrl;
  String? get adNumber => _adNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['notificationType'] = _notificationType;
    map['imgUrl'] = _imgUrl;
    map['adNumber'] = _adNumber;
    return map;
  }

}
/// _id : "id_Kudgi/02/2023_1"
/// title : "New Notifcation for New Exam"
/// description : "This is the new exam for you"
/// timestamp : "Sep 26, 2023, 6:42:02 PM"
/// actionButtonLabel : "View"
/// sender : "admin"
/// notificationType : 1
/// adNumber : "Kudgi/02/2023"
/// slug : "Kudgi022023"

class NotificationData {
  NotificationData({
      String? id, 
      String? title, 
      String? description, 
      String? timestamp, 
      String? actionButtonLabel, 
      String? sender, 
      num? notificationType, 
      String? adNumber, 
      String? slug,}){
    _id = id;
    _title = title;
    _description = description;
    _timestamp = timestamp;
    _actionButtonLabel = actionButtonLabel;
    _sender = sender;
    _notificationType = notificationType;
    _adNumber = adNumber;
    _slug = slug;
}

  NotificationData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _timestamp = json['timestamp'];
    _actionButtonLabel = json['actionButtonLabel'];
    _sender = json['sender'];
    _notificationType = json['notificationType'];
    _adNumber = json['adNumber'];
    _slug = json['slug'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _timestamp;
  String? _actionButtonLabel;
  String? _sender;
  num? _notificationType;
  String? _adNumber;
  String? _slug;
NotificationData copyWith({  String? id,
  String? title,
  String? description,
  String? timestamp,
  String? actionButtonLabel,
  String? sender,
  num? notificationType,
  String? adNumber,
  String? slug,
}) => NotificationData(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  timestamp: timestamp ?? _timestamp,
  actionButtonLabel: actionButtonLabel ?? _actionButtonLabel,
  sender: sender ?? _sender,
  notificationType: notificationType ?? _notificationType,
  adNumber: adNumber ?? _adNumber,
  slug: slug ?? _slug,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get timestamp => _timestamp;
  String? get actionButtonLabel => _actionButtonLabel;
  String? get sender => _sender;
  num? get notificationType => _notificationType;
  String? get adNumber => _adNumber;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['timestamp'] = _timestamp;
    map['actionButtonLabel'] = _actionButtonLabel;
    map['sender'] = _sender;
    map['notificationType'] = _notificationType;
    map['adNumber'] = _adNumber;
    map['slug'] = _slug;
    return map;
  }

}
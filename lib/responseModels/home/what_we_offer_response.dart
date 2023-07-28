/// Result : "success"
/// Msg : "Data Found"
/// data : [{"id":"1","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","name":"Flight","imageUrl":"flight.png","sequence":"1","status":"1"},{"id":"2","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","name":"Activities","imageUrl":"entertainment.png","sequence":"2","status":"1"},{"id":"3","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","name":"Stay","imageUrl":"stay.png","sequence":"3","status":"1"},{"id":"4","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","name":"Passport/Visa","imageUrl":"passport.png","sequence":"4","status":"1"},{"id":"5","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","name":"Sightseeing","imageUrl":"sightseeing.png","sequence":"5","status":"1"}]

class WhatWeOfferResponse {
  WhatWeOfferResponse({
    int? status,
    String? message,
    int? code,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  WhatWeOfferResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  int? _status;
  String? _message;
  int? _code;
  List<Data>? _data;

  WhatWeOfferResponse copyWith({
    int? status,
    String? message,
    List<Data>? data,
  }) =>
      WhatWeOfferResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  int? get status => _status;

  String? get message => _message;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// created_on : "2021-11-02 01:39:12"
/// updated_on : "2021-11-01 01:39:12"
/// use_type : "app"
/// name : "Flight"
/// imageUrl : "flight.png"
/// sequence : "1"
/// status : "1"

class Data {
  Data({
    String? name,
    String? imageUrl,
  }) {
    _name = name;
    _imageUrl = imageUrl;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _imageUrl = json['image_url'];
  }
  
  String? _name;
  String? _imageUrl;

  Data copyWith({
    String? name,
    String? imageUrl
  }) =>
      Data(
        name: name ?? _name,
        imageUrl: imageUrl ?? _imageUrl
      );

  String? get name => _name;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image_url'] = _imageUrl;
    return map;
  }
}

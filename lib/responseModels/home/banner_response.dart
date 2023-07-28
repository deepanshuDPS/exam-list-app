/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"1","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","image":"1.jpg","sequence":"1","status":"1"},{"id":"2","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","image":"2.jpg","sequence":"2","status":"1"},{"id":"3","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","image":"3.jpg","sequence":"3","status":"1"},{"id":"4","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","image":"4.jpg","sequence":"4","status":"1"},{"id":"5","created_on":"2021-11-02 01:39:12","updated_on":"2021-11-01 01:39:12","use_type":"app","image":"5.jpg","sequence":"5","status":"1"}]

class BannerResponse {
  BannerResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  BannerResponse.fromJson(dynamic json) {
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
BannerResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => BannerResponse(  status: status ?? _status,
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
/// created_on : "2021-11-02 01:39:12"
/// updated_on : "2021-11-01 01:39:12"
/// use_type : "app"
/// image : "1.jpg"
/// sequence : "1"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? createdOn, 
      String? updatedOn, 
      String? useType, 
      String? image, 
      String? sequence, 
      String? status,}){
    _id = id;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
    _useType = useType;
    _image = image;
    _sequence = sequence;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _createdOn = json['created_on'];
    _updatedOn = json['updated_on'];
    _useType = json['use_type'];
    _image = json['image'];
    _sequence = json['sequence'];
    _status = json['status'];
  }
  String? _id;
  String? _createdOn;
  String? _updatedOn;
  String? _useType;
  String? _image;
  String? _sequence;
  String? _status;
Data copyWith({  String? id,
  String? createdOn,
  String? updatedOn,
  String? useType,
  String? image,
  String? sequence,
  String? status,
}) => Data(  id: id ?? _id,
  createdOn: createdOn ?? _createdOn,
  updatedOn: updatedOn ?? _updatedOn,
  useType: useType ?? _useType,
  image: image ?? _image,
  sequence: sequence ?? _sequence,
  status: status ?? _status,
);
  String? get id => _id;
  String? get createdOn => _createdOn;
  String? get updatedOn => _updatedOn;
  String? get useType => _useType;
  String? get image => _image;
  String? get sequence => _sequence;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_on'] = _createdOn;
    map['updated_on'] = _updatedOn;
    map['use_type'] = _useType;
    map['image'] = _image;
    map['sequence'] = _sequence;
    map['status'] = _status;
    return map;
  }

}
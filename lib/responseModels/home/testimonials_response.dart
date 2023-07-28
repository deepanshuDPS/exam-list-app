class TestimonialsResponse {
  TestimonialsResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  TestimonialsResponse.fromJson(dynamic json) {
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
TestimonialsResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => TestimonialsResponse(  status: status ?? _status,
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

class Data {
  Data({
      String? id, 
      String? name, 
      String? feedback, 
      String? imageUrl,}){
    _id = id;
    _name = name;
    _feedback = feedback;
    _imageUrl = imageUrl;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _feedback = json['feedback'];
    _imageUrl = json['image_url'];
  }
  String? _id;
  String? _name;
  String? _feedback;
  String? _imageUrl;
Data copyWith({  String? id,
  String? name,
  String? feedback,
  String? imageUrl,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  feedback: feedback ?? _feedback,
  imageUrl: imageUrl ?? _imageUrl,
);
  String? get id => _id;
  String? get name => _name;
  String? get feedback => _feedback;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['feedback'] = _feedback;
    map['image_url'] = _imageUrl;
    return map;
  }

}
/// status : "success"
/// message : "Data Found"
/// code : 200
/// data : [{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/1.jpg"},{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/2.jpg"},{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/3.jpg"},{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/4.jpg"},{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/5.jpg"},{"image_url":"http://thepacificholidayworld.com/assets/images/preferred_partner/6.jpg"}]

class PartnersResponse {
  PartnersResponse({
    int? status,
    String? message,
    int? code,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _code = code ?? 0;
  }

  PartnersResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  int? _status;
  String? _message;
  int _code = 0;
  List<Data>? _data;

  PartnersResponse copyWith({
    int? status,
    String? message,
    List<Data>? data,
  }) =>
      PartnersResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  int? get result => _status;

  String? get msg => _message;

  bool get isSuccess => _status == 1;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Result'] = _status;
    map['Msg'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// image_url : "http://thepacificholidayworld.com/assets/images/preferred_partner/1.jpg"

class Data {
  Data({
    String? imageUrl,
  }) {
    _imageUrl = imageUrl;
  }

  Data.fromJson(dynamic json) {
    _imageUrl = json['image_url'];
  }

  String? _imageUrl;

  Data copyWith({
    String? imageUrl,
  }) =>
      Data(
        imageUrl: imageUrl ?? _imageUrl,
      );

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = _imageUrl;
    return map;
  }
}

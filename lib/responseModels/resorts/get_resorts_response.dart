/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"4","name":"Courtyard by Marriott Agra","slug":"courtyard-by-marriott-agra","main_image":"1605105106main.jpg","city":"Agra","category":"Domestic"},{"id":"210","name":"Grand Imperial Hotel","slug":"grand-imperial-hotel","main_image":"1597832985main.jpg","city":"Agra","category":"Domestic"},{"id":"223","name":"Double Tree By Hilton Agra","slug":"double-tree-by-hilton-agra","main_image":"1603116669main.jpg","city":"Agra","category":"Domestic"},{"id":"254","name":"Crystal Sarovar Premiere","slug":"crystal-sarovar-premiere","main_image":"1612692237main.jpg","city":"Agra","category":"Domestic"},{"id":"276","name":"Howard Plaza - The Fern","slug":"howard-plaza-the-fern","main_image":"1632383370main.jfif","city":"Agra","category":"Domestic"},{"id":"384","name":"Jaypee Palace Hotel &amp; Convention Centre - 5 Star Deluxe Hotel in Agra","slug":"jaypee-palace-hotel-amp-convention-centre-5-star-deluxe-hotel-in-agra","main_image":"1668150373main.jpg","city":"Agra","category":"Domestic"}]

class GetResortsResponse {
  GetResortsResponse({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _code = code;
    _message = message;
    _data = data;
  }

  GetResortsResponse.fromJson(dynamic json) {
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

  GetResortsResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      GetResortsResponse(
        status: status ?? _status,
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

/// id : "4"
/// name : "Courtyard by Marriott Agra"
/// slug : "courtyard-by-marriott-agra"
/// main_image : "1605105106main.jpg"
/// city : "Agra"
/// category : "Domestic"

class Data {
  Data({
    String? id,
    String? name,
    String? slug,
    String? mainImage,
    String? city,
    String? category,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _mainImage = mainImage;
    _city = city;
    _category = category;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _mainImage = json['main_image'];
    _city = json['city'];
    _category = json['category'];
  }

  String? _id;
  String? _name;
  String? _slug;
  String? _mainImage;
  String? _city;
  String? _category;

  Data copyWith({
    String? id,
    String? name,
    String? slug,
    String? mainImage,
    String? city,
    String? category,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        slug: slug ?? _slug,
        mainImage: mainImage ?? _mainImage,
        city: city ?? _city,
        category: category ?? _category,
      );

  String? get id => _id;

  String get name => _name?.replaceAll('&amp;', '&')??"--";

  String? get slug => _slug;

  String? get mainImage => _mainImage;

  String get image =>
      "https://thepacificholidayworld.com/uploads/resorts/" +
      (_mainImage ?? "");

  String? get city => _city;

  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['main_image'] = _mainImage;
    map['city'] = _city;
    map['category'] = _category;
    return map;
  }
}

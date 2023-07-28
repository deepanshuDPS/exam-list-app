/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"4","desti_category":"Domestic","desti_id":"22","name":"Courtyard by Marriott Agra","slug":"courtyard-by-marriott-agra","main_image":"1605105106main.jpg","descr":"Offering an outdoor swimming pool, a fitness centre and a spa and wellness centre, Courtyard Marriott Agra is located in Agra. It also has 4 dining options. The UNESCO World Heritage Site of the iconic Taj Mahal is 3.8 km.\r\n\r\nEach air-conditioned room here will provide you with a flat-screen satellite TV and a minibar. Featuring a bath or shower, private bathroom also comes with a hairdryer and bathrobes.\r\n\r\nAt Courtyard Marriott Agra you will find a 24-hour front desk, games room and a garden. Other facilities offered at the property include luggage storage, meeting/banqueting space and laundry. The property offers free parking. Guests can enjoy four dining options at the property - MoMo Cafe, Anise, Onyx and MoMo 2 Go.\r\n\r\nThe hotel is 6.3 km from the UNESCO World Heritage Site of Agra Fort, 10.5 km from the Mehtab Bagh and Tomb of Itimad-ud-Daulah. The Agra Cantonment Railway Station is 8.4 km and the Agra Airport is 1.9 km away.\r\n\r\nThis is our guests  favourite part of Agra, according to independent reviews.","longi":"","lati":"","address":"Ii, Fatehabad Rd, Taj Nagri Phase 2, Tajganj, Agra, Uttar Pradesh 282001","status":"1","city":"Agra","images":"16051061161resortImage.jpg,16051061162resortImage.jpg,16051061163resortImage.jpg,16051061164resortImage.jpg,16051061165resortImage.jpg,16051061166resortImage.jpg,16051062261resortImage.jpg,16051062262resortImage.jpg,16051062263resortImage.jpg,16051062264resortImage.jpg,16051062265resortImage.jpg,16051062266resortImage.jpg,16051062267resortImage.jpg,16051062268resortImage.jpg,16051062269resortImage.jpg"}]

class ResortResponse {
  ResortResponse({
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

  ResortResponse.fromJson(dynamic json) {
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

  ResortResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      ResortResponse(
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
/// desti_category : "Domestic"
/// desti_id : "22"
/// name : "Courtyard by Marriott Agra"
/// slug : "courtyard-by-marriott-agra"
/// main_image : "1605105106main.jpg"
/// descr : "Offering an outdoor swimming pool, a fitness centre and a spa and wellness centre, Courtyard Marriott Agra is located in Agra. It also has 4 dining options. The UNESCO World Heritage Site of the iconic Taj Mahal is 3.8 km.\r\n\r\nEach air-conditioned room here will provide you with a flat-screen satellite TV and a minibar. Featuring a bath or shower, private bathroom also comes with a hairdryer and bathrobes.\r\n\r\nAt Courtyard Marriott Agra you will find a 24-hour front desk, games room and a garden. Other facilities offered at the property include luggage storage, meeting/banqueting space and laundry. The property offers free parking. Guests can enjoy four dining options at the property - MoMo Cafe, Anise, Onyx and MoMo 2 Go.\r\n\r\nThe hotel is 6.3 km from the UNESCO World Heritage Site of Agra Fort, 10.5 km from the Mehtab Bagh and Tomb of Itimad-ud-Daulah. The Agra Cantonment Railway Station is 8.4 km and the Agra Airport is 1.9 km away.\r\n\r\nThis is our guests  favourite part of Agra, according to independent reviews."
/// longi : ""
/// lati : ""
/// address : "Ii, Fatehabad Rd, Taj Nagri Phase 2, Tajganj, Agra, Uttar Pradesh 282001"
/// status : "1"
/// city : "Agra"
/// images : "16051061161resortImage.jpg,16051061162resortImage.jpg,16051061163resortImage.jpg,16051061164resortImage.jpg,16051061165resortImage.jpg,16051061166resortImage.jpg,16051062261resortImage.jpg,16051062262resortImage.jpg,16051062263resortImage.jpg,16051062264resortImage.jpg,16051062265resortImage.jpg,16051062266resortImage.jpg,16051062267resortImage.jpg,16051062268resortImage.jpg,16051062269resortImage.jpg"

class Data {
  Data({
    String? id,
    String? destiCategory,
    String? destiId,
    String? name,
    String? slug,
    String? mainImage,
    String? descr,
    String? longi,
    String? lati,
    String? address,
    String? status,
    String? city,
    String? images,
  }) {
    _id = id;
    _destiCategory = destiCategory;
    _destiId = destiId;
    _name = name;
    _slug = slug;
    _mainImage = mainImage;
    _descr = descr;
    _longi = longi;
    _lati = lati;
    _address = address;
    _status = status;
    _city = city;
    _images = images;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _destiCategory = json['desti_category'];
    _destiId = json['desti_id'];
    _name = json['name'];
    _slug = json['slug'];
    _mainImage = json['main_image'];
    _descr = json['descr'];
    _longi = json['longi'];
    _lati = json['lati'];
    _address = json['address'];
    _status = json['status'];
    _city = json['city'];
    _images = json['images'];
  }

  String? _id;
  String? _destiCategory;
  String? _destiId;
  String? _name;
  String? _slug;
  String? _mainImage;
  String? _descr;
  String? _longi;
  String? _lati;
  String? _address;
  String? _status;
  String? _city;
  String? _images;

  Data copyWith({
    String? id,
    String? destiCategory,
    String? destiId,
    String? name,
    String? slug,
    String? mainImage,
    String? descr,
    String? longi,
    String? lati,
    String? address,
    String? status,
    String? city,
    String? images,
  }) =>
      Data(
        id: id ?? _id,
        destiCategory: destiCategory ?? _destiCategory,
        destiId: destiId ?? _destiId,
        name: name ?? _name,
        slug: slug ?? _slug,
        mainImage: mainImage ?? _mainImage,
        descr: descr ?? _descr,
        longi: longi ?? _longi,
        lati: lati ?? _lati,
        address: address ?? _address,
        status: status ?? _status,
        city: city ?? _city,
        images: images ?? _images,
      );

  String? get id => _id;

  String? get destiCategory => _destiCategory;

  String? get destiId => _destiId;

  String get name => _name?.replaceAll('&amp;', '&')??"--";

  String? get slug => _slug;

  String get mainImage =>
      "https://thepacificholidayworld.com/uploads/resorts/" +
          (_mainImage ?? "");

  String? get descr => _descr;

  String? get longi => _longi;

  String? get lati => _lati;

  String? get address => _address;

  String? get status => _status;

  String? get city => _city;

  List<String> get images {
    if (_images != null) {
      if (_images?.contains(",") == true) {
        return _images?.split(",") ?? [];
      } else {
        return [_images ?? ""];
      }
    }else{
      return [];
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['desti_category'] = _destiCategory;
    map['desti_id'] = _destiId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['main_image'] = _mainImage;
    map['descr'] = _descr;
    map['longi'] = _longi;
    map['lati'] = _lati;
    map['address'] = _address;
    map['status'] = _status;
    map['city'] = _city;
    map['images'] = _images;
    return map;
  }
}

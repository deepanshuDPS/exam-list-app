/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"sequence":0,"title":"Banners","list":[{"name":"","image":"1.jpg"},{"name":"","image":"2.jpg"},{"name":"","image":"3.jpg"},{"name":"","image":"4.jpg"},{"name":"","image":"5.jpg"}],"path":"https://thepacificholidayworld.com/uploads/api/banner"},{"sequence":1,"title":"Services","list":null,"path":null},{"sequence":2,"title":"My Membership","list":null,"path":null},{"sequence":3,"title":"Travel Associate","list":[{"name":"Make My Trip","image_url":"https://thepacificholidayworld.com/assets/images/travel_partner/1.jpg"},{"name":"Trivago","image_url":"https://thepacificholidayworld.com/assets/images/travel_partner/2.jpg"},{"name":"Goibibo","image_url":"https://thepacificholidayworld.com/assets/images/travel_partner/3.jpg"},{"name":"Booking.com","image_url":"https://thepacificholidayworld.com/assets/images/travel_partner/4.jpg"},{"name":"Agoda","image_url":"https://thepacificholidayworld.com/assets/images/travel_partner/5.jpg"}],"path":null},{"sequence":4,"title":"What We Offer","list":[{"name":"Activities","image_url":"https://thepacificholidayworld.com/uploads/api/whatweoffer/ic_activities.svg"},{"name":"Flights","image_url":"https://thepacificholidayworld.com/uploads/api/whatweoffer/ic_flights.svg"},{"name":"Passport","image_url":"https://thepacificholidayworld.com/uploads/api/whatweoffer/ic_passports.svg"},{"name":"Sightseeing","image_url":"https://thepacificholidayworld.com/uploads/api/whatweoffer/ic_sightseeing.svg"},{"name":"Stay","image_url":"https://thepacificholidayworld.com/uploads/api/whatweoffer/ic_stay.svg"}],"path":null},{"sequence":5,"title":"Preferred Associate","list":[{"name":"Book My Show","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/1.jpg"},{"name":"Sarovar Hotels","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/2.jpg"},{"name":"Royal Orchid Hotels","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/3.jpg"},{"name":"Regenta Hotel","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/4.jpg"},{"name":"Honeymoon Inn","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/5.jpg"},{"name":"Park Inn","image_url":"https://thepacificholidayworld.com/assets/images/preferred_partner/6.jpg"}],"path":null},{"sequence":6,"title":"Get In Touch","list":null,"path":null},{"sequence":7,"title":"Media Associate","list":[{"name":"ANI News","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/ANInews.png"},{"name":"Daily Hunt","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/dailyhunt.png"},{"name":"Hindustan Times","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/hindustantime.png"},{"name":"Outlook","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/outlook.png"},{"name":"The Prints","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/theprints.png"},{"name":"Zee News","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/zeenews.png"}],"path":null},{"sequence":8,"title":"Social Media","list":[{"name":"Facebook","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/ANInews.png","link":"https://www.facebook.com/thepacificholidayworld"},{"name":"Twitter","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/dailyhunt.png","link":"https://twitter.com/the_phw?s=21&t=Yf53_ls4dnfHT2nIJ0yCQA"},{"name":"Instagram","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/hindustantime.png","link":"https://www.instagram.com/the_exam_list/?igshid=Zjc2ZTc4Nzk%3D"},{"name":"Linkedin","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/outlook.png","link":"https://www.linkedin.com/company/the-pacific-holiday-world/"},{"name":"Youtube","image_url":"https://thepacificholidayworld.com/assets/images/media_partners/theprints.png","link":"https://www.youtube.com/@thepacificholidayworld"}],"path":null}]

class HomeResponse {
  HomeResponse({
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

  HomeResponse.fromJson(dynamic json) {
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

  HomeResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      HomeResponse(
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

/// sequence : 0
/// title : "Banners"
/// list : [{"name":"","image":"1.jpg"},{"name":"","image":"2.jpg"},{"name":"","image":"3.jpg"},{"name":"","image":"4.jpg"},{"name":"","image":"5.jpg"}]
/// path : "https://thepacificholidayworld.com/uploads/api/banner"

class Data {
  Data({
    num? sequence,
    String? title,
    List<RList>? list,
    String? path,
  }) {
    _sequence = sequence;
    _title = title;
    _list = list;
    _path = path;
  }

  Data.fromJson(dynamic json) {
    _sequence = json['sequence'];
    _title = json['title'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(RList.fromJson(v));
      });
    }
    _path = json['path'];
  }

  num? _sequence;
  String? _title;
  List<RList>? _list;
  String? _path;

  Data copyWith({
    num? sequence,
    String? title,
    List<RList>? list,
    String? path,
  }) =>
      Data(
        sequence: sequence ?? _sequence,
        title: title ?? _title,
        list: list ?? _list,
        path: path ?? _path,
      );

  num? get sequence => _sequence;

  String? get title => _title;

  List<RList>? get list => _list;

  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sequence'] = _sequence;
    map['title'] = _title;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    return map;
  }
}

/// name : ""
/// image : "1.jpg"

class RList {
  RList({String? name, String? image, String? imageUrl, String? link}) {
    _name = name;
    _image = image;
    _imageUrl = imageUrl;
    _link = link;
  }

  RList.fromJson(dynamic json) {
    _name = json['name'];
    _image = json['image'];
    _imageUrl = json['image_url'];
    _link = json['link'];
  }

  String? _name;
  String? _image;
  String? _imageUrl;
  String? _link;

  RList copyWith({
    String? name,
    String? image,
    String? imageUrl,
    String? link
  }) =>
      RList(
          name: name ?? _name,
          image: image ?? _image,
          imageUrl: imageUrl ?? _imageUrl,
          link: link ?? _link);

  String? get name => _name;

  String? get image => _image;

  String get imageUrl => _image ?? _imageUrl ?? "";

  String get link => _link ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image'] = _image;
    map['imageUrl'] = _imageUrl;
    map['link'] = _link;
    return map;
  }
}

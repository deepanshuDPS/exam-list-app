/// status : "success"
/// message : "Data Found"
/// data : [{"id":"22","name":"Agra","image":"1635159350desti.jpg"},{"id":"52","name":"Ahmedabad","image":"1578991701desti.jpg"},{"id":"37","name":"Alleppey","image":"1578988663desti.jpg"},{"id":"51","name":"Amritsar","image":"1578988448desti.jpg"},{"id":"259","name":"Andhra Pradesh","image":null},{"id":"101","name":"Auli","image":"1604774600desti.jpg"},{"id":"7","name":"Bangalore","image":"1578989322desti.jpg"},{"id":"94","name":"Bhubaneswar","image":"1583231528desti.jpg"},{"id":"54","name":"Chandigarh","image":"1578990748desti.jpg"},{"id":"53","name":"Chennai","image":"1578994448desti.jpg"},{"id":"114","name":"Coorg","image":"1603718315desti.jpg"},{"id":"84","name":"Darjeeling","image":"1578994784desti.jpg"},{"id":"55","name":"Dehradun","image":"1578995249desti.jpg"},{"id":"92","name":"Delhi","image":"1578995415desti.jpg"},{"id":"200","name":"Dharamshala","image":"1644744906desti.jpg"},{"id":"56","name":"Gangtok","image":"1578995854desti.jpg"},{"id":"30","name":"Goa","image":"1578996262desti.jpg"},{"id":"93","name":"Gurugram","image":"1578998422desti.jpg"},{"id":"252","name":"Gwalior","image":null},{"id":"57","name":"Haridwar","image":"1578999264desti.jpg"},{"id":"191","name":"Havelock","image":"1641278198desti.jpg"},{"id":"58","name":"Hyderabad","image":"1579075165desti.jpg"},{"id":"86","name":"Indore","image":"1579002273desti.jpg"},{"id":"24","name":"Jaipur","image":"1579002655desti.jpg"},{"id":"26","name":"Jaisalmer","image":"1579003158desti.jpg"},{"id":"257","name":"Jammu","image":null},{"id":"87","name":"Jim Corbett","image":"1579066177desti.jpg"},{"id":"61","name":"Jodhpur","image":"1579066591desti.jpg"},{"id":"250","name":"Karnataka","image":null},{"id":"111","name":"Katra","image":"1605104543desti.jpg"},{"id":"251","name":"Kerala","image":null},{"id":"38","name":"Kochi","image":"1579066782desti.jpg"},{"id":"120","name":"Kodaikanal","image":"1603713724desti.jpg"},{"id":"76","name":"Kolkata","image":"1579067386desti.jpg"},{"id":"35","name":"Kovalam","image":"1579067868desti.jpg"},{"id":"115","name":"Kufri","image":"1603714227desti.jpg"},{"id":"65","name":"Lucknow","image":"1579068443desti.jpg"},{"id":"66","name":"Ludhiana","image":"1579068673desti.jpg"},{"id":"88","name":"Mahabaleshwar","image":"1579069994desti.jpg"},{"id":"32","name":"Manali","image":"1579070388desti.jpg"},{"id":"113","name":"Mathura","image":"1605104125desti.jpg"},{"id":"27","name":"Mount Abu","image":"1579071010desti.png"},{"id":"68","name":"Mumbai","image":"1579073479desti.jpg"},{"id":"34","name":"Munnar","image":"1579073690desti.jpg"},{"id":"83","name":"Mussoorie","image":"1579074046desti.jpg"},{"id":"89","name":"Mysore","image":"1579074247desti.jpg"},{"id":"99","name":"Nainital","image":"1605104204desti.jpg"},{"id":"103","name":"Neemrana","image":"1599993255desti.jpg"},{"id":"258","name":"Neil Island","image":null},{"id":"85","name":"Ooty","image":"1579074782desti.jpg"},{"id":"69","name":"Poovar Island","image":"1578918613desti.jpg"},{"id":"77","name":"Port Blair","image":"1579155268desti.jpg"},{"id":"71","name":"Puducherry","image":"1579075722desti.jpg"},{"id":"70","name":"Pune","image":"1579075860desti.jpg"},{"id":"109","name":"Puri","image":"1602876649desti.png"},{"id":"108","name":"Pushkar","image":"1605104270desti.jpg"},{"id":"90","name":"Ranthambore","image":"1579076129desti.jpg"},{"id":"91","name":"Rishikesh","image":"1579076459desti.jpg"},{"id":"28","name":"Sariska","image":"1579156548desti.jpg"},{"id":"67","name":"Shimla","image":"1579077204desti.jpg"},{"id":"112","name":"Shirdi","image":"1605104348desti.jpg"},{"id":"72","name":"Srinagar","image":"1579077752desti.jpg"},{"id":"255","name":"Tamil Nadu","image":null},{"id":"48","name":"Thekkady","image":"1579078946desti.jpg"},{"id":"75","name":"Trivandram","image":"1579080518desti.jpg"},{"id":"31","name":"Udaipur","image":"1579080796desti.jpg"},{"id":"254","name":"Varanasi","image":null},{"id":"249","name":"Vrindavan","image":null},{"id":"119","name":"Yarcaud","image":"1603714048desti.jpg"}]

class AllPlacesResponse {
  AllPlacesResponse({
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

  AllPlacesResponse.fromJson(dynamic json) {
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

  AllPlacesResponse copyWith({
    int? status,
    String? message,
    List<Data>? data,
  }) =>
      AllPlacesResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  int? get status => _status;

  String? get message => _message;

  bool get isSuccess => _status == 1;

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

/// id : "22"
/// name : "Agra"
/// image : "1635159350desti.jpg"
///  "category": "String",
///  "name_slug": "String",

class Data {
  Data(
      {String? id,
      String? name,
      String? image,
      String? category,
      String? nameSlug}) {
    _id = id;
    _name = name;
    _image = image;
    _category = category;
    _nameSlug = nameSlug;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _category = json['category'];
    _nameSlug = json['name_slug'];
  }

  String? _id;
  String? _name;
  String? _image;
  String? _category;
  String? _nameSlug;

  Data copyWith(
          {String? id,
          String? name,
          String? image,
          String? category,
          String? nameSlug}) =>
      Data(
          id: id ?? _id,
          name: name ?? _name,
          image: image ?? _image,
          category: category ?? _category,
          nameSlug: nameSlug ?? _nameSlug);

  String? get id => _id;

  String? get name => _name;

  String get image => "https://thepacificholidayworld.com/uploads/destinations/"+(_image??"");

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['category'] = _category;
    map['name_slug'] = _nameSlug;
    return map;
  }
}

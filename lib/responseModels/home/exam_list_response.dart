import 'package:intl/intl.dart';

/// totalItems : 1
/// totalPages : 1
/// fetchTime : 1691841354581
/// data : [{"_id":"exam123","examName":"Sample Exam","adNumber":"2023/123","categoryTypes":["slug1","slug2"],"applicationStartDate":"2023-08-15T00:00:00Z","applicationEndDate":"2023-09-01T00:00:00Z","totalPosts":100,"noOfLevels":3,"categoryPosts":[{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"},{"name":"Category B","posts":"Post B1","gender":[1],"fee":75,"date":"2023-08-25T14:00:00Z","link":"https://example.com"}],"categoryFees":[{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"}],"notices":[{"name":"Important Notice","posts":"All Posts","gender":[],"fee":0,"date":"2023-08-10T08:00:00Z","link":"https://example.com/notice"}],"createdAt":"2023-07-01T10:00:00Z","updatedAt":"2023-08-01T15:00:00Z"}]

class ExamListResponse {
  ExamListResponse({
      num? totalItems, 
      num? totalPages, 
      num? fetchTime,
      bool? status,
      List<Data>? data,}){
    _totalItems = totalItems;
    _totalPages = totalPages;
    _fetchTime = fetchTime;
    _data = data;
}

  ExamListResponse.fromJson(dynamic json) {
    _totalItems = json['totalItems'];
    _totalPages = json['totalPages'];
    _fetchTime = json['fetchTime'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _totalItems;
  num? _totalPages;
  num? _fetchTime;
  List<Data>? _data;
  bool? _status;

ExamListResponse copyWith({  num? totalItems,
  num? totalPages,
  num? fetchTime,
  List<Data>? data,
  bool? status,
}) => ExamListResponse(  totalItems: totalItems ?? _totalItems,
  totalPages: totalPages ?? _totalPages,
  fetchTime: fetchTime ?? _fetchTime,
  data: data ?? _data,
  status: status ?? status,
);
  num? get totalItems => _totalItems;
  num? get totalPages => _totalPages;
  num? get fetchTime => _fetchTime;
  List<Data>? get data => _data;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalItems'] = _totalItems;
    map['totalPages'] = _totalPages;
    map['fetchTime'] = _fetchTime;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "exam123"
/// examName : "Sample Exam"
/// adNumber : "2023/123"
/// categoryTypes : ["slug1","slug2"]
/// applicationStartDate : "2023-08-15T00:00:00Z"
/// applicationEndDate : "2023-09-01T00:00:00Z"
/// totalPosts : 100
/// noOfLevels : 3
/// categoryPosts : [{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"},{"name":"Category B","posts":"Post B1","gender":[1],"fee":75,"date":"2023-08-25T14:00:00Z","link":"https://example.com"}]
/// categoryFees : [{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"}]
/// notices : [{"name":"Important Notice","posts":"All Posts","gender":[],"fee":0,"date":"2023-08-10T08:00:00Z","link":"https://example.com/notice"}]
/// createdAt : "2023-07-01T10:00:00Z"
/// updatedAt : "2023-08-01T15:00:00Z"

class Data {
  Data({
      String? id, 
      String? examName, 
      String? adNumber, 
      List<String>? categoryTypes, 
      String? applicationStartDate, 
      String? applicationEndDate, 
      num? totalPosts, 
      num? noOfLevels, 
      List<CategoryPosts>? categoryPosts, 
      List<CategoryFees>? categoryFees, 
      List<Notices>? notices, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _examName = examName;
    _adNumber = adNumber;
    _categoryTypes = categoryTypes;
    _applicationStartDate = applicationStartDate;
    _applicationEndDate = applicationEndDate;
    _totalPosts = totalPosts;
    _noOfLevels = noOfLevels;
    _categoryPosts = categoryPosts;
    _categoryFees = categoryFees;
    _notices = notices;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _examName = json['examName'];
    _adNumber = json['adNumber'];
    _categoryTypes = json['categoryTypes'] != null ? json['categoryTypes'].cast<String>() : [];
    _applicationStartDate = json['applicationStartDate'];
    _applicationEndDate = json['applicationEndDate'];
    _totalPosts = json['totalPosts'];
    _noOfLevels = json['noOfLevels'];
    if (json['categoryPosts'] != null) {
      _categoryPosts = [];
      json['categoryPosts'].forEach((v) {
        _categoryPosts?.add(CategoryPosts.fromJson(v));
      });
    }
    if (json['categoryFees'] != null) {
      _categoryFees = [];
      json['categoryFees'].forEach((v) {
        _categoryFees?.add(CategoryFees.fromJson(v));
      });
    }
    if (json['notices'] != null) {
      _notices = [];
      json['notices'].forEach((v) {
        _notices?.add(Notices.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _examName;
  String? _adNumber;
  List<String>? _categoryTypes;
  String? _applicationStartDate;
  String? _applicationEndDate;
  num? _totalPosts;
  num? _noOfLevels;
  List<CategoryPosts>? _categoryPosts;
  List<CategoryFees>? _categoryFees;
  List<Notices>? _notices;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? examName,
  String? adNumber,
  List<String>? categoryTypes,
  String? applicationStartDate,
  String? applicationEndDate,
  num? totalPosts,
  num? noOfLevels,
  List<CategoryPosts>? categoryPosts,
  List<CategoryFees>? categoryFees,
  List<Notices>? notices,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  examName: examName ?? _examName,
  adNumber: adNumber ?? _adNumber,
  categoryTypes: categoryTypes ?? _categoryTypes,
  applicationStartDate: applicationStartDate ?? _applicationStartDate,
  applicationEndDate: applicationEndDate ?? _applicationEndDate,
  totalPosts: totalPosts ?? _totalPosts,
  noOfLevels: noOfLevels ?? _noOfLevels,
  categoryPosts: categoryPosts ?? _categoryPosts,
  categoryFees: categoryFees ?? _categoryFees,
  notices: notices ?? _notices,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get examName => _examName;
  String? get adNumber => _adNumber;
  List<String>? get categoryTypes => _categoryTypes;
  String? get applicationStartDate => _applicationStartDate;
  String? get formatAppStartDate {
    if(_applicationStartDate!=null){
      final parsedDateTime = DateTime.parse(_applicationStartDate!);
      final formattedDate = DateFormat.yMMMMd().format(parsedDateTime); // August 10, 2023
      return formattedDate;
    } else {
      return "";
    }
  }
  String? get applicationEndDate => _applicationEndDate;
  String? get formatAppEndDate {
    if(_applicationEndDate!=null){
      final parsedDateTime = DateTime.parse(_applicationEndDate!);
      final formattedDate = DateFormat.yMMMMd().format(parsedDateTime); // August 10, 2023
      final formattedTime = DateFormat.jm().format(parsedDateTime);
      return '$formattedDate, $formattedTime';
    } else {
      return "";
    }
  }
  num? get totalPosts => _totalPosts;
  num? get noOfLevels => _noOfLevels;
  List<CategoryPosts>? get categoryPosts => _categoryPosts;
  List<CategoryFees>? get categoryFees => _categoryFees;
  List<Notices>? get notices => _notices;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['examName'] = _examName;
    map['adNumber'] = _adNumber;
    map['categoryTypes'] = _categoryTypes;
    map['applicationStartDate'] = _applicationStartDate;
    map['applicationEndDate'] = _applicationEndDate;
    map['totalPosts'] = _totalPosts;
    map['noOfLevels'] = _noOfLevels;
    if (_categoryPosts != null) {
      map['categoryPosts'] = _categoryPosts?.map((v) => v.toJson()).toList();
    }
    if (_categoryFees != null) {
      map['categoryFees'] = _categoryFees?.map((v) => v.toJson()).toList();
    }
    if (_notices != null) {
      map['notices'] = _notices?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// name : "Important Notice"
/// posts : "All Posts"
/// gender : []
/// fee : 0
/// date : "2023-08-10T08:00:00Z"
/// link : "https://example.com/notice"

class Notices {
  Notices({
      String? name, 
      String? posts, 
      List<num>? gender,
      num? fee, 
      String? date, 
      String? link,}){
    _name = name;
    _posts = posts;
    _gender = gender;
    _fee = fee;
    _date = date;
    _link = link;
}

  Notices.fromJson(dynamic json) {
    _name = json['name'];
    _posts = json['posts'];
    _gender = json['gender'] != null ? json['gender'].cast<num>() : [];
    _fee = json['fee'];
    _date = json['date'];
    _link = json['link'];
  }
  String? _name;
  String? _posts;
  List<num>? _gender;
  num? _fee;
  String? _date;
  String? _link;
Notices copyWith({  String? name,
  String? posts,
  List<num>? gender,
  num? fee,
  String? date,
  String? link,
}) => Notices(  name: name ?? _name,
  posts: posts ?? _posts,
  gender: gender ?? _gender,
  fee: fee ?? _fee,
  date: date ?? _date,
  link: link ?? _link,
);
  String? get name => _name;
  String? get posts => _posts;
  List<dynamic>? get gender => _gender;
  num? get fee => _fee;
  String? get date => _date;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['posts'] = _posts;
    map['gender'] = _gender;
    map['fee'] = _fee;
    map['date'] = _date;
    map['link'] = _link;
    return map;
  }

}

/// name : "Category A"
/// posts : "Post A1"
/// gender : [1,2]
/// fee : 50
/// date : "2023-08-20T10:00:00Z"
/// link : "https://example.com"

class CategoryFees {
  CategoryFees({
      String? name, 
      String? posts, 
      List<num>? gender, 
      num? fee, 
      String? date, 
      String? link,}){
    _name = name;
    _posts = posts;
    _gender = gender;
    _fee = fee;
    _date = date;
    _link = link;
}

  CategoryFees.fromJson(dynamic json) {
    _name = json['name'];
    _posts = json['posts'];
    _gender = json['gender'] != null ? json['gender'].cast<num>() : [];
    _fee = json['fee'];
    _date = json['date'];
    _link = json['link'];
  }
  String? _name;
  String? _posts;
  List<num>? _gender;
  num? _fee;
  String? _date;
  String? _link;
CategoryFees copyWith({  String? name,
  String? posts,
  List<num>? gender,
  num? fee,
  String? date,
  String? link,
}) => CategoryFees(  name: name ?? _name,
  posts: posts ?? _posts,
  gender: gender ?? _gender,
  fee: fee ?? _fee,
  date: date ?? _date,
  link: link ?? _link,
);
  String? get name => _name;
  String? get posts => _posts;
  List<num>? get gender => _gender;
  num? get fee => _fee;
  String? get date => _date;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['posts'] = _posts;
    map['gender'] = _gender;
    map['fee'] = _fee;
    map['date'] = _date;
    map['link'] = _link;
    return map;
  }

}

/// name : "Category A"
/// posts : "Post A1"
/// gender : [1,2]
/// fee : 50
/// date : "2023-08-20T10:00:00Z"
/// link : "https://example.com"

class CategoryPosts {
  CategoryPosts({
      String? name, 
      String? posts, 
      List<num>? gender, 
      num? fee, 
      String? date, 
      String? link,}){
    _name = name;
    _posts = posts;
    _gender = gender;
    _fee = fee;
    _date = date;
    _link = link;
}

  CategoryPosts.fromJson(dynamic json) {
    _name = json['name'];
    _posts = json['posts'];
    _gender = json['gender'] != null ? json['gender'].cast<num>() : [];
    _fee = json['fee'];
    _date = json['date'];
    _link = json['link'];
  }
  String? _name;
  String? _posts;
  List<num>? _gender;
  num? _fee;
  String? _date;
  String? _link;
CategoryPosts copyWith({  String? name,
  String? posts,
  List<num>? gender,
  num? fee,
  String? date,
  String? link,
}) => CategoryPosts(  name: name ?? _name,
  posts: posts ?? _posts,
  gender: gender ?? _gender,
  fee: fee ?? _fee,
  date: date ?? _date,
  link: link ?? _link,
);
  String? get name => _name;
  String? get posts => _posts;
  List<num>? get gender => _gender;
  num? get fee => _fee;
  String? get date => _date;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['posts'] = _posts;
    map['gender'] = _gender;
    map['fee'] = _fee;
    map['date'] = _date;
    map['link'] = _link;
    return map;
  }

}
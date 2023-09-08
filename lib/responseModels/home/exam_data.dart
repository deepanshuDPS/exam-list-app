import 'package:intl/intl.dart';

class ExamData {
  ExamData(
      {String? id,
      String? examName,
      String? adNumber,
      List<num>? categoryTypes,
      String? applicationStartDate,
      String? applicationEndDate,
      num? totalPosts,
      num? noOfLevels,
      List<Extras>? categoryPosts,
      List<Extras>? categoryFees,
      List<Extras>? notices,
      String? createdAt,
      String? updatedAt,
      String? minAgeDate,
      String? maxAgeDate,
      List<num>? addQualifications,
      num? maxQualification,
      bool? filtered,
      bool? parent}) {
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
    _minAgeDate = minAgeDate;
    _maxAgeDate = maxAgeDate;
    _addQualifications = addQualifications;
    _maxQualification = maxQualification;
    _filtered = filtered;
    _parent = parent;
  }

  ExamData.fromJson(dynamic json) {
    _id = json['_id'];
    _examName = json['examName'];
    _adNumber = json['adNumber'];
    _categoryTypes =
        json['categoryTypes'] != null ? json['categoryTypes'].cast<num>() : [];
    _applicationStartDate = json['applicationStartDate'];
    _applicationEndDate = json['applicationEndDate'];
    _totalPosts = json['totalPosts'];
    _noOfLevels = json['noOfLevels'];
    if (json['categoryPosts'] != null) {
      _categoryPosts = [];
      json['categoryPosts'].forEach((v) {
        _categoryPosts?.add(Extras.fromJson(v));
      });
    }
    if (json['categoryFees'] != null) {
      _categoryFees = [];
      json['categoryFees'].forEach((v) {
        _categoryFees?.add(Extras.fromJson(v));
      });
    }
    if (json['notices'] != null) {
      _notices = [];
      json['notices'].forEach((v) {
        _notices?.add(Extras.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _minAgeDate = json['minAgeDate'];
    _maxAgeDate = json['maxAgeDate'];
    _addQualifications = json['addQualifications'] != null
        ? json['addQualifications'].cast<num>()
        : [];
    _maxQualification = json['maxQualification'];
    _filtered = json['filtered'];
    _parent = json['parent'];
  }

  String? _id;
  String? _examName;
  String? _adNumber;
  List<num>? _categoryTypes;
  String? _applicationStartDate;
  String? _applicationEndDate;
  num? _totalPosts;
  num? _noOfLevels;
  List<Extras>? _categoryPosts;
  List<Extras>? _categoryFees;
  List<Extras>? _notices;
  String? _createdAt;
  String? _updatedAt;
  String? _minAgeDate;
  String? _maxAgeDate;
  List<num>? _addQualifications;
  num? _maxQualification;
  bool? _filtered;
  bool? _parent;
  List<ExamData> _childExams = [];

  ExamData copyWith(
          {String? id,
          String? examName,
          String? adNumber,
          List<num>? categoryTypes,
          String? applicationStartDate,
          String? applicationEndDate,
          num? totalPosts,
          num? noOfLevels,
          List<Extras>? categoryPosts,
          List<Extras>? categoryFees,
          List<Extras>? notices,
          String? createdAt,
          String? updatedAt,
          String? minAgeDate,
          String? maxAgeDate,
          List<num>? addQualifications,
          num? maxQualification,
          bool? filtered,
          bool? parent}) =>
      ExamData(
          id: id ?? _id,
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
          minAgeDate: minAgeDate ?? _minAgeDate,
          maxAgeDate: maxAgeDate ?? _maxAgeDate,
          addQualifications: addQualifications ?? _addQualifications,
          maxQualification: maxQualification ?? _maxQualification,
          filtered: filtered ?? _filtered,
          parent: parent ?? _parent);

  String? get id => _id;

  String? get examName => _examName;

  String? get adNumber => _adNumber;

  List<num>? get categoryTypes => _categoryTypes;

  String? get applicationStartDate => _applicationStartDate;

  String? get formatAppStartDate {
    if (_applicationStartDate != null) {
      final parsedDateTime = DateTime.parse(_applicationStartDate!);
      final formattedDate =
          DateFormat.yMMMd().format(parsedDateTime); // August 10, 2023
      return formattedDate;
    } else {
      return "";
    }
  }

  String? get applicationEndDate => _applicationEndDate;

  String? get formatAppEndDate {
    if (_applicationEndDate != null) {
      final parsedDateTime = DateTime.parse(_applicationEndDate!);
      final formattedDate =
          DateFormat.yMMMd().format(parsedDateTime); // August 10, 2023
      final formattedTime = DateFormat.jm().format(parsedDateTime);
      return '$formattedDate, $formattedTime';
    } else {
      return "";
    }
  }

  num? get totalPosts => _totalPosts;

  num? get noOfLevels => _noOfLevels;

  List<Extras>? get categoryPosts => _categoryPosts;

  List<Extras>? get categoryFees => _categoryFees;

  List<Extras>? get notices => _notices;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get minAgeDate => _minAgeDate;

  String? get maxAgeDate => _maxAgeDate;

  List<num>? get addQualifications => _addQualifications;

  num? get maxQualification => _maxQualification;

  bool? get filtered => _filtered;

  bool? get parent => _parent;

  List<ExamData> get childExams => _childExams;

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
    map['minAgeDate'] = _minAgeDate;
    map['maxAgeDate'] = _maxAgeDate;
    map['addQualifications'] = _addQualifications;
    map['maxQualification'] = _maxQualification;
    map['filtered'] = _filtered;
    map['parent'] = _parent;
    return map;
  }

  void setChildExams(List<ExamData> childExams) {
    _childExams = childExams;
  }
}

/// name : "Category A"
/// posts : "Post A1"
/// gender : [1,2]
/// fee : 50
/// date : "2023-08-20T10:00:00Z"
/// link : "https://example.com"

class Extras {
  Extras({
    String? name,
    num? posts,
    List<num>? categoryIds,
    List<num>? gender,
    num? fee,
    String? date,
    String? link,
  }) {
    _name = name;
    _posts = posts;
    _gender = gender;
    _fee = fee;
    _date = date;
    _link = link;
  }

  Extras.fromJson(dynamic json) {
    _name = json['name'];
    _posts = json['posts'];
    _categoryIds =
        json['categoryIds'] != null ? json['categoryIds'].cast<num>() : [];
    _gender = json['gender'] != null ? json['gender'].cast<num>() : [];
    _fee = json['fee'];
    _date = json['date'];
    _link = json['link'];
  }

  String? _name;
  num? _posts;
  List<num>? _gender;
  List<num>? _categoryIds;
  num? _fee;
  String? _date;
  String? _link;

  Extras copyWith({
    String? name,
    num? posts,
    List<num>? gender,
    List<num>? categoryIds,
    num? fee,
    String? date,
    String? link,
  }) =>
      Extras(
        name: name ?? _name,
        posts: posts ?? _posts,
        gender: gender ?? _gender,
        fee: fee ?? _fee,
        date: date ?? _date,
        link: link ?? _link,
        categoryIds: categoryIds ?? _categoryIds,
      );

  String? get name => _name;

  num? get posts => _posts;

  List<num>? get categoryIds => _categoryIds;

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
    map['categoryIds'] = _categoryIds;
    return map;
  }
}

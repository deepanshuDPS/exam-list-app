class AspirantData {
  AspirantData({
    String? id,
    String? mobile,
    bool? onBoarded,
    String? createdAt,
    String? updatedAt,
    bool? isDiffAble,
    num? subscriptionLimit,
    String? dob,
    num? accountType,
    String? name,
    Category? category,
    EduQualification? eduQualification,
    num? gender,
    List<String>? subscribedChannels,
    Category? diffAbleCategory,
    EduQualification? addQualification,
  }) {
    _id = id;
    _mobile = mobile;
    _onBoarded = onBoarded;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isDiffAble = isDiffAble;
    _subscriptionLimit = subscriptionLimit;
    _dob = dob;
    _accountType = accountType;
    _name = name;
    _category = category;
    _eduQualification = eduQualification;
    _gender = gender;
    _subscribedChannels = subscribedChannels;
    _diffAbleCategory = diffAbleCategory;
    _addQualification = addQualification;
  }

  AspirantData.fromJson(dynamic json) {
    _id = json['_id'];
    _mobile = json['mobile'];
    _onBoarded = json['onBoarded'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _isDiffAble = json['isDiffAble'];
    _subscriptionLimit = json['subscriptionLimit'];
    _dob = json['dob'];
    _accountType = json['accountType'];
    _name = json['name'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _eduQualification = json['eduQualification'] != null
        ? EduQualification.fromJson(json['eduQualification'])
        : null;
    _gender = json['gender'];
    _subscribedChannels = json['subscribedChannels'] != null
        ? json['subscribedChannels'].cast<String>()
        : [];
    _diffAbleCategory = json['diffAbleCategory'] != null
        ? Category.fromJson(json['diffAbleCategory'])
        : null;
    _addQualification = json['addQualification'] != null
        ? EduQualification.fromJson(json['addQualification'])
        : null;
  }

  String? _id;
  String? _mobile;
  bool? _onBoarded;
  String? _createdAt;
  String? _updatedAt;
  bool? _isDiffAble;
  num? _subscriptionLimit;
  String? _dob;
  num? _accountType;
  String? _name;
  Category? _category;
  EduQualification? _eduQualification;
  num? _gender;
  List<String>? _subscribedChannels;
  Category? _diffAbleCategory;
  EduQualification? _addQualification;

  AspirantData copyWith({
    String? id,
    String? mobile,
    bool? onBoarded,
    String? createdAt,
    String? updatedAt,
    bool? isDiffAble,
    num? subscriptionLimit,
    String? dob,
    num? accountType,
    String? name,
    Category? category,
    EduQualification? eduQualification,
    num? gender,
    List<String>? subscribedChannels,
    Category? diffAbleCategory,
    EduQualification? addQualification,
  }) =>
      AspirantData(
        id: id ?? _id,
        mobile: mobile ?? _mobile,
        onBoarded: onBoarded ?? _onBoarded,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        isDiffAble: isDiffAble ?? _isDiffAble,
        subscriptionLimit: subscriptionLimit ?? _subscriptionLimit,
        dob: dob ?? _dob,
        accountType: accountType ?? _accountType,
        name: name ?? _name,
        category: category ?? _category,
        eduQualification: eduQualification ?? _eduQualification,
        gender: gender ?? _gender,
        subscribedChannels: subscribedChannels ?? _subscribedChannels,
        diffAbleCategory: diffAbleCategory ?? _diffAbleCategory,
        addQualification: addQualification ?? _addQualification,
      );

  String? get id => _id;

  String? get mobile => _mobile;

  bool? get onBoarded => _onBoarded;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  bool? get isDiffAble => _isDiffAble;

  num? get subscriptionLimit => _subscriptionLimit;

  String? get dob => _dob;

  num? get accountType => _accountType;

  String? get name => _name;

  Category? get category => _category;

  EduQualification? get eduQualification => _eduQualification;

  num? get gender => _gender;

  List<String>? get subscribedChannels => _subscribedChannels;

  Category? get diffAbleCategory => _diffAbleCategory;

  EduQualification? get addQualification => _addQualification;

  void setGender(num gender) {
    _gender = gender;
  }

  void setName(String name) {
    _name = name;
  }

  void setCategory(Category category) {
    _category = category;
  }

  void setDiffAbleCategory(Category? diffAbleCategory) {
    _diffAbleCategory = diffAbleCategory;
  }

  void setEduQualification(EduQualification? eduQualification) {
    _eduQualification = eduQualification;
  }

  void setMobile(String mobile) {
    _mobile = mobile;
  }

  void setOnBoarded(bool onBoarded) {
    _onBoarded = onBoarded;
  }

  void setAddQualification(EduQualification? addQualification) {
    _addQualification = addQualification;
  }

  void setDiffAble(bool isDiffAble) {
    _isDiffAble = isDiffAble;
  }

  void setDob(String dob) {
    _dob = dob;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['mobile'] = _mobile;
    map['onBoarded'] = _onBoarded;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['isDiffAble'] = _isDiffAble;
    map['subscriptionLimit'] = _subscriptionLimit;
    map['dob'] = _dob;
    map['accountType'] = _accountType;
    map['name'] = _name;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_eduQualification != null) {
      map['eduQualification'] = _eduQualification?.toJson();
    }
    map['gender'] = _gender;
    map['subscribedChannels'] = _subscribedChannels;
    map['diffAbleCategory'] = _diffAbleCategory;
    if (_addQualification != null) {
      map['addQualification'] = _addQualification?.toJson();
    } else {
      map['addQualification'] = null;
    }
    return map;
  }

  void setSubscribedChannels(List<String> subsList) {
    _subscribedChannels = subsList;
  }
}

class EduQualification {
  EduQualification({
    String? optionName,
    num? optionId,
  }) {
    _optionName = optionName;
    _optionId = optionId;
  }

  EduQualification.fromJson(dynamic json) {
    _optionName = json['optionName'];
    _optionId = json['optionId'];
  }

  String? _optionName;
  num? _optionId;

  EduQualification copyWith({
    String? optionName,
    num? optionId,
  }) =>
      EduQualification(
        optionName: optionName ?? _optionName,
        optionId: optionId ?? _optionId,
      );

  String? get optionName => _optionName;

  num? get optionId => _optionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionName'] = _optionName;
    map['optionId'] = _optionId;
    return map;
  }
}

class Category {
  Category({
    String? optionName,
    num? optionId,
  }) {
    _optionName = optionName;
    _optionId = optionId;
  }

  Category.fromJson(dynamic json) {
    _optionName = json['optionName'];
    _optionId = json['optionId'];
  }

  String? _optionName;
  num? _optionId;

  Category copyWith({
    String? optionName,
    num? optionId,
  }) =>
      Category(
        optionName: optionName ?? _optionName,
        optionId: optionId ?? _optionId,
      );

  String? get optionName => _optionName;

  num? get optionId => _optionId;

  void setOptionName(String optionName, num optionId) {
    _optionName = optionName;
    _optionId = optionId;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['optionName'] = _optionName;
    map['optionId'] = _optionId;
    return map;
  }
}

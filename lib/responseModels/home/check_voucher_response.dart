/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"id":"9","created_on":"2022-11-13 17:58:02","updated_on":"2022-11-13 18:10:49","created_by":"11","issue_date":"2022-11-13","category":"Non-Member","subsidiary_id":"1","branch_id":"3","member_num":"","name":"VIJAY KUMAR","email":"avadrefrinery@gmail.com","phone":"9999377963","v_num":"PHW9999","v_price":"400","destination":"Agra\r\nJaipur\r\nKatra\r\nManali\r\nVrindavana","movie":"","holiday":"","status":"1","path":"https://official.thepacificholidayworld.com/uploads/vouchers/PHW9999.pdf"}]

class CheckVoucherResponse {
  CheckVoucherResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  CheckVoucherResponse.fromJson(dynamic json) {
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
CheckVoucherResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => CheckVoucherResponse(  status: status ?? _status,
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

/// id : "9"
/// created_on : "2022-11-13 17:58:02"
/// updated_on : "2022-11-13 18:10:49"
/// created_by : "11"
/// issue_date : "2022-11-13"
/// category : "Non-Member"
/// subsidiary_id : "1"
/// branch_id : "3"
/// member_num : ""
/// name : "VIJAY KUMAR"
/// email : "avadrefrinery@gmail.com"
/// phone : "9999377963"
/// v_num : "PHW9999"
/// v_price : "400"
/// destination : "Agra\r\nJaipur\r\nKatra\r\nManali\r\nVrindavana"
/// movie : ""
/// holiday : ""
/// status : "1"
/// path : "https://official.thepacificholidayworld.com/uploads/vouchers/PHW9999.pdf"

class Data {
  Data({
      String? id,
      String? branch,
      String? createdOn,
      String? updatedOn,
      String? createdBy,
      String? issueDate,
      String? category,
      String? subsidiaryId,
      String? branchId,
      String? memberNum, 
      String? name, 
      String? email, 
      String? phone, 
      String? vNum, 
      String? vPrice, 
      String? destination, 
      String? movie,
      String? holiday,
      String? status, 
      String? path,}){
    _id = id;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
    _createdBy = createdBy;
    _issueDate = issueDate;
    _category = category;
    _branch = branch;
    _subsidiaryId = subsidiaryId;
    _branchId = branchId;
    _memberNum = memberNum;
    _name = name;
    _email = email;
    _phone = phone;
    _vNum = vNum;
    _vPrice = vPrice;
    _destination = destination;
    _movie = movie;
    _holiday = holiday;
    _status = status;
    _path = path;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _createdOn = json['created_on'];
    _updatedOn = json['updated_on'];
    _createdBy = json['created_by'];
    _issueDate = json['issue_date'];
    _category = json['category'];
    _branch = json['branch'];
    _subsidiaryId = json['subsidiary_id'];
    _branchId = json['branch_id'];
    _memberNum = json['member_num'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _vNum = json['v_num'];
    _vPrice = json['v_price'];
    _destination = json['destination'];
    _movie = json['movie'];
    _holiday = json['holiday'];
    _status = json['status'];
    _path = json['path'];
  }
  String? _id;
  String? _createdOn;
  String? _updatedOn;
  String? _branch;
  String? _createdBy;
  String? _issueDate;
  String? _category;
  String? _subsidiaryId;
  String? _branchId;
  String? _memberNum;
  String? _name;
  String? _email;
  String? _phone;
  String? _vNum;
  String? _vPrice;
  String? _destination;
  String? _movie;
  String? _holiday;
  String? _status;
  String? _path;
Data copyWith({  String? id,
  String? createdOn,
  String? updatedOn,
  String? createdBy,
  String? issueDate,
  String? category,
  String? subsidiaryId,
  String? branchId,
  String? memberNum,
  String? name,
  String? email,
  String? branch,
  String? phone,
  String? vNum,
  String? vPrice,
  String? destination,
  String? movie,
  String? holiday,
  String? status,
  String? path,
}) => Data(  id: id ?? _id,
  createdOn: createdOn ?? _createdOn,
  updatedOn: updatedOn ?? _updatedOn,
  createdBy: createdBy ?? _createdBy,
  issueDate: issueDate ?? _issueDate,
  category: category ?? _category,
  subsidiaryId: subsidiaryId ?? _subsidiaryId,
  branchId: branchId ?? _branchId,
  memberNum: memberNum ?? _memberNum,
  branch: branch ?? _branch,
  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  vNum: vNum ?? _vNum,
  vPrice: vPrice ?? _vPrice,
  destination: destination ?? _destination,
  movie: movie ?? _movie,
  holiday: holiday ?? _holiday,
  status: status ?? _status,
  path: path ?? _path,
);
  String? get id => _id;
  String? get createdOn => _createdOn;
  String? get updatedOn => _updatedOn;
  String? get createdBy => _createdBy;
  String? get issueDate => _issueDate;
  String? get category => _category;
  String? get subsidiaryId => _subsidiaryId;
  String? get branchId => _branchId;
  String? get memberNum => _memberNum;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get vNum => _vNum;
  String? get branch => _branch;
  String? get vPrice => _vPrice;
  String? get destination => _destination;
  String? get movie => _movie;
  String? get holiday => _holiday;
  String? get status => _status;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_on'] = _createdOn;
    map['updated_on'] = _updatedOn;
    map['created_by'] = _createdBy;
    map['issue_date'] = _issueDate;
    map['category'] = _category;
    map['subsidiary_id'] = _subsidiaryId;
    map['branch_id'] = _branchId;
    map['member_num'] = _memberNum;
    map['branch'] = _branch;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['v_num'] = _vNum;
    map['v_price'] = _vPrice;
    map['destination'] = _destination;
    map['movie'] = _movie;
    map['holiday'] = _holiday;
    map['status'] = _status;
    map['path'] = _path;
    return map;
  }

}
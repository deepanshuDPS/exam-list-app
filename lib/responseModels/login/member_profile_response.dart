/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"join_date":"2022-10-31","ms_num":"TESTER101","name":"Terster","email":"innovatoronline24x7@gmail.com","dob":"1989-10-30","marriage_anniversary":"1989-08-12","spouse":"","f_child_name":"","f_child_age":"0","s_child_name":"","s_child_age":"0","last_holiday":"","ms_category":"Test123","ms_year":"10","mobile":"8802628114","alt_mobile":"","address":"Dwarka, New Delhi","ms_amount":"100000","ms_advance":"0","ms_due":"0","ms_amc":"22","loc_id":"1","mem_subsidiary":"4r Season Holidays Pvt Ltd"}]

class MemberProfileResponse {
  MemberProfileResponse({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  MemberProfileResponse.fromJson(dynamic json) {
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
MemberProfileResponse copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => MemberProfileResponse(  status: status ?? _status,
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

/// join_date : "2022-10-31"
/// ms_num : "TESTER101"
/// name : "Terster"
/// email : "innovatoronline24x7@gmail.com"
/// dob : "1989-10-30"
/// marriage_anniversary : "1989-08-12"
/// spouse : ""
/// f_child_name : ""
/// f_child_age : "0"
/// s_child_name : ""
/// s_child_age : "0"
/// last_holiday : ""
/// ms_category : "Test123"
/// ms_year : "10"
/// mobile : "8802628114"
/// alt_mobile : ""
/// address : "Dwarka, New Delhi"
/// ms_amount : "100000"
/// ms_advance : "0"
/// ms_due : "0"
/// ms_amc : "22"
/// loc_id : "1"
/// mem_subsidiary : "4r Season Holidays Pvt Ltd"

class Data {
  Data({
      String? joinDate, 
      String? msNum, 
      String? name, 
      String? email, 
      String? dob, 
      String? marriageAnniversary, 
      String? spouse, 
      String? fChildName, 
      String? fChildAge, 
      String? sChildName, 
      String? sChildAge, 
      String? lastHoliday, 
      String? msCategory, 
      String? msYear, 
      String? mobile, 
      String? altMobile, 
      String? address, 
      String? msAmount, 
      String? msAdvance, 
      String? msDue, 
      String? msAmc, 
      String? locId, 
      String? memSubsidiary,}){
    _joinDate = joinDate;
    _msNum = msNum;
    _name = name;
    _email = email;
    _dob = dob;
    _marriageAnniversary = marriageAnniversary;
    _spouse = spouse;
    _fChildName = fChildName;
    _fChildAge = fChildAge;
    _sChildName = sChildName;
    _sChildAge = sChildAge;
    _lastHoliday = lastHoliday;
    _msCategory = msCategory;
    _msYear = msYear;
    _mobile = mobile;
    _altMobile = altMobile;
    _address = address;
    _msAmount = msAmount;
    _msAdvance = msAdvance;
    _msDue = msDue;
    _msAmc = msAmc;
    _locId = locId;
    _memSubsidiary = memSubsidiary;
}

  Data.fromJson(dynamic json) {
    _joinDate = json['join_date'];
    _msNum = json['ms_num'];
    _name = json['name'];
    _email = json['email'];
    _dob = json['dob'];
    _marriageAnniversary = json['marriage_anniversary'];
    _spouse = json['spouse'];
    _fChildName = json['f_child_name'];
    _fChildAge = json['f_child_age'];
    _sChildName = json['s_child_name'];
    _sChildAge = json['s_child_age'];
    _lastHoliday = json['last_holiday'];
    _msCategory = json['ms_category'];
    _msYear = json['ms_year'];
    _mobile = json['mobile'];
    _altMobile = json['alt_mobile'];
    _address = json['address'];
    _msAmount = json['ms_amount'];
    _msAdvance = json['ms_advance'];
    _msDue = json['ms_due'];
    _msAmc = json['ms_amc'];
    _locId = json['loc_id'];
    _memSubsidiary = json['mem_subsidiary'];
  }
  String? _joinDate;
  String? _msNum;
  String? _name;
  String? _email;
  String? _dob;
  String? _marriageAnniversary;
  String? _spouse;
  String? _fChildName;
  String? _fChildAge;
  String? _sChildName;
  String? _sChildAge;
  String? _lastHoliday;
  String? _msCategory;
  String? _msYear;
  String? _mobile;
  String? _altMobile;
  String? _address;
  String? _msAmount;
  String? _msAdvance;
  String? _msDue;
  String? _msAmc;
  String? _locId;
  String? _memSubsidiary;
Data copyWith({  String? joinDate,
  String? msNum,
  String? name,
  String? email,
  String? dob,
  String? marriageAnniversary,
  String? spouse,
  String? fChildName,
  String? fChildAge,
  String? sChildName,
  String? sChildAge,
  String? lastHoliday,
  String? msCategory,
  String? msYear,
  String? mobile,
  String? altMobile,
  String? address,
  String? msAmount,
  String? msAdvance,
  String? msDue,
  String? msAmc,
  String? locId,
  String? memSubsidiary,
}) => Data(  joinDate: joinDate ?? _joinDate,
  msNum: msNum ?? _msNum,
  name: name ?? _name,
  email: email ?? _email,
  dob: dob ?? _dob,
  marriageAnniversary: marriageAnniversary ?? _marriageAnniversary,
  spouse: spouse ?? _spouse,
  fChildName: fChildName ?? _fChildName,
  fChildAge: fChildAge ?? _fChildAge,
  sChildName: sChildName ?? _sChildName,
  sChildAge: sChildAge ?? _sChildAge,
  lastHoliday: lastHoliday ?? _lastHoliday,
  msCategory: msCategory ?? _msCategory,
  msYear: msYear ?? _msYear,
  mobile: mobile ?? _mobile,
  altMobile: altMobile ?? _altMobile,
  address: address ?? _address,
  msAmount: msAmount ?? _msAmount,
  msAdvance: msAdvance ?? _msAdvance,
  msDue: msDue ?? _msDue,
  msAmc: msAmc ?? _msAmc,
  locId: locId ?? _locId,
  memSubsidiary: memSubsidiary ?? _memSubsidiary,
);
  String? get joinDate => _joinDate;
  String? get msNum => _msNum;
  String? get name => _name;
  String? get email => _email;
  String? get dob => _dob;
  String? get marriageAnniversary => _marriageAnniversary;
  String? get spouse => _spouse;
  String? get fChildName => _fChildName;
  String? get fChildAge => _fChildAge;
  String? get sChildName => _sChildName;
  String? get sChildAge => _sChildAge;
  String? get lastHoliday => _lastHoliday;
  String? get msCategory => _msCategory;
  String? get msYear => _msYear;
  String? get mobile => _mobile;
  String? get altMobile => _altMobile;
  String? get address => _address;
  String? get msAmount => _msAmount;
  String? get msAdvance => _msAdvance;
  String? get msDue => _msDue;
  String? get msAmc => _msAmc;
  String? get locId => _locId;
  String? get memSubsidiary => _memSubsidiary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['join_date'] = _joinDate;
    map['ms_num'] = _msNum;
    map['name'] = _name;
    map['email'] = _email;
    map['dob'] = _dob;
    map['marriage_anniversary'] = _marriageAnniversary;
    map['spouse'] = _spouse;
    map['f_child_name'] = _fChildName;
    map['f_child_age'] = _fChildAge;
    map['s_child_name'] = _sChildName;
    map['s_child_age'] = _sChildAge;
    map['last_holiday'] = _lastHoliday;
    map['ms_category'] = _msCategory;
    map['ms_year'] = _msYear;
    map['mobile'] = _mobile;
    map['alt_mobile'] = _altMobile;
    map['address'] = _address;
    map['ms_amount'] = _msAmount;
    map['ms_advance'] = _msAdvance;
    map['ms_due'] = _msDue;
    map['ms_amc'] = _msAmc;
    map['loc_id'] = _locId;
    map['mem_subsidiary'] = _memSubsidiary;
    return map;
  }

}
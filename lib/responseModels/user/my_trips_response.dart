/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"duration":"3 day(s) and 2 Night(s)","details":"Chokhi Dhani Ethnic Village Resort Location : Jaipur","book_date":"2022-11-25","type":"Holiday","cv_url":"https://thepacificholidayworld.com/official/uploads/vouchers/1669116313.pdf"},{"duration":"2 day(s) and 1 Night(s)","details":"Courtyard by Marriott Agra Location : Agra","book_date":"2023-02-23","type":"Holiday","cv_url":"https://thepacificholidayworld.com/official/uploads/vouchers/1676922601.pdf"},{"duration":"MOVIE FREE","details":"test","book_date":"2022-12-23","type":"Offer","cv_url":null}]

class MyTripsResponse {
  MyTripsResponse({
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

  MyTripsResponse.fromJson(dynamic json) {
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

  MyTripsResponse copyWith({
    num? status,
    num? code,
    String? message,
    List<Data>? data,
  }) =>
      MyTripsResponse(
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

/// duration : "3 day(s) and 2 Night(s)"
/// details : "Chokhi Dhani Ethnic Village Resort Location : Jaipur"
/// book_date : "2022-11-25"
/// type : "Holiday"
/// cv_url : "https://thepacificholidayworld.com/official/uploads/vouchers/1669116313.pdf"

class Data {
  Data(
      {String? duration,
      String? details,
      String? bookDate,
      String? type,
      String? cvUrl}) {
    _duration = duration;
    _details = details;
    _bookDate = bookDate;
    _type = type;
    _cvUrl = cvUrl;
  }

  void setFilePath(String? filePath) {
    if (filePath != null) {
      _filePath = filePath;
      _isDownloaded = true;
    }
  }

  get isDownloaded => _isDownloaded;

  get filePath => _filePath;

  Data.fromJson(dynamic json) {
    _duration = json['duration'];
    _details = json['details'];
    _bookDate = json['book_date'];
    _type = json['type'];
    _cvUrl = json['cv_url'];
  }

  String? _duration;
  String? _details;
  String? _bookDate;
  String? _type;
  String? _cvUrl;
  bool _isDownloaded = false;
  String? _filePath;

  Data copyWith({
    String? duration,
    String? details,
    String? bookDate,
    String? type,
    String? cvUrl,
  }) =>
      Data(
        duration: duration ?? _duration,
        details: details ?? _details,
        bookDate: bookDate ?? _bookDate,
        type: type ?? _type,
        cvUrl: cvUrl ?? _cvUrl,
      );

  String? get duration => _duration;

  String? get details => _details;

  String? get bookDate => _bookDate;

  String? get type => _type;

  String? get cvUrl => _cvUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = _duration;
    map['details'] = _details;
    map['book_date'] = _bookDate;
    map['type'] = _type;
    map['cv_url'] = _cvUrl;
    return map;
  }
}

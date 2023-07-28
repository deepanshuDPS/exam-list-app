/// status : 1
/// code : 200
/// message : "Data Found"
/// data : [{"receipt_num":"PHW-UP-GZB-38","gen_date":"2022-11-20","mode":"CREDIT CARD ( RAZOR PAY )","bank":"ICICI","card_num":"XXXX XXXX XXXX 0007","payment_type":"Holiday Amount","amount":"60000","tid":"N/A","company":"PHW","invoice_url":"https://thepacificholidayworld.com/official/uploads/invoices/PHW-UP-GZB-38.pdf"},{"receipt_num":"PHW-UP-GZB-42","gen_date":"2022-11-20","mode":"CREDIT CARD ( RAZOR PAY )","bank":"CITI","card_num":"XXXX XXXX XXXX 8932","payment_type":"Holiday Amount","amount":"78000","tid":"NA","company":"PHW","invoice_url":"https://thepacificholidayworld.com/official/uploads/invoices/PHW-UP-GZB-42.pdf"}]

class MemberFeePayments {
  MemberFeePayments({
      num? status, 
      num? code, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _code = code;
    _message = message;
    _data = data;
}

  MemberFeePayments.fromJson(dynamic json) {
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
MemberFeePayments copyWith({  num? status,
  num? code,
  String? message,
  List<Data>? data,
}) => MemberFeePayments(  status: status ?? _status,
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

/// receipt_num : "PHW-UP-GZB-38"
/// gen_date : "2022-11-20"
/// mode : "CREDIT CARD ( RAZOR PAY )"
/// bank : "ICICI"
/// card_num : "XXXX XXXX XXXX 0007"
/// payment_type : "Holiday Amount"
/// amount : "60000"
/// tid : "N/A"
/// company : "PHW"
/// invoice_url : "https://thepacificholidayworld.com/official/uploads/invoices/PHW-UP-GZB-38.pdf"

class Data {
  Data({
      String? receiptNum, 
      String? genDate, 
      String? mode, 
      String? bank, 
      String? cardNum, 
      String? paymentType, 
      String? amount, 
      String? tid, 
      String? company, 
      String? invoiceUrl,}){
    _receiptNum = receiptNum;
    _genDate = genDate;
    _mode = mode;
    _bank = bank;
    _cardNum = cardNum;
    _paymentType = paymentType;
    _amount = amount;
    _tid = tid;
    _company = company;
    _invoiceUrl = invoiceUrl;
}

  Data.fromJson(dynamic json) {
    _receiptNum = json['receipt_num'];
    _genDate = json['gen_date'];
    _mode = json['mode'];
    _bank = json['bank'];
    _cardNum = json['card_num'];
    _paymentType = json['payment_type'];
    _amount = json['amount'];
    _tid = json['tid'];
    _company = json['company'];
    _invoiceUrl = json['invoice_url'];
  }

  void setFilePath(String? filePath) {
    if (filePath != null) {
      _filePath = filePath;
      _isDownloaded = true;
    }
  }

  get isDownloaded => _isDownloaded;

  get filePath => _filePath;

  String? _receiptNum;
  String? _genDate;
  String? _mode;
  String? _bank;
  String? _cardNum;
  String? _paymentType;
  String? _amount;
  String? _tid;
  String? _company;
  String? _invoiceUrl;
  bool _isDownloaded = false;
  String? _filePath;

Data copyWith({  String? receiptNum,
  String? genDate,
  String? mode,
  String? bank,
  String? cardNum,
  String? paymentType,
  String? amount,
  String? tid,
  String? company,
  String? invoiceUrl,
}) => Data(  receiptNum: receiptNum ?? _receiptNum,
  genDate: genDate ?? _genDate,
  mode: mode ?? _mode,
  bank: bank ?? _bank,
  cardNum: cardNum ?? _cardNum,
  paymentType: paymentType ?? _paymentType,
  amount: amount ?? _amount,
  tid: tid ?? _tid,
  company: company ?? _company,
  invoiceUrl: invoiceUrl ?? _invoiceUrl,
);
  String? get receiptNum => _receiptNum;
  String? get genDate => _genDate;
  String? get mode => _mode;
  String? get bank => _bank;
  String? get cardNum => _cardNum;
  String? get paymentType => _paymentType;
  String? get amount => _amount;
  String? get tid => _tid;
  String? get company => _company;
  String? get invoiceUrl => _invoiceUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['receipt_num'] = _receiptNum;
    map['gen_date'] = _genDate;
    map['mode'] = _mode;
    map['bank'] = _bank;
    map['card_num'] = _cardNum;
    map['payment_type'] = _paymentType;
    map['amount'] = _amount;
    map['tid'] = _tid;
    map['company'] = _company;
    map['invoice_url'] = _invoiceUrl;
    return map;
  }

}
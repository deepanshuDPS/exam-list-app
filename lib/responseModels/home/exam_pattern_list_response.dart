import 'package:exam_list/responseModels/home/exam_pattern_data.dart';

class ExamPatternListResponse {
  ExamPatternListResponse({
    bool? status,
    List<ExamPatternData>? data,
  }) {
    _status = status;
    _data = data;
  }

  ExamPatternListResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ExamPatternData.fromJson(v));
      });
    }
  }
  List<ExamPatternData>? _data;
  bool? _status;

  ExamPatternListResponse copyWith({
    num? totalItems,
    num? totalPages,
    num? fetchTime,
    List<ExamPatternData>? data,
    bool? status,
  }) =>
      ExamPatternListResponse(
        data: data ?? _data,
        status: status ?? status,
      );

  List<ExamPatternData>? get data => _data;

  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

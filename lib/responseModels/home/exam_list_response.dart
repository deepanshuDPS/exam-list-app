import 'package:exam_list/responseModels/home/exam_data.dart';

/// totalItems : 1
/// totalPages : 1
/// fetchTime : 1691841354581
/// data : [{"_id":"exam123","examName":"Sample Exam","adNumber":"2023/123","categoryTypes":["slug1","slug2"],"applicationStartDate":"2023-08-15T00:00:00Z","applicationEndDate":"2023-09-01T00:00:00Z","totalPosts":100,"noOfLevels":3,"categoryPosts":[{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"},{"name":"Category B","posts":"Post B1","gender":[1],"fee":75,"date":"2023-08-25T14:00:00Z","link":"https://example.com"}],"categoryFees":[{"name":"Category A","posts":"Post A1","gender":[1,2],"fee":50,"date":"2023-08-20T10:00:00Z","link":"https://example.com"}],"notices":[{"name":"Important Notice","posts":"All Posts","gender":[],"fee":0,"date":"2023-08-10T08:00:00Z","link":"https://example.com/notice"}],"createdAt":"2023-07-01T10:00:00Z","updatedAt":"2023-08-01T15:00:00Z"}]

class ExamListResponse {
  ExamListResponse({
    bool? status,
    List<ExamData>? data,
  }) {
    _status = status;
    _data = data;
  }

  ExamListResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ExamData.fromJson(v));
      });
    }
  }
  List<ExamData>? _data;
  bool? _status;

  ExamListResponse copyWith({
    num? totalItems,
    num? totalPages,
    num? fetchTime,
    List<ExamData>? data,
    bool? status,
  }) =>
      ExamListResponse(
        data: data ?? _data,
        status: status ?? status,
      );

  List<ExamData>? get data => _data;

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

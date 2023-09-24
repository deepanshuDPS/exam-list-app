
class ExamPatternData {
  ExamPatternData(
      {String? id,
      String? examId,
      String? htmlContent,
      String? extraHtmlContent,
      }) {
    _id = id;
    _examId = examId;
    _htmlContent = htmlContent;
    _extraHtmlContent = extraHtmlContent;
  }

  ExamPatternData.fromJson(dynamic json) {
    _id = json['_id'];
    _examId = json['examId'];
    _htmlContent = json['htmlContent'];
  }

  String? _id;
  String? _examId;
  String? _htmlContent;
  String? _extraHtmlContent;

  ExamPatternData copyWith(
          {String? id,
          String? examId,
          String? htmlContent,
          String? extraHtmlContent}) =>
      ExamPatternData(
          id: id ?? _id,
          examId: examId??_examId,
          htmlContent: htmlContent ?? _htmlContent,
          extraHtmlContent: extraHtmlContent ?? _extraHtmlContent
      );

  String? get id => _id;

  String? get examId => _examId;

  String? get htmlContent => _htmlContent;

  String? get extraHtmlContent => _extraHtmlContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['examId'] = _examId;
    map['htmlContent'] = _htmlContent;
    map['extraHtmlContent'] = _extraHtmlContent;
    return map;
  }
}
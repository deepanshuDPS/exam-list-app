import 'package:exam_list/exams/widgets/notice_link_widget.dart';
import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:flutter/material.dart';

class NoticesTabScreen extends StatelessWidget {
  final ExamData examData;
  late List<Extras> notices;

  NoticesTabScreen({Key? key, required this.examData}) : super(key: key) {
    notices = getNotices(examData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: notices.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: examData.notices?.length ?? 0,
                itemBuilder: (context, index) {
                  return NoticeLinkWidget(
                      linkDetails: examData.notices![index]);
                })
            : const Center(
                child: Text(
                "No Notices",
              )));
  }
}

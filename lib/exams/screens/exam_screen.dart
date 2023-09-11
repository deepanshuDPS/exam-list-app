import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/responseModels/home/exam_data.dart';
import 'package:exam_list/responseModels/login/aspirant_data.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  static const routeName = "/resort-screen";

  const ExamScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends BaseState<ExamScreen> {
  // String _adNumber = "";
  String _examName = "";
  late ExamData _exam;
  late AspirantData _aspirantData;

  @override
  void initState() {
    super.initState();
  }

  ExamProvider _examProvider() {
    return Provider.of<ExamProvider>(context, listen: false);
  }

  UserProvider _userProvider() {
    return Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _examName = _examProvider().exam?.examName ?? 'N/A';
      _exam = _examProvider().exam!;
      _aspirantData = _userProvider().aspirantDetails!;
    }
    super.didChangeDependencies();
  }

  Widget _heading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: sharpGrey),
      ),
    );
  }

  Widget _detailsRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:', style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),),
          const SizedBox(width: 4,),
          Text(value, style: const TextStyle(color: sharpGrey, fontSize: 14, fontWeight: FontWeight.w400),maxLines: 2,),
        ],
      ),
    );
  }

  Widget _detailsLink(Extras linkDetails) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightPink,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              linkDetails.name ?? "Notice",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            if (linkDetails.formattedDate.isNotEmpty)
              Text(
                linkDetails.formattedDate,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 9),
              ),
          ]),
          const Icon(
            Icons.open_in_new_rounded,
            size: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        titleText: "Exam Details",
        isBackRequired: true,
        child: Consumer<ExamProvider>(
            child: const ContainerLoading(),
            builder: (ctx, exams, ch) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                      child: Text(
                        _examName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
                      )),
                  _heading('General Details:'),
                  Column(
                    children: [
                      _detailsRow(
                          'Total Posts', getTotalPosts(_exam).toString()),
                      const SizedBox(height: 6),
                      _detailsRow(
                          '${_aspirantData.category?.optionName ?? 'N/A'} Category Posts',
                          getTotalCategoryPosts(
                                  _aspirantData.category?.optionId ?? 0,
                                  _aspirantData.gender ?? 0,
                                  _exam)
                              .toString()),
                      const SizedBox(height: 6),
                      _detailsRow(
                          '${_aspirantData.category?.optionName ?? 'N/A'} ${Constants.genders[_aspirantData.gender ?? 0]} Fees',
                          getExamFees(_aspirantData.category?.optionId ?? 0,
                                  _aspirantData.gender ?? 0, _exam)
                              .toString()),
                    ],
                  ),
                  _heading('Important Dates:'),
                  Column(
                    children: [
                      _detailsRow('Application Start Date',
                          _exam.formatAppStartDate?.toString() ?? ''),
                      const SizedBox(height: 6),
                      _detailsRow('Application End Date',
                          _exam.formatAppEndDate?.toString() ?? ''),
                      const SizedBox(height: 6),
                    ],
                  ),
                  _heading('Important Links:'),
                  ...getNotices(_exam).map((e) => _detailsLink(e))
                ],
              );
            }));
  }
}

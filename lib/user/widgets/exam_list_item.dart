import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamListItem extends StatelessWidget {
  final ExamData exam;
  final AspirantData aspirant;
  final Function onClick;
  final Function onNotify;
  final Function onRemoveNotify;

  const ExamListItem(
      {Key? key,
      required this.exam,
      required this.onClick,
      required this.aspirant,
      required this.onNotify,
      required this.onRemoveNotify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset('assets/images/img_rect_phw.png'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(right: 26),
                    child: Text(
                      exam.examName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date: ${exam.formatAppStartDate}\nEnd Date: ${exam.formatAppEndDate}',
                        style: AppStyles.fontSize12(),
                      ),
                      Text(
                        'Your category posts: ${getTotalCategoryPosts(aspirant.category?.optionId ?? 0, aspirant.gender ?? 0, exam)}',
                        style: AppStyles.fontSize12(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total posts: ${(getTotalPosts(exam))}',
                            style: AppStyles.fontSize12(),
                          ),
                          Text(
                            'Fees: ${getExamFees(aspirant.category?.optionId ?? 0, aspirant.gender ?? 0, exam)}',
                            textAlign: TextAlign.right,
                            style: AppStyles.fontSize12(),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    exam.isNotify == 0
                        ? onNotify(exam.slug)
                        : onRemoveNotify(exam.slug);
                  },
                  child: SvgPicture.asset(
                    exam.isNotify == 2
                        ? 'assets/svg/ic_notification_on.svg'
                        : 'assets/svg/ic_notification_off.svg',
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

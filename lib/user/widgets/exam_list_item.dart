import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../responseModels/home/exam_list_response.dart';

class ExamListItem extends StatelessWidget {
  final Data exam;

  const ExamListItem({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      'Your category posts: ${(exam.categoryPosts![0].posts ?? 0)}',
                      style: AppStyles.fontSize12(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total posts: ${(exam.totalPosts)}',
                          style:
                              AppStyles.fontSize12(),
                        ),
                        Text(
                          'Fees: ${exam.categoryFees![0].fee ?? 0}',
                          textAlign: TextAlign.right,
                          style: AppStyles.fontSize12(),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: Icon(
                  false ? Icons.notifications_active : Icons.notifications_off,
                ),
                onPressed: () {
                  // Implement your notification toggle logic here
                },
              ))
        ],
      ),
    );
  }
}

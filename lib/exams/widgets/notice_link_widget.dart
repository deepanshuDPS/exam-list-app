import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:flutter/material.dart';

class NoticeLinkWidget extends StatelessWidget {

  final Extras linkDetails;

  const NoticeLinkWidget({Key? key, required this.linkDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

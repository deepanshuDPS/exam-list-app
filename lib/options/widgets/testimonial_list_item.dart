import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/home/testimonials_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/image_handling.dart';

class TestimonialListItem extends StatelessWidget {
  final Data data;
  final int index;

  const TestimonialListItem({Key? key, required this.data, required this.index})
      : super(key: key);

  Widget _getImage(double size) {
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: cachedImageWithSize(data.imageUrl ?? "", BoxFit.cover, size),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width40 = MediaQuery.of(context).size.width * 0.4;
    return Container(
      margin: const EdgeInsets.all(14),
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                left: index % 2 == 0 ? (width40 / 2) + 12 : 12,
                right: index % 2 == 1 ? (width40 / 2) + 12 : 12,
                top: 12,
                bottom: 12),
            margin: EdgeInsets.only(
                left: index % 2 == 0 ? width40 / 2 : 0,
                right: index % 2 == 1 ? width40 / 2 : 0,
                top: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: fadeOrange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(data.name ?? "--",
                    style: AppStyles.robotoBlackText()
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data.feedback ?? "--",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          if (index % 2 == 0)
            Align(alignment: Alignment.centerLeft, child: _getImage(width40)),
          if (index % 2 == 1)
            Align(
              alignment: Alignment.centerRight,
              child: _getImage(width40),
            )
        ],
      ),
    );
  }
}

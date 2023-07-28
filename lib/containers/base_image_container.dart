import 'package:flutter/material.dart';
import 'package:exam_list/utils/image_handling.dart';

class BaseImageContainer extends StatelessWidget {
  final Widget child;
  final double opacity;

  const BaseImageContainer(
      {Key? key, required this.child, required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Opacity(
            opacity: opacity,
            child: cachedImage(
              'https://thepacificholidayworld.com/assets/images/resource/model_img.jpg',
              BoxFit.cover,
            )),
      ),
      child
    ]);
  }
}

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
      Container(
        width: double.infinity,
        height: double.infinity,
        color : Colors.white,
      ),
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Opacity(
            opacity: opacity,
            child: Image.asset('assets/images/bg_app.png', fit: BoxFit.cover)),
      ),
      child
    ]);
  }
}

import 'package:flutter/material.dart';

class CardBackground extends StatelessWidget {
  final Widget child;
  final double paddingTop;
  final double? symmetric;
  final double? containerMargin;

  const CardBackground(
      {Key? key,
      required this.child,
      required this.paddingTop,
      this.symmetric,
      this.containerMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: containerMargin ?? 16, vertical: containerMargin ?? 0),
        width: double.infinity,
        child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                padding: symmetric == null
                    ? EdgeInsets.only(top: paddingTop)
                    : EdgeInsets.symmetric(vertical: symmetric ?? 0),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(16)),
                //   border: Border.all(
                //       color: Theme.of(context).colorScheme.secondary, width: 3),
                // ),
                child: child)));
  }
}

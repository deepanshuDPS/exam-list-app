import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String? titleText;
  final double? elevation;
  final bool? isYellow;
  final PreferredSizeWidget? barBottom;

  const BaseScaffold(
      {Key? key,
      required this.child,
      this.titleText,
      this.elevation,
      this.barBottom,
      this.isYellow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints.expand(), // ← this guy
        color: Colors.white,
        child: child,
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          titleText ?? "",
          style: AppStyles.robotoBold().copyWith(fontSize: 20),
        ),
        backgroundColor: isYellow == true
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: elevation ?? 0,
        bottom: barBottom,
      ),
    );
  }
}

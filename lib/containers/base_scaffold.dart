import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:flutter/services.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String? titleText;
  final double? elevation;
  final bool? isAppBarColored;
  final PreferredSizeWidget? barBottom;

  const BaseScaffold(
      {Key? key,
      required this.child,
      this.titleText,
      this.elevation,
      this.barBottom,
      this.isAppBarColored})
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
          style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: isAppBarColored == true
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
           // Navigator.of(context).pop();
            SystemNavigator.pop();
          },
        ),
        elevation: elevation ?? 0,
        bottom: barBottom,
      ),
    );
  }
}

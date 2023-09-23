import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final String? titleText;
  final double? elevation;
  final bool? isAppBarColored;
  final bool? isBackRequired;
  final PreferredSizeWidget? barBottom;
  final Widget? action;

  const BaseScaffold(
      {Key? key,
      required this.child,
      this.titleText,
      this.elevation,
      this.barBottom,
      this.isAppBarColored,
      this.isBackRequired,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints.expand(),
        color: Colors.transparent,
        child: child,
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: isBackRequired == true
              ? const EdgeInsets.all(0)
              : const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            titleText ?? "",
            style: TextStyle(
                fontSize: 20,
                color: isAppBarColored == true ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: isAppBarColored == true
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        leading: isBackRequired == true
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: isAppBarColored == true ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // SystemNavigator.pop();
                },
              )
            : null,
        elevation: elevation ?? 0,
        bottom: barBottom,
        actions: [action ?? const SizedBox()],
      ),
    );
  }
}

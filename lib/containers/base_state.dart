import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State {
  bool isFirstTime = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstTime) isFirstTime = false;
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController _controller;
  late List<Widget> _tabScreens;
  var selectedIndex = 0.obs;

  void setTabs(List<Widget> tabs) {
    _tabScreens = tabs;
    _controller = TabController(
        length: _tabScreens.length,
        vsync: this,
        animationDuration: Duration.zero);
    selectedIndex.value = 0;
    _controller.index = 0;
  }

  TabController get controller => _controller;

  List<Widget> get tabScreens => _tabScreens;

  void onItemSelected(int index) {
    selectedIndex.value = index;
    _controller.index = index;
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}

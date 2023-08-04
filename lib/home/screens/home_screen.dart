import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  BaseState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      Provider.of<UserProvider>(context, listen: false).getAspirantUser();
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseImageContainer(
        child: SingleChildScrollView(
            child: Container(
          color: Colors.transparent,
          child: Text('Hello There'),
        )),
        opacity: 0.65,
      ),
    );
  }
}

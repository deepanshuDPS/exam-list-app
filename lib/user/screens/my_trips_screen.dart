import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/user/screens/trips_screen.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:provider/provider.dart';

class MyTripsScreen extends StatefulWidget {
  static const routeName = "/my-trips";

  const MyTripsScreen({Key? key}) : super(key: key);

  @override
  BaseState<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends BaseState<MyTripsScreen> {
  final List tabBarTitles = ['Upcoming ', 'Completed'];

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      Provider.of<UserProvider>(context, listen: false).getTrips(0);
      Provider.of<UserProvider>(context, listen: false).getTrips(1);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BaseScaffold(
          titleText: "My Trips",
          isYellow: true,
          barBottom: TabBar(
            labelColor: Theme.of(context).colorScheme.secondary,
            unselectedLabelColor: Colors.black54,
            // const Color.fromRGBO(255, 107, 0, 1),
            isScrollable: false,
            indicatorColor: Colors.black,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Colors.black),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            tabs: List.generate(tabBarTitles.length, (index) {
              return Tab(
                child: Text(
                  tabBarTitles[index],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              );
            }),
          ),
          child: const BaseImageContainer(
            opacity: 0.4,
            child: TabBarView(children: [
              TripsScreen(isCompleted: false),
              TripsScreen(isCompleted: true)
            ]),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/options/pages/benefits_page.dart';
import 'package:exam_list/options/pages/offers_page.dart';
import 'package:exam_list/options/pages/overview_page.dart';
import 'package:exam_list/options/pages/testimonials_page.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:provider/provider.dart';

class GetInTouchScreen extends StatefulWidget {
  static const routeName = "/get-in-touch";

  const GetInTouchScreen({Key? key}) : super(key: key);

  @override
  BaseState<GetInTouchScreen> createState() => _GetInTouchScreenState();
}

class _GetInTouchScreenState extends BaseState<GetInTouchScreen> {
  final List tabBarTitles = ['Overview ', 'Benefits', 'Offers', 'Testimonials'];
  int defaultTabPosition = 0;

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      defaultTabPosition = ModalRoute.of(context)?.settings.arguments as int;
      Provider.of<HomeProvider>(context, listen: false).fetchTestimonials();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: defaultTabPosition,
        child: BaseScaffold(
          titleText: "Get in Touch",
          isYellow: true,
          barBottom: TabBar(
              labelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Colors.black54,
              // const Color.fromRGBO(255, 107, 0, 1),
              isScrollable: true,
              indicatorColor: Colors.black,
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: Colors.black),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              tabs: List.generate(tabBarTitles.length, (index) {
                return Tab(
                  height: 36,
                  child: Text(
                    tabBarTitles[index],
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                );
              })),
          child: const BaseImageContainer(
            opacity: 0.6,
            child: TabBarView(children: [
              OverviewPage(),
              BenefitsPage(),
              OffersPage(),
              TestimonialsPage()
            ]),
          ),
        ));
  }
}

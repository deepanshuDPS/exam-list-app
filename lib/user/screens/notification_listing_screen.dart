import 'package:exam_list/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';


class NotificationListingScreen extends StatefulWidget {
  static const routeName = "/notification-listing-screen";

  const NotificationListingScreen({Key? key}) : super(key: key);

  @override
  BaseState<NotificationListingScreen> createState() => _NotificationListingScreenState();
}

class _NotificationListingScreenState extends BaseState<NotificationListingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: "Notifications",
      isAppBarColored: true,
      child: BaseImageContainer(
        opacity: 0.4,
        child: Consumer<UserProvider>(
            child: const ContainerLoading(),
            builder: (ctx, user, ch) {
              // if (resorts.resortsListingRequestData.isLoading) {
              //   return ch!;
              // } else if (resorts.resortsListingRequestData.isError) {
              //   return ContainerError(
              //       jsonData: resorts.resortsListingRequestData.data,
              //       onTryAgain: () => {_fetchData()});
              // }
              // var itemList = resorts.exam;

              return Container();
            }),
      ),
    );
  }

  void _fetchData() {
    Provider.of<UserProvider>(context, listen: false).getNotifications();
  }
}

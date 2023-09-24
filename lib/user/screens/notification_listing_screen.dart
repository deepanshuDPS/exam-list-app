import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class NotificationListingScreen extends StatefulWidget {
  static const routeName = "/notification-listing-screen";

  const NotificationListingScreen({Key? key}) : super(key: key);

  @override
  BaseState<NotificationListingScreen> createState() =>
      _NotificationListingScreenState();
}

class _NotificationListingScreenState
    extends BaseState<NotificationListingScreen> {

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
      isAppBarColored: false,
      isBackRequired: true,
      child: Consumer<UserProvider>(
          child: const ContainerLoading(),
          builder: (ctx, user, ch) {
            if (user.notificationsRequestData.isLoading) {
              return ch!;
            } else if (user.notificationsRequestData.isError) {
              return ContainerError(
                  jsonData: user.notificationsRequestData.data,
                  onTryAgain: () => {_fetchData()});
            }
            var itemList = user.notifications;
            return ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (_, index) {
                  var item = itemList[index];
                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset('assets/images/img_rect_phw.png'),
                    ),
                    title: Text(item.title ?? "..."),
                    subtitle: Text(item.description ?? "..."),
                    trailing: item.notificationType != 1
                        ? const Icon(Icons.notifications_active_rounded)
                        : const Icon(Icons.notification_add),
                    onTap: () {
                      var examToOpen = _examProvider()
                          .getAdNumberExam(item.adNumber ?? "..");
                      if (examToOpen != null) {
                        _examProvider().setExam(examToOpen);
                        Navigator.of(context).pushNamed(ExamScreen.routeName);
                        return;
                      }
                      showProgressDialog(context);
                      _openExam(item.adNumber ?? "..").then((value) {
                        Navigator.of(context).pop();
                        if (value is bool) {
                          Navigator.of(context).pushNamed(ExamScreen.routeName);
                        } else {
                          value as String;
                          showSnackBar(context, value);
                        }
                      });
                    },
                  );
                });
          }),
    );
  }

  void _fetchData() {
    _userProvider().getNotifications();
  }

  UserProvider _userProvider() {
    return Provider.of<UserProvider>(context, listen: false);
  }

  ExamProvider _examProvider() {
    return Provider.of<ExamProvider>(context, listen: false);
  }

  Future<dynamic> _openExam(String adNumber) async {
    try {
      await _userProvider().getAspirantUser();
      if (_userProvider().aspirantRequestData.data != null) {
        await _examProvider().fetchExams(
            0, _userProvider().aspirantDetails?.subscribedChannels ?? []);
        if (_examProvider().examRequest.data != null) {
          var examToOpen = _examProvider().getAdNumberExam(adNumber);
          if (examToOpen != null) {
            _examProvider().setExam(examToOpen);
            return true;
          }
        } else {
          return 'Something went wrong, Please try after sometime...';
        }
      } else {
        return 'Something went wrong, Please try after sometime...';
      }
    } catch (e) {
      return 'Something went wrong, Please try after sometime...';
    }
  }
}

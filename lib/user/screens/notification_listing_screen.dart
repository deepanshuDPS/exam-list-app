import 'package:exam_list/controllers/aspirant_exam_controller.dart';
import 'package:exam_list/controllers/aspirant_user_controller.dart';
import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationListingScreen extends GetWidget<AspirantUserController> {
  static const routeName = "/notification-listing-screen";
  final AspirantExamController _examController = Get.find();

  NotificationListingScreen({Key? key}) : super(key: key);

  Widget _trailingIcon(String asset) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: appRed.withOpacity(0.2)),
        child: SvgPicture.asset(asset, width: 24, height: 24));
  }

  @override
  Widget build(BuildContext context) {
    controller.getNotifications();
    return BaseScaffold(
      titleText: "Notifications",
      isAppBarColored: false,
      isBackRequired: true,
      child: Obx(() {
        if (controller.notificationRequestData.value.isLoading) {
          return const ContainerLoading();
        } else if (controller.notificationRequestData.value.isError) {
          return ContainerError(
              jsonData: controller.notificationRequestData.value.data,
              onTryAgain: () => {_fetchData()});
        }
        var itemList = controller.notifications;
        return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (_, index) {
              var item = itemList[index];
              return ListTile(
                tileColor: Colors.white,
                leading: Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.asset('assets/images/img_rect_phw.png'),
                    ),
                  ),
                ),
                title: Text(item.title ?? "...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    )),
                subtitle: Text(item.description ?? "...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    )),
                trailing: item.notificationType != 1
                    ? _trailingIcon("assets/svg/ic_update_exam.svg")
                    : _trailingIcon("assets/svg/ic_new_exam.svg"),
                onTap: () {
                  var examToOpen =
                      _examController.getAdNumberExam(item.adNumber ?? "..");
                  if (examToOpen != null) {
                    _examController.setExam(examToOpen);
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
    controller.getNotifications();
  }

  // UserProvider _userProvider() {
  //   return Provider.of<UserProvider>(context, listen: false);
  // }
  //
  // ExamProvider _examProvider() {
  //   return Provider.of<ExamProvider>(context, listen: false);
  // }

  Future<dynamic> _openExam(String adNumber) async {
    try {
      await controller.getAspirantUser();
      if (controller.aspirantRequestData.value.data != null) {
        await _examController.fetchExams(
            0, controller.aspirantDetails?.subscribedChannels ?? []);
        if (_examController.examRequest.value.data != null) {
          var examToOpen = _examController.getAdNumberExam(adNumber);
          if (examToOpen != null) {
            _examController.setExam(examToOpen);
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

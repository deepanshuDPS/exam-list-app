import 'package:clipboard/clipboard.dart';
import 'package:exam_list/controllers/aspirant_exam_controller.dart';
import 'package:exam_list/controllers/aspirant_user_controller.dart';
import 'package:exam_list/controllers/exam_tab_controller.dart';
import 'package:exam_list/exams/screens/html_tab_screen.dart';
import 'package:exam_list/exams/screens/notices_tab_screen.dart';
import 'package:exam_list/exams/widgets/admin_confirmation_dialog.dart';
import 'package:exam_list/exams/widgets/confirmation_dialog.dart';
import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/keep_alive_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class ExamScreen extends GetWidget<AspirantExamController> {
  static const routeName = "/exam-screen";

  ExamScreen({Key? key}) : super(key: key);

  final ExamTabController _examTabController = Get.find();
  final AspirantUserController _aspirantUserController = Get.find();

  Widget _heading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: sharpGrey),
      ),
    );
  }

  Widget _detailsRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
                color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            value,
            style: const TextStyle(
                color: sharpGrey, fontSize: 14, fontWeight: FontWeight.w400),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _tabBarView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Tab(
        text: title,
      ),
    );
  }

  // void afterOneSecond() {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     final RenderBox renderBox =
  //     _examDetailsKey.currentContext?.findRenderObject() as RenderBox;
  //     setState(() {
  //       _columnHeight = renderBox.size.height + 56;
  //       printDebug(_columnHeight.toString());
  //     });
  //   });
  // }

  Widget _onlyMarqueOnLines(
      BuildContext context, String examName, TextStyle style) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: examName, style: style),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return Marquee(
            text: examName,
            style: style,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 30.0,
            velocity: 40.0,
            pauseAfterRound: const Duration(seconds: 4),
          );
        } else {
          return Text(examName, style: style);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String examName = controller.exam?.examName ?? 'N/A';
    ExamData exam = controller.exam!;
    AspirantData aspirantData = _aspirantUserController.aspirantDetails!;

    return Scaffold(body: Obx(() {
      if (controller.examRequestData.value.isLoading) {
        return const Center(
          child: ContainerLoading(),
        );
      }
      var subscriptionData = controller.subscriptionStatus[exam.slug];
      var isSubscribed = subscriptionData != null && subscriptionData == 2;
      List<Widget> tabList = [];
      List<Widget> tabScreens = [];
      if (getNotices(exam).isNotEmpty) {
        tabList.add(_tabBarView('Notices'));
        tabScreens.add(KeepAliveWrapper(
            child: NoticesTabScreen(
          examData: exam,
        )));
      }
      if (controller.htmlContents.isNotEmpty) {
        for (var htmlContent in controller.htmlContents) {
          tabList.add(_tabBarView('Info'));
          tabScreens.add(KeepAliveWrapper(
              child: HtmlTabScreen(
            htmlContent: htmlContent,
          )));
        }
      }
      if (controller.extraHtmlContents.isNotEmpty) {
        for (var htmlContent in controller.htmlContents) {
          tabList.add(_tabBarView('Extra Info'));
          tabScreens.add(KeepAliveWrapper(
              child: HtmlTabScreen(
            htmlContent: htmlContent,
          )));
        }
      }
      _examTabController.setTabs(tabScreens);
      return CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350,
            floating: true,
            toolbarHeight: 56.0,
            title: const Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Exam Details',
                style: TextStyle(
                    fontSize: 20,
                    color: sharpGrey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            actions: aspirantData.mobile?.contains("9896147495") == true &&
                    kDebugMode
                ? [
                    IconButton(
                        onPressed: () {
                          confirm(context, exam, false);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          FlutterClipboard.copy(
                                  "examId: ${exam.id},\nexamName: ${exam.examName},\nexamId - examPatternId: \n${controller.examToExamPattern.toString()}")
                              .then((value) =>
                                  showGetSnackBar("Exam Details Copied"))
                              .catchError((error) =>
                                  showGetSnackBar("Error in copying"));
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          confirm(context, exam, true);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.black,
                        ))
                  ]
                : [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: UnconstrainedBox(
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            var slug = exam.slug ?? "";
                            if (isSubscribed) {
                              showDialog<void>(
                                  context: context,
                                  builder: (BuildContext dContext) {
                                    return ConfirmationDialog(
                                        forSubscribe: false,
                                        yes: () {
                                          if (controller.isNotifying.value) {
                                            return;
                                          }
                                          showProgressDialog(context);
                                          controller
                                              .removeNotifyMe(slug)
                                              .then((value) {
                                            Get.back();
                                            if (value is String) {
                                              showGetSnackBar(value);
                                            }
                                          }).onError((error, stackTrace) {
                                            Get.back();
                                            showGetSnackBar(
                                                'Something went wrong');
                                          });
                                        });
                                  });
                            } else {
                              showDialog<void>(
                                  context: context,
                                  builder: (BuildContext dContext) {
                                    return ConfirmationDialog(
                                        forSubscribe: true,
                                        yes: () {
                                          if (controller.isNotifying.value) {
                                            return;
                                          }
                                          showProgressDialog(context);
                                          controller
                                              .notifyMe(slug)
                                              .then((value) {
                                            Get.back();
                                            if (value is String) {
                                              showGetSnackBar(value);
                                            }
                                          }).onError((error, stackTrace) {
                                            Get.back();
                                            showGetSnackBar(
                                                'Something went wrong');
                                          });
                                        });
                                  });
                            }
                          },
                          color: isSubscribed ? sharpGrey : appRed,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius here
                          ),
                          child: Row(children: [
                            Icon(
                              isSubscribed
                                  ? Icons.notifications_active
                                  : Icons.notifications,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(isSubscribed ? 'Subscribed' : 'Subscribe',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ),
                      ),
                    )
                  ],
            backgroundColor: Colors.white,
            pinned: true,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: sharpGrey,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding:
                    EdgeInsets.only(top: (Get.mediaQuery.padding.top)),
                child: Center(
                  // key: _examDetailsKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: SizedBox(
                            height: 26,
                            child: _onlyMarqueOnLines(
                                context,
                                examName,
                                const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: sharpGrey)),
                          )),
                      _heading('General Details:'),
                      Column(
                        children: [
                          _detailsRow(
                              'Total Posts', getTotalPosts(exam).toString()),
                          const SizedBox(height: 6),
                          _detailsRow(
                              '${aspirantData.category?.optionName ?? 'N/A'} Category Posts',
                              getTotalCategoryPosts(
                                      aspirantData.category?.optionId ?? 0,
                                      aspirantData.gender ?? 0,
                                      exam)
                                  .toString()),
                          const SizedBox(height: 6),
                          _detailsRow(
                              '${aspirantData.category?.optionName ?? 'N/A'} ${Constants.genders[aspirantData.gender ?? 0]} Fees',
                              getExamFees(aspirantData.category?.optionId ?? 0,
                                      aspirantData.gender ?? 0, exam)
                                  .toString()),
                        ],
                      ),
                      _heading('Important Dates:'),
                      Column(
                        children: [
                          _detailsRow('Application Start Date',
                              exam.formatAppStartDate?.toString() ?? ''),
                          const SizedBox(height: 6),
                          _detailsRow('Application End Date',
                              exam.formatAppEndDate?.toString() ?? ''),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              // Height of the TabBar
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    tabs: tabList,
                    labelColor: Colors.red,
                    unselectedLabelColor: sharpGrey,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                    controller: _examTabController.controller,
                  )),
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _examTabController.controller,
                  children: tabScreens))
        ],
      );
    }));
  }

  /* @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        titleText: "Exam Details",
        isBackRequired: true,
        elevation: 2,
        child: BaseImageContainer(
            opacity: 0.3,
            child: Consumer<ExamProvider>(
                child: const ContainerLoading(),
                builder: (ctx, exams, ch) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Text(
                              _examName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: sharpGrey),
                            )),
                        _heading('General Details:'),
                        Column(
                          children: [
                            _detailsRow(
                                'Total Posts', getTotalPosts(_exam).toString()),
                            const SizedBox(height: 6),
                            _detailsRow(
                                '${_aspirantData.category?.optionName ?? 'N/A'} Category Posts',
                                getTotalCategoryPosts(
                                        _aspirantData.category?.optionId ?? 0,
                                        _aspirantData.gender ?? 0,
                                        _exam)
                                    .toString()),
                            const SizedBox(height: 6),
                            _detailsRow(
                                '${_aspirantData.category?.optionName ?? 'N/A'} ${Constants.genders[_aspirantData.gender ?? 0]} Fees',
                                getExamFees(
                                        _aspirantData.category?.optionId ?? 0,
                                        _aspirantData.gender ?? 0,
                                        _exam)
                                    .toString()),
                          ],
                        ),
                        _heading('Important Dates:'),
                        Column(
                          children: [
                            _detailsRow('Application Start Date',
                                _exam.formatAppStartDate?.toString() ?? ''),
                            const SizedBox(height: 6),
                            _detailsRow('Application End Date',
                                _exam.formatAppEndDate?.toString() ?? ''),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ],
                    ),
                  );
                })));
  }
*/

  void confirm(BuildContext context, ExamData exam, bool toLive) {
    showDialog<void>(
        context: context,
        builder: (BuildContext dContext) {
          return AdminConfirmationDialog(
              message: toLive
                  ? "Do Live this Whole Exam?"
                  : "Delete Live this Whole Exam?",
              yes: () {
                showProgressDialog(context);
                Future<dynamic> future = toLive
                    ? controller.doExamLive(exam.adNumber ?? '')
                    : controller.deleteExam(exam.adNumber ?? '');

                future.then((value) {
                  Get.back();
                  if (value is String) {
                    showGetSnackBar(value);
                  } else {
                    // go to back screen
                    Get.back();
                  }
                }).onError((error, stackTrace) {
                  Get.back();
                  showGetSnackBar('Something went wrong');
                });
              });
        });
  }
}

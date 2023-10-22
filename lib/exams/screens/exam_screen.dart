import 'package:clipboard/clipboard.dart';
import 'package:exam_list/exams/screens/html_tab_screen.dart';
import 'package:exam_list/exams/screens/notices_tab_screen.dart';
import 'package:exam_list/exams/widgets/confirmation_dialog.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/user/extras/view_image.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  static const routeName = "/exam-screen";

  const ExamScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends BaseState<ExamScreen>
    with TickerProviderStateMixin {
  // String _adNumber = "";
  String _examName = "";
  late ExamData _exam;
  late AspirantData _aspirantData;

  // final GlobalKey _examDetailsKey = GlobalKey();
  // late double _columnHeight = 350;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
  }

  ExamProvider _examProvider() {
    return Provider.of<ExamProvider>(context, listen: false);
  }

  UserProvider _userProvider() {
    return Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _examName = _examProvider().exam?.examName ?? 'N/A';
      _exam = _examProvider().exam!;
      _aspirantData = _userProvider().aspirantDetails!;
    }
    super.didChangeDependencies();
  }

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
    return Scaffold(
        body: Consumer<ExamProvider>(
            child: const ContainerLoading(),
            builder: (ctx, exams, ch) {
              var subscriptionData = exams.subscriptionStatus[_exam.slug];
              var isSubscribed =
                  subscriptionData != null && subscriptionData == 2;
              List<Widget> tabList = [];
              List<Widget> tabScreens = [];
              if (getNotices(_exam).isNotEmpty) {
                tabList.add(_tabBarView('Notices'));
                tabScreens.add(NoticesTabScreen(
                  examData: _exam,
                ));
              }
              if (exams.htmlContents.isNotEmpty) {
                for (var htmlContent in exams.htmlContents) {
                  tabList.add(_tabBarView('Info'));
                  tabScreens.add(HtmlTabScreen(
                    htmlContent: htmlContent,
                  ));
                }
              }
              if (exams.extraHtmlContents.isNotEmpty) {
                for (var htmlContent in exams.htmlContents) {
                  tabList.add(_tabBarView('Extra Info'));
                  tabScreens.add(HtmlTabScreen(
                    htmlContent: htmlContent,
                  ));
                }
              }
              tabController =
                  TabController(length: tabList.length, vsync: this);
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
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: UnconstrainedBox(
                          child: MaterialButton(
                            elevation: 1,
                            onLongPress: kDebugMode
                                ? () {
                                    FlutterClipboard.copy(
                                            "examId: ${_exam.id},\nexamName: ${_exam.examName},\nexamId - examPatternId: \n${_examProvider().examToExamPattern.toString()}")
                                        .then((value) => showSnackBar(
                                            context, "Exam Details Copied"))
                                        .catchError((error) => showSnackBar(
                                            context, "Error in copying"));
                                  }
                                : null,
                            onPressed: () {
                              var slug = _exam.slug ?? "";
                              if (isSubscribed) {
                                showDialog<void>(
                                    context: context,
                                    builder: (BuildContext dContext) {
                                      return ConfirmationDialog(
                                          forSubscribe: false,
                                          yes: () {
                                            if (exams.isNotifying) return;
                                            showProgressDialog(context);
                                            exams
                                                .removeNotifyMe(slug)
                                                .then((value) {
                                              Navigator.of(context).pop();
                                              if (value is String) {
                                                showSnackBar(context, value);
                                              }
                                            }).onError((error, stackTrace) {
                                              Navigator.of(context).pop();
                                              showSnackBar(context,
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
                                            if (exams.isNotifying) return;
                                            showProgressDialog(context);
                                            exams.notifyMe(slug).then((value) {
                                              Navigator.of(context).pop();
                                              if (value is String) {
                                                showSnackBar(context, value);
                                              }
                                            }).onError((error, stackTrace) {
                                              Navigator.of(context).pop();
                                              showSnackBar(context,
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
                        Navigator.of(context).pop();
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).padding.top)),
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
                                        _examName,
                                        const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: sharpGrey)),
                                  )),
                              _heading('General Details:'),
                              Column(
                                children: [
                                  _detailsRow('Total Posts',
                                      getTotalPosts(_exam).toString()),
                                  const SizedBox(height: 6),
                                  _detailsRow(
                                      '${_aspirantData.category?.optionName ?? 'N/A'} Category Posts',
                                      getTotalCategoryPosts(
                                              _aspirantData
                                                      .category?.optionId ??
                                                  0,
                                              _aspirantData.gender ?? 0,
                                              _exam)
                                          .toString()),
                                  const SizedBox(height: 6),
                                  _detailsRow(
                                      '${_aspirantData.category?.optionName ?? 'N/A'} ${Constants.genders[_aspirantData.gender ?? 0]} Fees',
                                      getExamFees(
                                              _aspirantData
                                                      .category?.optionId ??
                                                  0,
                                              _aspirantData.gender ?? 0,
                                              _exam)
                                          .toString()),
                                ],
                              ),
                              _heading('Important Dates:'),
                              Column(
                                children: [
                                  _detailsRow(
                                      'Application Start Date',
                                      _exam.formatAppStartDate?.toString() ??
                                          ''),
                                  const SizedBox(height: 6),
                                  _detailsRow('Application End Date',
                                      _exam.formatAppEndDate?.toString() ?? ''),
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
                            controller: tabController,
                          )),
                    ),
                  ),
                  SliverFillRemaining(
                      hasScrollBody: true,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
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
  void showViewImage(String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return ViewImageSheet(
          htmlContent: content,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}

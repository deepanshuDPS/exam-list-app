import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/home/widgets/card_bg.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/user/extras/view_image.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExamScreen extends StatefulWidget {
  static const routeName = "/resort-screen";

  const ExamScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends BaseState<ExamScreen> {
  // String _adNumber = "";
  String _examName = "";
  late ExamData _exam;
  late AspirantData _aspirantData;

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

  Widget _webViewData(String htmlContent) {
    final WebViewController controller = WebViewController();
    controller
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https://")) {
              // launchUrl(Uri.parse(request.url));
              return NavigationDecision.navigate;
            } else {
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadHtmlString(htmlContent);
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Stack(children: [
        GestureDetector(
            onVerticalDragUpdate: (updateDetails) {},
            child: WebViewWidget(
              controller: controller,
              gestureRecognizers: Set()
                ..add(Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())),
            )),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white60,
          margin: const EdgeInsets.all(2),
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  backgroundColor: const Color(0xFFDFDFDF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(color: Colors.black54, width: 1),
                  )),
              onPressed: () => {showViewImage(htmlContent)},
              child: const Text('Read More', style: TextStyle(color: sharpGrey, fontWeight: FontWeight.w500, fontSize: 14),)),
        )
      ]),
    );
  }

  Widget _detailsLink(Extras linkDetails) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightPink,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              linkDetails.name ?? "Notice",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            if (linkDetails.formattedDate.isNotEmpty)
              Text(
                linkDetails.formattedDate,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 9),
              ),
          ]),
          const Icon(
            Icons.open_in_new_rounded,
            size: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
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
                        if (getNotices(_exam).isNotEmpty)
                          _heading('Important Links:'),
                        ...getNotices(_exam).map((e) => _detailsLink(e)),
                        if (exams.extraHtmlContents.isNotEmpty ||
                            exams.htmlContents.isNotEmpty)
                          _heading('More Information:'),
                        if (exams.htmlContents.isNotEmpty)
                          ...exams.htmlContents
                              .map((content) => _webViewData(content)),
                      ],
                    ),
                  );
                })));
  }

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

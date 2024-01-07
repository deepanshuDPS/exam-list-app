import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/controllers/aspirant_exam_controller.dart';
import 'package:exam_list/controllers/aspirant_user_controller.dart';
import 'package:exam_list/exams/widgets/confirmation_dialog.dart';
import 'package:exam_list/exams/widgets/exam_list_item.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExamListingScreen extends GetWidget<AspirantExamController> {
  static const routeName = "/exam-listing-screen";

  // with AutomaticKeepAliveClientMixin<ExamListingScreen> {
  final AspirantUserController _userController = Get.find();

  ExamListingScreen({Key? key}) : super(key: key);

  final _searchTextController = TextEditingController();

  Widget _examCategory(int index) {
    var selectedIndex = controller.currentFilterIndex.value;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: selectedIndex == index ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selectedIndex == index ? Colors.red : Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          Constants.examCategories[index] ?? "All",
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : Colors.grey,
            fontSize: 14,
            fontWeight:
                selectedIndex == index ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _searchTextController.clear();
    _searchTextController.addListener(() {
      controller.filterList(query: _searchTextController.text);
    });
    _refreshData();
    return BaseImageContainer(
        opacity: 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              UnconstrainedBox(
                constrainedAxis: Axis.horizontal,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: EdgeInsets.only(
                          top: Get.mediaQuery.padding.top + 20,
                          left: 16,
                          right: 16),
                      decoration: const BoxDecoration(
                        color: lightPink,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi ${_userController.aspirantDetails?.name ?? "Aspirant"}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Check Your Exam',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 50),
                          ]),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.white, // You can change this color
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchTextController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon:
                                      _searchTextController.text.isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                _searchTextController.clear();
                                              },
                                            )
                                          : null,
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 38,
                  child: Obx(() {
                    var categoryList =
                        controller.examCategories.toList(growable: true);
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Update the selected index when an item is tapped
                            _searchTextController.clear();
                            controller.filterList(
                                index: categoryList[index], query: "");
                          },
                          child: _examCategory(categoryList[index]),
                        );
                      },
                    );
                  })),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                if (controller.examRequest.value.isLoading) {
                  return SizedBox(
                    height: Get.mediaQuery.size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  var list = controller.currentList.toList(growable: true);
                  if (list.isEmpty) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView(children: [
                          SizedBox(
                            height: (Get.mediaQuery.size.height - 230) / 2,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/ic_no_results.svg'),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'No exams',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: sharpGrey),
                                    )
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                            // physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ExamListItem(
                                exam: list[index],
                                aspirant: controller.updatedAspirantData,
                                onNotify: (slug) {
                                  showDialog<void>(
                                      context: context,
                                      builder: (BuildContext dContext) {
                                        return ConfirmationDialog(
                                            forSubscribe: true,
                                            yes: () {
                                              if (controller.isNotifying.value) {
                                                return;
                                              }
                                              showGetProgressDialog();
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
                                },
                                onRemoveNotify: (slug) {
                                  showDialog<void>(
                                      context: context,
                                      builder: (BuildContext dContext) {
                                        return ConfirmationDialog(
                                            forSubscribe: false,
                                            yes: () {
                                              if (controller.isNotifying.value) {
                                                return;
                                              }
                                              showGetProgressDialog();
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
                                },
                                onClick: () {
                                  // exams.setExam(list[index]);
                                  // Navigator.of(context)
                                  //     .pushNamed(ExamScreen.routeName);
                                },
                              );
                            }),
                      ),
                    );
                  }
                }
              })
            ],
          ),
        ));
  }

  // @override
  // bool get wantKeepAlive => true;

  Future<void> _refreshData() async {
    controller.fetchExams(controller.currentFilterIndex.value,
        controller.updatedAspirantData.subscribedChannels ?? []);
  }
}

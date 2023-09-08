import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/user/widgets/exam_list_item.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:provider/provider.dart';

class ExamListingScreen extends StatefulWidget {
  static const routeName = "/exam-listing-screen";

  const ExamListingScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExamListingScreen> createState() => _ExamListingScreenState();
}

class _ExamListingScreenState extends BaseState<ExamListingScreen> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final _searchTextController = TextEditingController();
  String currentText = '';

  ExamProvider _examProvider() {
    return Provider.of<ExamProvider>(context, listen: false);
  }

  UserProvider _userProvider() {
    return Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _examProvider().fetchExams(_selectedCategoryIndex);
      _searchTextController.addListener(() {
        setState(() {
          currentText = _searchTextController.value.text;
        });
      });
    }
    super.didChangeDependencies();
  }

  Widget _examCategory(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _selectedCategoryIndex == index ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _selectedCategoryIndex == index ? Colors.red : Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          Constants.examCategories[index] ?? "All",
          style: TextStyle(
            color: _selectedCategoryIndex == index ? Colors.white : Colors.grey,
            fontSize: 14,
            fontWeight: _selectedCategoryIndex == index
                ? FontWeight.w500
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      top: MediaQuery.of(context).padding.top + 20,
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
                        Consumer<UserProvider>(
                          child: const Text(
                            'Hi Aspirant',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                          builder: (context, user, child) {
                            if (user.aspirantDetails != null) {
                              return Text(
                                'Hi ${user.aspirantDetails?.name}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              );
                            }
                            return child!;
                          },
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                              suffixIcon: currentText.isNotEmpty
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Constants.examCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Update the selected index when an item is tapped
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                    _examProvider().setIndex(index);
                  },
                  child: _examCategory(index),
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<ExamProvider>(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context, exams, child) {
                if (exams.examRequest.isLoading) {
                  return child!;
                } else {
                  return Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: exams.currentList.length,
                        itemBuilder: (context, index) {
                          return ExamListItem(
                            exam: exams.currentList[index],
                            aspirant: _userProvider().aspirantDetails!,
                            onClick: () {
                              exams.setExam(exams.currentList[index]);
                              Navigator.of(context)
                                  .pushNamed(ExamScreen.routeName);
                            },
                          );
                        }),
                  );
                }
              })
        ],
      ),
    );
  }
}

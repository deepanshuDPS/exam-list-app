import 'package:exam_list/containers/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/exams_provider.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  static const routeName = "/resort-screen";

  const ExamScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends BaseState<ExamScreen> {
  String _adNumber = "";
  String _examName = "";

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _examName = Provider.of<ExamsProvider>(context,listen: false).exam?.examName??'N/A';
    }
    super.didChangeDependencies();
  }

  void _fetchData() {
    Provider.of<ExamsProvider>(context, listen: false).getResort(_adNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        titleText: _examName,
        isBackRequired: true,
        child: Consumer<ExamsProvider>(
            child: const ContainerLoading(),
            builder: (ctx, resort, ch) {
              // if (resort.examRequestData.isLoading) return ch!;
              // if (resort.examRequestData.isError) {
              //   return ContainerError(
              //       jsonData: resort.examRequestData.data,
              //       onTryAgain: () => _fetchData());
              // }

              // var resortData = resort.exam;
              // if (resortData != null) {
              var exam = Provider.of<ExamsProvider>(context).exam;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sub-Heading: General Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Post:'),
                              Text((exam?.totalPosts??0).toString()),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('OBC Category Post:'),
                              Text('data'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('OBC Male Fees:'),
                              Text('data'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sub-Heading: Important Dates',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Application Start Date:'),
                              Text(exam?.formatAppStartDate ?? ''),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Application End Date:'),
                              Text(exam?.formatAppEndDate ?? ''),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sub-Heading: Important Links',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Link Name'),
                                Text('Date', style: TextStyle(color: Colors.grey)),
                                Icon(Icons.link),
                              ],
                            ),
                            SizedBox(height: 8),
                            // Add more links here...
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              // } else {
              //   return ContainerError(jsonData: const {
              //     'message': 'Something went wrong!! Please, try again',
              //     'code': -1
              //   }, onTryAgain: () => _fetchData());
              // }
            }));
  }
}

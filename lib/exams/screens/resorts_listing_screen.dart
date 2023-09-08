import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/user/extras/otp_sheet.dart';
import 'package:exam_list/exams/widgets/resort_list_book_item.dart';
import 'package:exam_list/exams/widgets/resort_list_item.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart'
    as dest;
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

import '../../providers/exam_provider.dart';

class ResortsListingScreen extends StatefulWidget {
  static const routeName = "/resort-listing-screen";

  const ResortsListingScreen({Key? key}) : super(key: key);

  @override
  BaseState<ResortsListingScreen> createState() => _ResortsListingScreenState();
}

class _ResortsListingScreenState extends BaseState<ResortsListingScreen> {
  String _placeName = "--";
  late final String _dId;
  bool _isForBook = false;
  Map<String, String?>? _bodyData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      dynamic data;
      if (ModalRoute.of(context)?.settings.arguments is dest.Data) {
        data = ModalRoute.of(context)?.settings.arguments as dest.Data;
        _placeName = data.name ?? '--';
        _dId = data.id ?? "0";
      } else {
        _bodyData =
            ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
        _isForBook = true;
        _placeName = _bodyData?['city'] ?? '--';
        _dId = _bodyData?['place_id'] ?? '0';
      }
      _fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: _placeName,
      isAppBarColored: true,
      child: BaseImageContainer(
        opacity: 0.4,
        child: Consumer<ExamProvider>(
            child: const ContainerLoading(),
            builder: (ctx, resorts, ch) {
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
    // Provider.of<ExamsProvider>(context, listen: false).getDestinationResorts(_dId);
  }
}

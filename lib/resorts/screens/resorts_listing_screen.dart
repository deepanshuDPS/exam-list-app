import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/user/extras/booking_sheet.dart';
import 'package:exam_list/providers/resorts_provider.dart';
import 'package:exam_list/resorts/widgets/resort_list_book_item.dart';
import 'package:exam_list/resorts/widgets/resort_list_item.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart'
    as dest;
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

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
      isYellow: true,
      child: BaseImageContainer(
        opacity: 0.4,
        child: Consumer<ResortsProvider>(
            child: const ContainerLoading(),
            builder: (ctx, resorts, ch) {
              if (resorts.resortsListingRequestData.isLoading) {
                return ch!;
              } else if (resorts.resortsListingRequestData.isError) {
                return ContainerError(
                    jsonData: resorts.resortsListingRequestData.data,
                    onTryAgain: () => {_fetchData()});
              }
              var itemList = resorts.resortsList;

              return ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: resorts.resortsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _isForBook
                        ? ResortListBookItem(
                            data: itemList[index],
                            booking: (resortName) {
                              _bodyData?.putIfAbsent(
                                  'resort', () => resortName);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return BookingSheet(
                                      bodyData: _bodyData!, isOffer: false);
                                },
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              );
                            })
                        : ResortListItem(
                            data: itemList[index],
                            dId: _dId,
                          );
                  });
            }),
      ),
    );
  }

  void _fetchData() {
    Provider.of<ResortsProvider>(context, listen: false)
        .getDestinationResorts(_dId);
  }
}

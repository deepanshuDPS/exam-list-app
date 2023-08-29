import 'package:flutter/material.dart';
import 'package:exam_list/providers/search_provider.dart';
import 'package:exam_list/exams/widgets/resort_list_item.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart';
import 'package:exam_list/responseModels/search/search_places_response.dart'
    as search;

import 'package:exam_list/search/search_screen.dart';
import 'package:exam_list/search/widgets/dest_list_item.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:provider/provider.dart';

class AllPlacesScreen extends StatefulWidget {
  final SearchTypes type;
  final Function searchTryAgain;

  const AllPlacesScreen({Key? key, required this.type, required this.searchTryAgain}) : super(key: key);

  @override
  State<AllPlacesScreen> createState() => _AllPlacesScreenState();
}

class _AllPlacesScreenState extends State<AllPlacesScreen>
    with AutomaticKeepAliveClientMixin<AllPlacesScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Data> _getList(SearchProvider sProvider) {
    switch (widget.type) {
      case SearchTypes.domestic:
        return sProvider.domList;
      case SearchTypes.international:
        return sProvider.intList;
      default:
        return sProvider.exList;
    }
  }

  List<search.Data> _getSearchList(SearchProvider sProvider) {
    switch (widget.type) {
      case SearchTypes.domestic:
        return sProvider.sDomList;
      case SearchTypes.international:
        return sProvider.sIntList;
      default:
        return sProvider.sExList;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SearchProvider>(
        child: const ContainerLoading(),
        builder: (ctx, search, ch) {
          if (search.query.length > 2) {
            var itemList = _getSearchList(search);
            if (search.searchPlacesRequestData.isLoading) return ch!;
            if (search.searchPlacesRequestData.isError) {
              return ContainerError(
                  jsonData: search.searchPlacesRequestData.data,
                  onTryAgain: () => widget.searchTryAgain);
            }

            if (itemList.isEmpty) {
              return ContainerError(
                  jsonData: const {'message': 'No Data Found', 'code': 404},
                  onTryAgain: () => widget.searchTryAgain);
            }
            return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ResortListItem(
                    sData: itemList[index],
                    dId: itemList[index].destiId ?? "0",
                  );
                });
          } else {
            var itemList = _getList(search);
            if (search.allPlacesRequestData.isLoading) return ch!;
            if (search.allPlacesRequestData.isError && itemList.isEmpty) {
              return ContainerError(
                  jsonData: search.allPlacesRequestData.data,
                  onTryAgain: () => _fetchAllPlaces());
            }
            return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DestListItem(data: itemList[index]);
                });
          }
        });
  }

  @override
  bool get wantKeepAlive => true;

  void _fetchAllPlaces() {
    Provider.of<SearchProvider>(context, listen: false).getAllPlaces();
  }
}

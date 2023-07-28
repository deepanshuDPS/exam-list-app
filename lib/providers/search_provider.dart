import 'package:flutter/widgets.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart';
import 'package:exam_list/responseModels/search/search_places_response.dart'
    as search;

class SearchProvider with ChangeNotifier {
  final List<Data> _domesticList = [];
  final List<Data> _internationalList = [];
  final List<Data> _exchangeList = [];

  final List<search.Data> _sDomesticList = [];
  final List<search.Data> _sInternationalList = [];
  final List<search.Data> _sExchangeList = [];
  RequestData allPlacesRequestData = RequestData();
  RequestData searchPlacesRequestData = RequestData();

  void _notifyListenersWithBinding() {
    WidgetsBinding.instance?.addPostFrameCallback((status) {
      notifyListeners();
    });
  }

  void notifyWithRequest(RequestData data, bool isLoading) {
    data.isLoading = isLoading;
    if (isLoading) {
      data.data = null;
      data.isError = false;
    }
    _notifyListenersWithBinding();
  }

  String query = "";

  List<search.Data> get sDomList {
    return [..._sDomesticList];
  }

  List<search.Data> get sIntList {
    return [..._sInternationalList];
  }

  List<search.Data> get sExList {
    return [..._sExchangeList];
  }

  List<Data> get domList {
    return [..._domesticList];
  }

  List<Data> get intList {
    return [..._internationalList];
  }

  List<Data> get exList {
    return [..._exchangeList];
  }

  Future<void> getAllPlaces() async {
    if (_domesticList.isNotEmpty &&
        _internationalList.isNotEmpty &&
        _exchangeList.isNotEmpty) {
      return;
    }

    _domesticList.clear();
    _internationalList.clear();
    _exchangeList.clear();
    notifyWithRequest(allPlacesRequestData, true);
    final domesticRes = AllPlacesResponse.fromJson(await HttpRequests.instance()
        ?.httpGetRequest(ApiEndPoints.domesticPlaces));
    final internationalRes = AllPlacesResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.internationalPlaces));
    final exchangeRes = AllPlacesResponse.fromJson(await HttpRequests.instance()
        ?.httpGetRequest(ApiEndPoints.exchangePlaces));

    if (domesticRes.data?.isNotEmpty == true) {
      _domesticList.addAll(domesticRes.data!);
    }
    if (internationalRes.data?.isNotEmpty == true) {
      _internationalList.addAll(internationalRes.data!);
    }
    if (exchangeRes.data?.isNotEmpty == true) {
      _exchangeList.addAll(exchangeRes.data!);
    }
    for (var element in [domesticRes, internationalRes, exchangeRes]) {
      if (element.status == -1) {
        allPlacesRequestData.setErrorData(element.toJson());
      }
    }
    notifyWithRequest(allPlacesRequestData, false);
  }

  bool isAnyRequestToProceed(String searchedQuery) {
    _sDomesticList.clear();
    _sInternationalList.clear();
    _sExchangeList.clear();
    query = searchedQuery;
    if (query.length < 3) {
      _notifyListenersWithBinding();
      return false;
    }
    return true;
  }

  Future<void> searchPlaces(String searchedQuery) async {
    notifyWithRequest(searchPlacesRequestData, true);
    final searchResponse = search.SearchPlacesResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.searchPlaces + query.trim()));
    if (searchResponse.status == -1) {
      searchPlacesRequestData.setErrorData(searchResponse.toJson());
    } else {
      final resList = searchResponse.data!;
      _sDomesticList.addAll(resList
          .where((e) => e.destiCategory?.toLowerCase() == 'domestic')
          .toList());
      _sInternationalList.addAll(resList
          .where((e) => e.destiCategory?.toLowerCase() == 'international')
          .toList());
      _sExchangeList.addAll(resList
          .where((e) => e.destiCategory?.toLowerCase() == 'exchange')
          .toList());
    }
    notifyWithRequest(searchPlacesRequestData, false);
  }

  void clearSearchResults() {
    _sDomesticList.clear();
    _sExchangeList.clear();
    _sInternationalList.clear();
    query = '';
  }
}

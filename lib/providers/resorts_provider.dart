import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/resorts/get_resorts_response.dart'
    as resorts;
import 'package:exam_list/responseModels/resorts/resort_response.dart';

class ResortsProvider with ChangeNotifier {
  final List<resorts.Data> _resortsList = [];
  late Data? _resort;
  String _fetchedDestinationId = "";
  String _fetchedResort = "";
  RequestData resortsListingRequestData = RequestData();
  RequestData resortRequestData = RequestData();

  void notifyWithRequest(RequestData data, bool isLoading) {
    data.isLoading = isLoading;
    if (isLoading) {
      data.data = null;
      data.isError = false;
    }
    WidgetsBinding.instance?.addPostFrameCallback((status) {
      notifyListeners();
    });
  }

  List<resorts.Data> get resortsList {
    return [..._resortsList];
  }

  Data? get resort {
    return _resort;
  }

  Future<void> getDestinationResorts(String id) async {
    if (_fetchedDestinationId == id) {
      return;
    } else {
      _resortsList.clear();
      notifyWithRequest(resortsListingRequestData, true);
    }
    final getResortsResponse = resorts.GetResortsResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(
            ApiEndPoints.destinationResorts.replaceAll('{id}', id)));
    if (getResortsResponse.status == -1) {
      resortsListingRequestData.setErrorData(getResortsResponse.toJson());
    } else {
      _fetchedDestinationId = id;
      _resortsList.addAll(getResortsResponse.data!);
    }
    notifyWithRequest(resortsListingRequestData, false);
  }

  Future<void> getResort(String endPoint) async {
    if (_fetchedResort == endPoint) {
      return;
    } else {
      _resort = null;
      notifyWithRequest(resortRequestData, true);
    }
    final resortResponse = ResortResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(endPoint));

    if (resortResponse.status == -1) {
      resortRequestData.setErrorData(resortResponse.toJson());
    } else {
      _resort = resortResponse.data?.first;
      _fetchedResort = endPoint;
    }
    notifyWithRequest(resortRequestData, false);
  }
}

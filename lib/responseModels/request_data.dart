class RequestData {
  bool isLoading = true;
  bool isError = false;
  dynamic data;

  void setErrorData(Map<String, dynamic> json) {
    if(json['message'] == null) {
      json['message'] = 'No Data Found';
      json['status'] = false;
      json['code'] = 204;
    }
    data = json;
    isError = true;
  }

  get message => data['message'] ?? 'Something went wrong';
}

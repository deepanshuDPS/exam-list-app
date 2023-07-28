class RequestData {
  bool isLoading = true;
  bool isError = false;
  dynamic data;

  void setErrorData(Map<String, dynamic> json) {
    data = json;
    isError = true;
  }

  get message => data['message'] ?? 'Something went wrong';
}

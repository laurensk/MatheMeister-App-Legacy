class ApiError {
  int errorCode;
  String errorDesc;

  ApiError({this.errorCode, this.errorDesc});

  ApiError.fromJson(Map<String, dynamic> jsonMap) {
    this.errorCode = jsonMap['error_code'];
    this.errorDesc = jsonMap['error_desc'];
  }
}

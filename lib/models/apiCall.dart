import 'package:mathemeister/models/apiError.dart';

class ApiCall {
  bool error;
  ApiError apiError;
  var data;

  ApiCall({this.error, this.apiError, this.data});
  
}
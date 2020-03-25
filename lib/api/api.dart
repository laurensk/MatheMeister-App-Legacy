import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mathemeister/models/apiCall.dart';
import 'package:mathemeister/models/apiError.dart';

class Api {
  static final String v1 = "https://api.laurensk.at/mathemeister/api/v1/";
  static final productionApi = v1;

  static Future<ApiCall> getApiResponse(Map postDataMap) async {
    var body = jsonEncode(postDataMap);
    var response = await http.post(Api.productionApi,
        headers: {"Content-Type": "application/json"}, body: body);

    ApiCall apiCall;

    if (response.statusCode == 200) {
      apiCall = ApiCall(
        error: false,
        apiError: null,
        data: response
      );
    } else {
      ApiError apiError = ApiError.fromJson(json.decode(response.body));
      apiCall = ApiCall(
        error: true,
        apiError: apiError,
        data: null
      );
    }
    return apiCall;
  }
}
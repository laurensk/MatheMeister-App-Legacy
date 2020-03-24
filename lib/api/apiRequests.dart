import 'dart:convert';

import 'package:mathemeister/api/api.dart';
import 'package:mathemeister/models/apiCall.dart';
import 'package:mathemeister/models/category.dart';
import 'package:mathemeister/models/question.dart';

class ApiRequests {
  static Future<ApiCall> getCategories() async {
    Map postDataMap = {'action': 'get-categories'};

    ApiCall apiCall = await Api.getApiResponse(postDataMap);

    if (!apiCall.error && apiCall.data != null) {
      apiCall.data = (jsonDecode(apiCall.data.body) as List)
          .map((data) => Category.fromJson(data))
          .toList();
    }

    return apiCall;
  }

  static Future<ApiCall> getQuestionsCat(int catId) async {
    Map postDataMap = {
      'action': 'ten-for-category',
      'catId': '$catId',
      'answeredQuestionIds': '-1'
    };

    ApiCall apiCall = await Api.getApiResponse(postDataMap);

    if (!apiCall.error && apiCall.data != null) {
      apiCall.data = (jsonDecode(apiCall.data.body) as List)
          .map((data) => Question.fromJson(data))
          .toList();
    }

    return apiCall;
  }
}

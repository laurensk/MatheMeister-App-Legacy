import 'package:http/http.dart' as http;
import 'package:mathemeister/api/api.dart';
import 'package:mathemeister/models/category.dart';
import 'dart:convert';

class GetCategories {
  static Future<List<Category>> getCategories() async {

    Map data = {'action': 'get-categories'};

    var body = jsonEncode(data);

    var response = await http.post(Api.v1, headers: {"Content-Type": "application/json"}, body: body);

  List<Category> categories = (jsonDecode(response.body) as List)
      .map((data) => Category.fromJson(data))
      .toList();

  return categories;

  }
}

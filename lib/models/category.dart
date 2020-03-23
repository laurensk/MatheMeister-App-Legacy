class Category {
  final String catId;
  final String catName;
  final String catQuestions;

  Category.fromJson(Map<String, dynamic> jsonMap) :
    catId = jsonMap['cat_id'],
    catName = jsonMap['cat_name'],
    catQuestions = jsonMap['cat_qc'];
}
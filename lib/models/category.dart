class Category {
  String catId;
  String catName;
  String catQuestions;

  Category.fromJson(Map<String, dynamic> jsonMap) {
    this.catId = jsonMap['cat_id'];
    this.catName = jsonMap['cat_name'];
    this.catQuestions = jsonMap['cat_qc'];
  }
}

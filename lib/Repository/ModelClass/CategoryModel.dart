class CategoryModel {
  CategoryModel({
      this.id, 
      this.catName,});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    catName = json['Cat_name'];
  }
  int? id;
  String? catName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Cat_name'] = catName;
    return map;
  }
  static List<CategoryModel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => CategoryModel.fromJson(value)).toList();
  }
}
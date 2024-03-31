class CategoryModel {
  final int id;
  final String catName;
  final String catImg;

  CategoryModel({
    required this.id,
    required this.catName,
    required this.catImg,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      catName: json['catName'],
      catImg: json['catImg'],
    );
  }
}

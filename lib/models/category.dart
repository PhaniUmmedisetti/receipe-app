class Category {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription ": strCategoryDescription,
      };

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idCategory: json['idCategory'] ,
      strCategory: json['strCategory'],
      strCategoryDescription: json['strCategoryDescription'],
      strCategoryThumb: json['strCategoryThumb'],
    );
  }
}

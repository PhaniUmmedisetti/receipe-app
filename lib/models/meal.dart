
// Model for All the meal items
class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      strMeal: json['strMeal'] ,
      strMealThumb: json['strMealThumb'],
      idMeal: json['idMeal'],
    );
  }
}

// API end points for meals data
class ApiEndPoints {
  // Base urls of api
  static const baseUrl = "https://themealdb.com/api/json/v1/1";
  static const baseUrlFilter =
      "https://themealdb.com/api/json/v1/1/filter.php?c=";

  // Endpoint for filter by category

  static const category = "/categories.php";
  static const getAllCategoriesEndPoint = baseUrl + category;
}

const String mealDbName = "MealBox";

//'https://themealdb.com/api/json/v1/1/categories.php'

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

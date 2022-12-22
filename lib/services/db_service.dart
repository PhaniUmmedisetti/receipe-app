import 'package:hive/hive.dart';
import 'package:meals/constants.dart';

/// Service class which will contain methods which will interact with
/// the local database and perform specified actions.
class DatabaseService {
  /// Method to get if a meal is favorited based on single meal id.
  /// returns true if favorite else returns false;
  Future<bool> isMealFavorited(String id) async {
    var box = Hive.box(mealDbName);

    var value = await box.get(id);

    if (value == null || value == false) return false;

    return true;
  }

  /// Method to get all saved favorite meals.
  Future<List<String>> getAllFavoriteMeals() async {
    var box = Hive.box(mealDbName);

    var list = box.keys.toList();

    List<String> favorites = [];

    for (var i in list) {
      if (box.get(i) == true) {
        favorites.add(i.toString());
      }
    }

    return favorites;
  }

  /// Method to save a meal as favorite or remove from favorite.
  /// returns true if favorite else returns false;

  Future<bool> saveMealFavorite(String id, bool isFavorite) async {
    var box = Hive.box(mealDbName);

    await box.put(id, isFavorite);
    return isFavorite;
  }
}

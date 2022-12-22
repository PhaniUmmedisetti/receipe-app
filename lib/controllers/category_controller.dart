import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/services/db_service.dart';

import '../api/network_service.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../models/single_meal.dart';
import '../views/SIngle_meal_screen.dart';
import '../views/meal_screen.dart';

// Controller for CRUD operations
class CategoryController extends GetxController {
  @override
  void onInit() async {
    print("onInit state is initiated");
    isMainScreenLoading = true;
    await categoriesGetAll();
    super.onInit();
  }

  NetworkService api = Get.put(NetworkService());

  DatabaseService dbService = DatabaseService();

  List<Category> listOfCategories = [];
  List<Meal> listOfMeals = [];
  List<Meal> favouriteRecipes = [];
  late bool isMainScreenLoading;
  late bool isDataLoading;
  // List<SingleMeal> listOfSingleMealItems = [];

  // To get all the available categories

  Future categoriesGetAll() async {
    final res = await api.categoriesGetAll();

    if (res?.data == null) {
      await Get.dialog(const Dialog(
        child: Text(''),
      ));
      Get.back();
      return false;
    }
    for (var i in res?.data['categories']) {
      listOfCategories.add(Category.fromJson(i));
    }
    isMainScreenLoading = !isMainScreenLoading;
    update();
  }

// To get categories by their name
  Future getCategoryByName(String strCategory) async {
    // isDataLoading = true;
    //   update();

    final res = await api.categoryGetByName(strCategory: strCategory);

    if (res.data == null) {
      await Get.dialog(const Dialog(
        child: Text(''),
      ));
      Get.back();
      update();
    }
    for (var i in res.data['meals']) {
      listOfMeals.add(Meal.fromJson(i));
    }
    // isDataLoading = false;

    Get.to(() => MealScreen());
    // update();
  }

  // To get a category by its id
  SingleMeal? singleRes;

  bool isFavorite = false;

  Future<void> getCategoryByid(String idMeal) async {
    isDataLoading = true;

    final res = await api.categoryGetByid(idMeal: idMeal);
    update();
    print(res);
    singleRes = res;
    print(singleRes);
    isDataLoading = false;

    // isMainScreenLoading = !isMainScreenLoading;

    update();
  }

  ///Method to get the favourite meal from hive
  Future<void> getIsMealFavorite(String idMeal) async {
    isDataLoading = true;

    isFavorite = await dbService.isMealFavorited(idMeal);

    isDataLoading = false;
    update();
  }

  /// Medthod to set a meal to favourite if it isn't a favourite one.
  Future<void> setIsMealFavorite(String idMeal, bool val) async {
    isDataLoading = true;

    isFavorite = await dbService.saveMealFavorite(idMeal, val);

    isDataLoading = false;
    update();
  }

  goToSingleScreen(String id) {
    Get.to(SingleMealScreen(), arguments: {
      "idMeal": id,
    });
  }

// // To add meal to favourites list
//   void favouriteReceipe(Meal meal) {
//     if (favouriteRecipes.contains(meal)) {
//       //remove meal from favourite meals list
//       favouriteRecipes.remove(meal);
//       update();
//     } else {
//       //add meal to favourite meal list
//       favouriteRecipes.add(meal);
//       update();
//     }
//   }
}

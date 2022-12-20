import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  List<Category> listOfCategories = [];
  List<Meal> listOfMeals = [];
  List<Meal> favouriteMeals = [];
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

  goToSingleScreen(String id) {
    Get.to(SingleMealScreen(), arguments: {
      "idMeal": id,
    });
  }
// To add meal to favourites list
  void toggle(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      //remove meal from favourite meals list
      favouriteMeals.remove(meal);
      update();
    } else {
      //add meal to favourite meal list
      favouriteMeals.add(meal);
      update();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/network_service.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_single.dart';
import '../views/SIngle_meal_screen.dart';
import '../views/meal_screen.dart';

class CategoryController extends GetxController {
  @override
  void onInit() async {
    print("onInit state is initiated");
    await categoriesGetAll();
    super.onInit();
  }

  NetworkService api = Get.put(NetworkService());

  List<Category> listOfCategories = [];
  List<Meal> listOfMeals = [];
  // List<MealSingle> listOfSingleMealItems = [];

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
    update();
  }

// To get categories by their name
  Future getCategoryByName(String strCategory) async {
    final res = await api.categoryGetByName(strCategory: strCategory);

    if (res?.data == null) {
      await Get.dialog(const Dialog(
        child: Text(''),
      ));
      Get.back();
    }
    for (var i in res.data['meals']) {
      listOfMeals.add(Meal.fromJson(i));
    }
    Get.to(MealScreen());
    update();
  }

  // To get a category by its id
  MealSingle? singleRes;

  Future<void> getCategoryByid(String idMeal) async {
    final res = await api.categoryGetByid(idMeal: idMeal);

    print(res);
    singleRes = res;
    print(singleRes);

    update();
  }

  goToSingleScreen(String id) {
    Get.to(SingleMealScreen(), arguments: {
      "idMeal": id,
    });
  }
}

    // if (res.data == null || res as String) {
    //   await Get.dialog(const Dialog(
    //     child: Text(''),
    //   ));
    //   Get.back();
    // }
    // for (var i in res.data['single meal']) {
    //   listOfSingleMealItems.add(MealSingle.fromJson(i));
    // }
    // print("Single meal item");
    // Get.to(SingleScreen());
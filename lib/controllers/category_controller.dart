import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/meal_single.dart';
import 'package:meals/views/meal_screen.dart';

import '../api/dio_helpers.dart';
import '../views/Single_meal_screen.dart';

class CategoryController extends GetxController {
  @override
  void onInit() async {
    print("init");
    await categoriesGetAll();
    super.onInit();
  }

  DioHelpers api = Get.put(DioHelpers());

  List<Category> listOfCategories = [];
  List<Meal> listOfMeals = [];
  List<MealSingle> listOfSingleMealItems = [];

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

  Future getCategoryByName(String strCategory) async {
    final res = await api.categoryGetByName(strCategory: strCategory);

    if (res?.data == null) {
      await Get.dialog(const Dialog(
        child: Text(''),
      ));
      Get.back();
      return false;
    }
    for (var i in res.data['meals']) {
      listOfMeals.add(Meal.fromJson(i));
    }
    Get.to(MealScreen());
    update();
  }

  Future<void> getCategoryByid(String idMeal) async {
    final res = await api.categoryGetByid(idMeal: idMeal);

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
    update();
  }
}

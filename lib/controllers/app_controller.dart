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
class AppController extends GetxController {
  @override
  void onInit() async {
    print("onInit state is initiated");
    isMainScreenLoading = true;
    await categoriesGetAll();
    super.onInit();
  }

  NetworkService api = Get.put(NetworkService());
  final FocusNode textFocusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  DatabaseService dbService = DatabaseService();

  List<Category> listOfCategories = [];
  List<Category> listOfSearchedCategories = [];
  List<Meal> listOfMeals = [];
  List<Meal> listOfSearchedSingleMeals = [];
  List<Meal> favouriteRecipes = [];
  late bool isMainScreenLoading;
  late bool isDataLoading;
  bool isSelected = false;

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
    Get.to(() => MealScreen());
    // isDataLoading = true;
    isDataLoading = true;
    update();

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

    isDataLoading = false;
    update();
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

  // Function to search a category by its name in home screen
  searchMealByCategory(String value) {
    listOfSearchedCategories = listOfCategories
        .where((element) =>
            element.strCategory.toLowerCase().contains(value.toLowerCase()))
        .toList();
    if (textEditingController.text.isNotEmpty &&
        listOfSearchedCategories.isEmpty) {
      const Text('no data found');
      print("No Category Found!");
    }
    update();
  }

  // Function to search a single meal  by its name in home screen
  searchSingleMealByName(String value) {
    listOfSearchedSingleMeals = listOfMeals
        .where((element) =>
            element.strMeal.toLowerCase().contains(value.toLowerCase()))
        .toList();
    if (textEditingController.text.isEmpty &&
        listOfSearchedCategories.isEmpty) {
      const Text('no data');
      print("No meal Found!");
    }
    update();
  }

  // toggle function to select or unselect anything
  void toggle() {
    isSelected = !isSelected;
    update();
  }
}

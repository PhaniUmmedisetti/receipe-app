import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:meals/models/category.dart';

import '../api/dio_helpers.dart';

class CategoryController extends g.GetxController {
  @override
  void onInit() async {
    print("init");
    await categoriesGetAll();
    super.onInit();
  }

  DioHelpers api = g.Get.put(DioHelpers());

  List<Category> listOfCategories = [];

  Future categoriesGetAll() async {
    final res = await api.getAllCategories();
    // final result =

    // final result = (res as List).map((e) => Category.fromJson(e)).toList();
    // listOfCategories.addAll(result);

    if (res?.data == null) {
      await g.Get.dialog(const Dialog(
        child: Text(''),
      ));
      g.Get.back();
      return false;
    }
    for (var i in res?.data['categories']) {
      listOfCategories.add(Category.fromJson(i));
    }
    update();
  }
}

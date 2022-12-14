import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class SingleMealScreen extends StatelessWidget {
  SingleMealScreen({super.key});

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var mealId = Get.arguments["idMeal"];

    return GetBuilder<CategoryController>(initState: (_) async {
      await controller.getCategoryByid(mealId);
    }, builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Single Screen'),
        ),
      );
    });
  }
}

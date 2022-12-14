import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:meals/models/meal_single.dart';

import '../constants.dart';

class NetworkService extends g.GetxController {
  late Dio dio;

  NetworkService() {
    dio = Dio(
      BaseOptions(),
    );
  }

  // To fetch all the categories
  Future<Response?> categoriesGetAll() async {
    try {
      final res = await dio.get(
        ApiEndPoints.getAllCategoriesEndPoint,
      );
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202) return res;
      return res;
    } catch (err) {
      print('error in fetching All categories');
      print(err);

      if (err is DioError) {
        print(err);
        print(err.message);
        print(err.response?.data);

        // if (err.response?.data is String) return err.response?.data;
      }
      return null;
    }
  }

  // To fetch categories by their name
  Future categoryGetByName({required String strCategory}) async {
    try {
      final res = await dio.get(
        ApiEndPoints.baseUrlFilter + strCategory,
      );
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202) return res;
      return res;
    } catch (err) {
      if (err is DioError) {
        print(err);
        print(err.message);
        print(err.response?.data);
        // if (err.response?.data is String) return err.response?.data;
      }
      return null;
    }
  }

  Future<MealSingle?> categoryGetByid({required String idMeal}) async {
    try {
      final res = await dio.get(
        'https://themealdb.com/api/json/v1/1/filter.php?c=$idMeal',
      );
      if (res.statusCode == 200) {
        return MealSingle.fromJson(res.data['meals'][0]);
      }
      return null;
    } catch (err) {
      if (err is DioError) {
        if (err.response?.data is String) return err.response?.data;
      }
      return null;
    }
  }
}

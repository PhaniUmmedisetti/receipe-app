import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class DioHelpers extends g.GetxController {
  late Dio dio;

  DioHelpers() {
    dio = Dio(
      BaseOptions(
          // baseUrl: 'www.themealdb.com/api/json/v1/',
          // connectTimeout: 20000,
          ),
    );
  }

  Future<Response?> getAllCategories() async {
    try {
      final res = await dio.get(
        'https://themealdb.com/api/json/v1/1/categories.php',
      );
      if (res.statusCode == 200) return res;
      return res;
    } catch (err) {
      if (err is DioError) {
        if (err.response?.data is String) return err.response?.data;
      }
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meals/services/theme_service.dart';
import 'constants.dart';
import 'views/home_screen.dart.dart';

// This widget is the root of the application.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(mealDbName);
  // Opening box which is used to store user selected theme
  await Hive.openBox(themeDbName);
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeService themeService = Get.find<ThemeService>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      themeMode: themeService.currentThemeMode,
      theme: themeService.lightModeData,
      darkTheme: themeService.darkModeData,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomeScreen(),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    debugPrint("initial bindings called");
    Get.lazyPut(() => ThemeService(), fenix: true);
  }
}

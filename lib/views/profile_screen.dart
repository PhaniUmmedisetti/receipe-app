import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/services/theme_service.dart';

// Screen to change the theme ode of the app
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          // color: Colors.black,
          color: Theme.of(context).primaryColorLight,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile Screen',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GetBuilder<ThemeService>(builder: (controller) {
                  return Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeInSine,
                        switchOutCurve: Curves.easeOutSine,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          final offsetAnimation = Tween<Offset>(
                                  begin: const Offset(0.0, 0.8),
                                  end: const Offset(0.0, 0.0))
                              .animate(animation);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child: controller.currentThemeMode == ThemeMode.light
                            ? Icon(
                                Icons.sunny,
                                key: UniqueKey(),
                                size: 30.0,
                                color: Theme.of(context).primaryColorLight,
                              )
                            : Icon(
                                Icons.dark_mode,
                                key: UniqueKey(),
                                size: 30.0,
                                color: Theme.of(context).primaryColorLight,
                              ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      CupertinoSwitch(
                        value: controller.currentThemeMode == ThemeMode.light,
                        trackColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).highlightColor,
                        onChanged: (val) async {
                          if (val) {
                            // ref.read(themeController.notifier).changeTheme('light');
                            controller.setCurrentThemeMode(ThemeMode.light);
                          } else {
                            // ref.read(themeController.notifier).changeTheme('dark');
                            controller.setCurrentThemeMode(ThemeMode.dark);
                          }
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

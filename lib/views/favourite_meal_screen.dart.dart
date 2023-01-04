import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/api/network_service.dart';
import 'package:meals/models/single_meal.dart';
import 'package:meals/services/db_service.dart';
import 'package:meals/widgets/body_loader.dart';

import '../controllers/app_controller.dart';
import '../widgets/main_screen_card.dart';
import 'Single_meal_screen.dart';

// Screen that shows all the meals that are added to favourites list
class FavouriteMealScreen extends StatefulWidget {
  FavouriteMealScreen({super.key});
  final categoryController = Get.put(AppController());
  @override
  @override
  State<FavouriteMealScreen> createState() => _FavouriteMealScreenState();
}

class _FavouriteMealScreenState extends State<FavouriteMealScreen> {
  List<String> allDbData = [];
  var d = DatabaseService();

  var api = Get.find<NetworkService>();

  late bool isLoading;

  Future<void> getFavouriteList() async {
    setState(() {
      isLoading = true;
    });
    allDbData = await d.getAllFavoriteMeals();

    setState(() {
      isLoading = false;
    });
  }

  Future<SingleMeal?> getIndividualMeal(String id) async {
    return await api.getSingleMealById(idMeal: id);
  }

  @override
  void initState() {
    getFavouriteList();
    super.initState();
  }

  // final Future<String> _calculation =
  //     Future<String>.delayed(const Duration(seconds: 2), () => 'Data Loaded');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favourite Meals',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const BodyLoader()
          : SingleChildScrollView(
              // controller: controller,
              child: Column(
                children: <Widget>[
                  ...allDbData.map((e) => FutureBuilder(
                      future: getIndividualMeal(e),
                      builder: (context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          if (snap.data == null) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: const Text(" Error fetching this item"),
                            );
                          }

                          var item = snap.data as SingleMeal;
                          // return card here.
                          return MainScreenItemCard(
                            arrowIcon: Icons.arrow_right,
                            image: item.strMealThumb ?? '',
                            title: item.strMeal ?? '',
                            onTap: () {
                              Get.to(SingleMealScreen(), arguments: {
                                "idMeal": e,
                              });
                            },
                            favIcon: Icons.favorite_border_outlined,
                            // favIcon: Icons.favorite,
                          );
                        }

                        if (snap.hasError) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: const Text(" Error fetching this item"),
                          );
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: const LinearProgressIndicator(),
                        );
                      }))
                  //   ListView.builder(
                  //     itemCount: allDbData.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         child: Text(
                  //           allDbData[index].toString(),
                  //           style: const TextStyle(color: Colors.black),
                  //         ),
                  //       );
                  //     },
                  //   ),
                ],
              ),
            ),
    );
  }
}






// DefaultTextStyle(
//         style: Theme.of(context).textTheme.displayMedium!,
//         textAlign: TextAlign.center,
//         child: FutureBuilder<String>(
//           future: _calculation, // a previously-obtained Future<String> or null
//           builder: (context, mealDbName) {
//             List<Widget> children;
//             if (mealDbName.hasData) {
//               children = <Widget>[
//                 const Icon(
//                   Icons.check_circle_outline,
//                   color: Colors.green,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Result: ${mealDbName.data}'),
//                 ),
//               ];
//             } else if (mealDbName.hasError) {
//               children = <Widget>[
//                 const Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Error: ${mealDbName.error}'),
//                 ),
//               ];
//             } else {
//               children = const <Widget>[
//                 SizedBox(
//                   width: 60,
//                   height: 60,
//                   child: CircularProgressIndicator(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 16),
//                   child: Text('Awaiting result...'),
//                 ),
//               ];
//             }
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: children,
//               ),
//             );
//           },
//         ),
//       ),
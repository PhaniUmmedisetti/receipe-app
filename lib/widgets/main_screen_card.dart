import 'package:flutter/material.dart';



// Card for single category variety screen
class MainScreenItemCard extends StatelessWidget {
  final String image;
  final String title;
  final IconData arrowIcon;
  final IconData? favIcon;
  final Function onTap;

  const MainScreenItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.arrowIcon,
    required this.onTap,
    required this.favIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(31, 170, 163, 163),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        // color: ColorConstants.blue,
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              right: 11,
              left: 11,
            ),
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 6,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(image, scale: 1.0),
              radius: 30,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(favIcon),
                Icon(arrowIcon),
              ],
            ),
            onTap: () => onTap(),
          ),
        ),
      ),
    );
  }
}


// ListView(padding: const EdgeInsets.all(8), children: <Widget>[
//       Card(
//           child: ListTile(
//               title: Text(title),
//               leading: CircleAvatar(backgroundImage: NetworkImage(image)),
//               trailing: Icon(arrowIcon))),
//     ]);
import 'package:flutter/material.dart';

class MainScreenItemCard extends StatelessWidget {
  final String image;
  final String title;
  final IconData arrowIcon;
  final Function? onTap;

  const MainScreenItemCard(
      {super.key,
      required this.image,
      required this.title,
      required this.arrowIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8),
      child: Container(
        width: 420,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        // color: ColorConstants.blue,
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.all(1),
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 6,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image, scale: 1.0),
              radius: 30,
            ),
            trailing: Icon(arrowIcon),
            onTap: () => onTap,
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
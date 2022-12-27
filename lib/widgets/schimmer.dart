import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// import ‘package:flutter/material.dart’;
// import ‘package:shimmer/shimmer.dart’;
class MyShimmerEffectUI extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const MyShimmerEffectUI.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  const MyShimmerEffectUI.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey,
        period: const Duration(seconds: 3),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey,
            shape: shapeBorder,
          ),
        ),
      );
}

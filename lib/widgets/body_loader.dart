import "package:flutter/material.dart";

class BodyLoader extends StatelessWidget {
  const BodyLoader({
    super.key,
    this.strokeWidth = 4.0,
  });

  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

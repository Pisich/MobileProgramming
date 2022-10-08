import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerComponent(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: Colors.black,
        ),
      ),
    );
  }
}

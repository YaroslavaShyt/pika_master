import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainAnimationWidget extends StatelessWidget {
  const MainAnimationWidget({
    required this.path,
    this.height = 100,
    this.width = 100,
    this.animate = true,
    super.key,
  });

  final String path;
  final double height;
  final double width;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      path,
      height: height,
      width: width,
      animate: animate,
    );
  }
}

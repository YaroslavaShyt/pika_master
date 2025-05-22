import 'package:flutter/material.dart';
import 'package:pika_master/core/constants/animation_assets.dart';
import 'package:pika_master/presentation/widgets/animations/main_animation_widget.dart';

class PikachuAnimationWidget extends StatelessWidget {
  const PikachuAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAnimationWidget(
      height: 300,
      width: 300,
      path: AnimationAssets.pikachu,
    );
  }
}

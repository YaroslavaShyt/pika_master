import 'package:flutter/material.dart';

class CardContainerWidget extends StatelessWidget {
  const CardContainerWidget({
    required this.child,
    required this.shadowColor,
    required this.color,
    super.key,
  });

  final Widget child;
  final Color shadowColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(2, -2),
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.all(12),
      child: Center(child: child),
    );
  }
}

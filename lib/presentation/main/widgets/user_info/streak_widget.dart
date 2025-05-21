import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({
    required this.value,
    super.key,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.fireFlameCurved,
          size: 26,
          color: Colors.deepOrangeAccent,
        ),
        Text(
          "$value day(s) in a row!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

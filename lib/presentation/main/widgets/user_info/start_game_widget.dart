import 'package:flutter/material.dart';

class StartGameWidget extends StatelessWidget {
  const StartGameWidget({
    required this.xp,
    required this.onTap,
    super.key,
  });

  final int xp;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, -2),
                ),
              ],
            ),
            child: Text(
              "$xp xp",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, -2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Start Round",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

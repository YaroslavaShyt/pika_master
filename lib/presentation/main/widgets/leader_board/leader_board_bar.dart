import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaderBoardBar extends StatelessWidget {
  const LeaderBoardBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      foregroundColor: Colors.white,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.medal,
              size: 26,
              color: Colors.deepOrangeAccent,
            ),
            Text(
              context.tr("leaderboard"),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            FaIcon(
              FontAwesomeIcons.medal,
              size: 26,
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
        background: Container(
          margin: const EdgeInsetsDirectional.all(2),
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
        ),
      ),
    );
  }
}

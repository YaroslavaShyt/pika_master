import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pika_master/presentation/main/widgets/leader_board/leader_board_bar.dart';

class LeaderBoardWidget extends StatelessWidget {
  const LeaderBoardWidget({
    required this.leaders,
    super.key,
  });

  final List<Map<String, dynamic>> leaders;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const LeaderBoardBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Map<String, dynamic> user = leaders[index];

              return Container(
                margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                padding: const EdgeInsetsDirectional.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      user["profilePhoto"],
                    ),
                  ),
                  title: Row(
                    spacing: 6,
                    children: [
                      if (index == 0)
                        FaIcon(
                          FontAwesomeIcons.trophy,
                          color: Colors.yellow,
                        ),
                      if (index == 1)
                        FaIcon(
                          FontAwesomeIcons.medal,
                          color: Colors.orange,
                        ),
                      if (index == 2)
                        FaIcon(
                          FontAwesomeIcons.star,
                          color: Colors.black,
                        ),
                      Flexible(
                        child: Text(
                          user["name"],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${user['xp']} xp',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
            childCount: leaders.length,
          ),
        ),
      ],
    );
  }
}

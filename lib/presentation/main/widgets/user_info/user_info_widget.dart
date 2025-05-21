import 'package:flutter/material.dart';
import 'package:pika_master/presentation/main/widgets/user_info/avatar_widget.dart';
import 'package:pika_master/presentation/main/widgets/user_info/streak_widget.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.userName,
    required this.streak,
    this.avatarPath,
  });

  final String? avatarPath;
  final String userName;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(10),
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
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              AvatarWidget(
                avatarPath: avatarPath,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  StreakWidget(value: streak),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

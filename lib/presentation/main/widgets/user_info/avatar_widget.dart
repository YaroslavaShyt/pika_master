import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    required this.avatarPath,
    super.key,
  });

  final String? avatarPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (avatarPath == null || (avatarPath?.isEmpty ?? true))
              Icon(Icons.person)
            else
              Image.network(avatarPath!),
          ],
        ),
      ),
    );
  }
}

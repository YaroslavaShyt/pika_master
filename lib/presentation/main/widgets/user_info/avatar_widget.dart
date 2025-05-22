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
      height: 70,
      width: 70,
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
              Image.network(
                avatarPath!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  final expected = loadingProgress.expectedTotalBytes;
                  final loaded = loadingProgress.cumulativeBytesLoaded;

                  return Center(
                    child: CircularProgressIndicator(
                      value: expected != null ? loaded / expected : null,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

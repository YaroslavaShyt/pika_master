import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';
import 'package:pika_master/presentation/widgets/buttons/main_outlined_button.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.onTap,
    required this.isLoading,
    super.key,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = getColorScheme(context);

    return MainOutlinedButton(
      onPressed: onTap,
      child: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...[
            SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                color: colorScheme.onSurface,
              ),
            ),
          ] else ...[
            FaIcon(
              FontAwesomeIcons.google,
              color: colorScheme.onSurface,
            ),
          ],
          Text(
            "Sign in with Google",
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

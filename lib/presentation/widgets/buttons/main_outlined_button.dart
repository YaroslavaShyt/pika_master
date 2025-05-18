import 'package:flutter/material.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';

class MainOutlinedButton extends StatelessWidget {
  const MainOutlinedButton({
    required this.onPressed,
    required this.child,
    this.color,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = getColorScheme(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          color ?? colorScheme.primary,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: colorScheme.primary),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsetsDirectional.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
        ),
        overlayColor: WidgetStatePropertyAll(
          colorScheme.onSurface.withValues(alpha: 0.12),
        ),
      ),
      child: child,
    );
  }
}

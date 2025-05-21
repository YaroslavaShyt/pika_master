import 'package:flutter/material.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';

class SilhouetteWidget extends StatefulWidget {
  const SilhouetteWidget({
    super.key,
    required this.imageUrl,
    required this.isRevealed,
  });

  final String imageUrl;
  final bool isRevealed;

  @override
  State<SilhouetteWidget> createState() => _SilhouetteWidgetState();
}

class _SilhouetteWidgetState extends State<SilhouetteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant SilhouetteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRevealed) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = getColorScheme(context);
    final double height = MediaQuery.sizeOf(context).height / 4;

    return SizedBox(
      height: height,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  colorScheme.surface.withValues(
                    alpha: widget.isRevealed ? 0 : _glowAnimation.value,
                  ),
                  Colors.transparent,
                ],
                stops: const [0.7, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                widget.isRevealed ? Colors.transparent : Colors.black,
                BlendMode.srcATop,
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  widget.imageUrl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({
    required this.answerText,
    required this.answerImagePath,
    required this.shouldShowAnswerImage,
    required this.onAnswerSelected,
    required this.isSelected,
    required this.isFlipped,
    required this.isSelectedCorrect,
    super.key,
  });

  final String answerText;
  final String answerImagePath;
  final bool shouldShowAnswerImage;
  final void Function(String) onAnswerSelected;
  final bool isSelected;
  final bool isFlipped;
  final bool isSelectedCorrect;

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> with TickerProviderStateMixin {
  late AnimationController _shadowController;
  late Animation<double> _elevationAnimation;
  late AnimationController _flipController;

  @override
  void initState() {
    super.initState();

    _shadowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _elevationAnimation =
        Tween<double>(begin: 4, end: 12).animate(_shadowController);

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant AnswerCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFlipped && !_flipController.isCompleted) {
      _flipController.forward();
      _shadowController.stop();
    }
  }

  @override
  void dispose() {
    _shadowController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_flipController, _elevationAnimation]),
      builder: (context, child) {
        final angle = _flipController.value * pi;
        final isBackVisible = angle > (pi / 2);

        return PhysicalModel(
          color: Colors.white,
          elevation: _elevationAnimation.value,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: () {
              if (!widget.isFlipped) {
                widget.onAnswerSelected(widget.answerText);
              }
            },
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isBackVisible ? _buildBackCard() : _buildFrontCard(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFrontCard() {
    return _cardContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.answerText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: _cardContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 116,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  widget.answerImagePath,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.answerText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardContainer({
    required Widget child,
    Color color = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 4,
          color: widget.isSelected
              ? widget.isSelectedCorrect
                  ? Colors.black
                  : Colors.red
              : Colors.transparent,
        ),
      ),
      padding: const EdgeInsetsDirectional.all(12),
      child: Center(child: child),
    );
  }
}

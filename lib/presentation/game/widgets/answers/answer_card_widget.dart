import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pika_master/presentation/game/widgets/answers/card_container_widget.dart';

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
  late AnimationController _flipController;

  @override
  void initState() {
    super.initState();

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
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipController,
      builder: (context, child) {
        final double angle = _flipController.value * pi;
        final bool isBackVisible = angle > (pi / 2);

        return PhysicalModel(
          color: Colors.white,
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
          spacing: 8,
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

  Widget _cardContainer({required Widget child}) {
    final Color color = widget.isSelected
        ? widget.isSelectedCorrect
            ? Colors.black
            : Colors.red
        : Colors.transparent;

    return CardContainerWidget(
      shadowColor: color,
      color: Colors.white,
      child: child,
    );
  }
}

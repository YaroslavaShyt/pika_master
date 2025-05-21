import 'package:flutter/material.dart';
import 'package:pika_master/presentation/main/game/widgets/answers/answer_card_widget.dart';

class AnswerOptionsWidget extends StatelessWidget {
  const AnswerOptionsWidget({
    required this.answerOptions,
    required this.onAnswerSelected,
    required this.shouldShowAnswerImage,
    required this.isSelectedCorrect,
    this.selectedAnswer,
    super.key,
  });

  final Map<String, String> answerOptions;
  final void Function(String) onAnswerSelected;
  final bool shouldShowAnswerImage;
  final String? selectedAnswer;
  final bool isSelectedCorrect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: MediaQuery.sizeOf(context).width,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: answerOptions.length,
        itemBuilder: (context, index) {
          final entry = answerOptions.entries.elementAt(index);
          final bool isSelected = selectedAnswer == entry.key;
          final bool isFlipped = selectedAnswer != null;

          return AnswerCard(
            answerText: entry.key,
            answerImagePath: entry.value,
            onAnswerSelected: onAnswerSelected,
            shouldShowAnswerImage: shouldShowAnswerImage,
            isSelected: isSelected,
            isFlipped: isFlipped,
            isSelectedCorrect: isSelectedCorrect,
          );
        },
      ),
    );
  }
}

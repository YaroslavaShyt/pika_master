import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/presentation/main/game/bloc/game_cubit.dart';
import 'package:pika_master/presentation/main/game/bloc/game_state.dart';
import 'package:pika_master/presentation/main/game/widgets/answers/answer_options_widget.dart';
import 'package:pika_master/presentation/main/game/widgets/pokemon/silholuette_widget.dart';
import 'package:pika_master/presentation/widgets/texts/medium_text.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    required this.cubit,
    super.key,
  });

  final GameCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state.status == GameStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == GameStatus.failure) {
            return Center(child: Text("Oops"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.pokemon != null) ...[
                  SilhouetteWidget(
                    imageUrl: state.pokemon!.image,
                    isRevealed: state.shouldShowImageAnswer,
                  ),
                  if (state.gameFlowStatus == GameFlowStatus.correctAnswer) ...[
                    MediumText(text: "You caught it! 🎉"),
                  ],
                  if (state.gameFlowStatus ==
                      GameFlowStatus.incorrectAnswer) ...[
                    MediumText(text: "Oops! It was ${state.pokemon!.name} 😅"),
                  ],
                  Text(state.pokemon!.name),
                ],
                AnswerOptionsWidget(
                  answerOptions: state.answerOptions,
                  onAnswerSelected: cubit.onAnswerSelected,
                  shouldShowAnswerImage: state.shouldShowImageAnswer,
                  selectedAnswer: state.selectedAnswer,
                  isSelectedCorrect:
                      state.pokemon?.name == state.selectedAnswer,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

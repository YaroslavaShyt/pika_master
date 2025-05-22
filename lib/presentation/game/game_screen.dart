import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/presentation/game/bloc/game_cubit.dart';
import 'package:pika_master/presentation/game/bloc/game_state.dart';
import 'package:pika_master/presentation/game/widgets/answers/answer_options_widget.dart';
import 'package:pika_master/presentation/game/widgets/pokemon/silholuette_widget.dart';
import 'package:pika_master/presentation/widgets/buttons/main_outlined_button.dart';
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
      body: SafeArea(
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state.status == GameStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.status == GameStatus.failure) {
              return Center(child: Text(context.tr("oops")));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    if (state.gameFlowStatus == GameFlowStatus.chooseAnswer)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 30),
                        child: MediumText(text: context.tr("whoThatPokemon")),
                      ),
                    if (state.pokemon != null) ...[
                      SilhouetteWidget(
                        imageUrl: state.pokemon!.image,
                        isRevealed: state.shouldShowImageAnswer,
                      ),
                      if (state.gameFlowStatus ==
                          GameFlowStatus.correctAnswer) ...[
                        MediumText(text: context.tr("youCaughtIt")),
                      ],
                      if (state.gameFlowStatus ==
                          GameFlowStatus.incorrectAnswer) ...[
                        MediumText(
                          text: context.tr(
                            "oopsItWas.pokemonName",
                            args: [
                              state.pokemon!.name,
                            ],
                          ),
                        ),
                      ],
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
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainOutlinedButton(
                        onPressed: cubit.onBackTap,
                        child: Text(
                          context.tr("back"),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      if (state.gameFlowStatus != GameFlowStatus.chooseAnswer)
                        MainOutlinedButton(
                          onPressed: cubit.onStartAgainTap,
                          child: Text(
                            context.tr("startAgain"),
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

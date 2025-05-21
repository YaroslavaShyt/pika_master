import 'package:equatable/equatable.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';

enum GameStatus { loading, success, failure }

enum GameFlowStatus { chooseAnswer, correctAnswer, incorrectAnswer }

class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.loading,
    this.answerOptions = const {},
    this.pokemon,
    this.gameFlowStatus = GameFlowStatus.chooseAnswer,
    this.shouldShowImageAnswer = false,
    this.selectedAnswer,
  });

  GameState copyWith({
    GameStatus? status,
    GameFlowStatus? gameFlowStatus,
    Map<String, String>? answerOptions,
    IPokemon? pokemon,
    String? selectedAnswer,
  }) {
    return GameState(
      status: status ?? this.status,
      gameFlowStatus: gameFlowStatus ?? this.gameFlowStatus,
      pokemon: pokemon ?? this.pokemon,
      answerOptions: answerOptions ?? this.answerOptions,
      shouldShowImageAnswer: gameFlowStatus != GameFlowStatus.chooseAnswer,
      selectedAnswer: gameFlowStatus == GameFlowStatus.chooseAnswer
          ? null
          : selectedAnswer ?? this.selectedAnswer,
    );
  }

  final GameStatus status;
  final IPokemon? pokemon;
  final Map<String, String> answerOptions;
  final GameFlowStatus gameFlowStatus;
  final bool shouldShowImageAnswer;
  final String? selectedAnswer;

  @override
  List<Object?> get props => [
        status,
        pokemon,
        answerOptions,
        gameFlowStatus,
        shouldShowImageAnswer,
        selectedAnswer,
      ];
}

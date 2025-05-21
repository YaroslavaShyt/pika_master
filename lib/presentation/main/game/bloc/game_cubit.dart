import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/constants/config_constants.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/game/igame_data.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';
import 'package:pika_master/presentation/main/game/bloc/game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required IGameService gameService,
  })  : _gameService = gameService,
        super(const GameState());

  final IGameService _gameService;

  Future<void> fetchGameData() async {
    try {
      final IGameData gameData = await _gameService.fetchGameData();

      if (gameData.answerOptions.length < ConfigConstants.maxPokemonQuantity) {
        emit(state.copyWith(status: GameStatus.failure));
        return;
      }

      final List<IPokemon> shuffledOptions = gameData.answerOptions..shuffle();

      emit(
        state.copyWith(
          status: GameStatus.success,
          gameFlowStatus: GameFlowStatus.chooseAnswer,
          answerOptions: {
            for (final pokemon in shuffledOptions) pokemon.name: pokemon.image,
          },
          pokemon: gameData.pokemon,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: GameStatus.failure));
      logger.e(error);
    }
  }

  void onAnswerSelected(String pokemonName) {
    final GameFlowStatus gameFlowStatus = pokemonName == state.pokemon?.name
        ? GameFlowStatus.correctAnswer
        : GameFlowStatus.incorrectAnswer;

    emit(
      state.copyWith(
        gameFlowStatus: gameFlowStatus,
        selectedAnswer: pokemonName,
      ),
    );
  }
}

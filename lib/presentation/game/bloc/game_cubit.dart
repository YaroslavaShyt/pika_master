import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/constants/config_constants.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/game/igame_data.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/presentation/game/bloc/game_state.dart';

const int _xpReward = 10;

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required IGameService gameService,
    required VoidCallback onGameFinished,
    required IUserService userService,
    required INavigationUtil navigationUtil,
  })  : _gameService = gameService,
        _onGameFinished = onGameFinished,
        _userService = userService,
        _navigationUtil = navigationUtil,
        super(const GameState());

  final IGameService _gameService;
  final VoidCallback _onGameFinished;
  final IUserService _userService;
  final INavigationUtil _navigationUtil;

  Future<void> fetchGameData() async {
    try {
      emit(
        state.copyWith(
          status: GameStatus.loading,
          gameFlowStatus: GameFlowStatus.chooseAnswer,
          selectedAnswer: '',
        ),
      );
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

    if (gameFlowStatus == GameFlowStatus.correctAnswer) {
      _userService.updateUser(xp: _xpReward);
    }
  }

  void onStartAgainTap() {
    fetchGameData();
  }

  void onBackTap() {
    if (state.gameFlowStatus != GameFlowStatus.chooseAnswer) {
      _onGameFinished();
    }
    _navigationUtil.navigateBack();
  }
}

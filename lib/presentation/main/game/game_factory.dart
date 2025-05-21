import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/presentation/main/game/bloc/game_cubit.dart';
import 'package:pika_master/presentation/main/game/game_screen.dart';

class GameFactory {
  static Widget build() {
    return BlocProvider(
      create: (context) => GameCubit(
        gameService: sl.get<IGameService>(),
      )..fetchGameData(),
      child: Builder(
        builder: (context) {
          return GameScreen(
            cubit: BlocProvider.of<GameCubit>(context),
          );
        },
      ),
    );
  }
}

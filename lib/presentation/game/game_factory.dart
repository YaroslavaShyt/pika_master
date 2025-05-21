import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/presentation/game/bloc/game_cubit.dart';
import 'package:pika_master/presentation/game/game_screen.dart';

class GameRoutingArgs {
  GameRoutingArgs({
    required this.onGameFinished,
  });

  final VoidCallback onGameFinished;
}

class GameFactory {
  static Widget build(GameRoutingArgs args) {
    return BlocProvider(
      create: (context) => GameCubit(
        gameService: sl.get<IGameService>(),
        userService: sl.get<IUserService>(),
        onGameFinished: args.onGameFinished,
        navigationUtil: sl.get<INavigationUtil>(),
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

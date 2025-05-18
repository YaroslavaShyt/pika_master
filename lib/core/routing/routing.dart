import 'package:flutter/material.dart';
import 'package:pika_master/core/routing/routes.dart';
import 'package:pika_master/presentation/main/game/game_factory.dart';
import 'package:pika_master/presentation/main/main_factory.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.routeGame => _buildGameScreen(settings),
      _ => _buildMainScreen(settings),
    };
  }

  static PageRoute _buildGameScreen(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => GameFactory.build(),
    );
  }

  static PageRoute _buildMainScreen(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => MainFactory.build(),
    );
  }
}

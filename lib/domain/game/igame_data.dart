import 'package:pika_master/domain/pokemon/ipokemon.dart';

abstract interface class IGameData {
  IGameData({
    required this.pokemon,
    required this.answerOptions,
  });

  final IPokemon pokemon;
  final List<IPokemon> answerOptions;
}

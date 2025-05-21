import 'package:pika_master/domain/game/igame_data.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';

class GameData implements IGameData {
  GameData({
    required this.pokemon,
    required this.answerOptions,
  });

  @override
  final IPokemon pokemon;

  @override
  final List<IPokemon> answerOptions;
}

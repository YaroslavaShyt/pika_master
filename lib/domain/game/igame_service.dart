import 'package:pika_master/domain/game/igame_data.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';

abstract interface class IGameService {
  Future<IGameData> fetchGameData();

  Future<IPokemon> fetchPokemonInfo(int id);
}

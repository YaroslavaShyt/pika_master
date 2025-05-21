import 'dart:math';

import 'package:pika_master/core/constants/config_constants.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/data/game/game_data.dart';
import 'package:pika_master/domain/game/igame_data.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';
import 'package:pika_master/domain/pokemon/ipokemon_repository.dart';
import 'package:pika_master/domain/utils/irandom_generator_util.dart';

class GameService implements IGameService {
  GameService({
    required IRandomGeneratorUtil randomGeneratorUtil,
    required IPokemonRepository pokemonRepository,
  })  : _randomGeneratorUtil = randomGeneratorUtil,
        _pokemonRepository = pokemonRepository;

  final IRandomGeneratorUtil _randomGeneratorUtil;
  final IPokemonRepository _pokemonRepository;

  @override
  Future<IGameData> fetchGameData() async {
    try {
      final Set<int> generatedIds = _randomGeneratorUtil.generateNumbers(
        quantity: ConfigConstants.maxPokemonQuantity,
      );
      final int pokemonId = generatedIds.elementAt(Random().nextInt(4) + 1);

      final List<Object> data = await Future.wait(
        [
          _pokemonRepository.getPokemon(pokemonId),
          _pokemonRepository.fetchBasicPokemonList(
            offset: pokemonId - 1,
            limit: ConfigConstants.maxPokemonQuantity,
          )
        ],
      );

      return GameData(
        pokemon: data.first as IPokemon,
        answerOptions: data.last as List<IPokemon>,
      );
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }

  @override
  Future<IPokemon> fetchPokemonInfo(int id) async {
    try {
      return _pokemonRepository.getPokemon(id);
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }
}

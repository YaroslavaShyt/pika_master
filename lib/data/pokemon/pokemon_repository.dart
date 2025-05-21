import 'package:dio/dio.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/data/networking/endpoints.dart';
import 'package:pika_master/data/pokemon/pokemon.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';
import 'package:pika_master/domain/pokemon/ipokemon_repository.dart';
import 'package:pika_master/domain/utils/ibackground_parser_util.dart';

class PokemonRepository implements IPokemonRepository {
  PokemonRepository({
    required INetworkClient networkClient,
    required IParseDataUtil parseDataUtil,
  })  : _networkClient = networkClient,
        _parseDataUtil = parseDataUtil;

  final INetworkClient _networkClient;
  final IParseDataUtil _parseDataUtil;

  @override
  Future<IPokemon> getPokemon(int id) async {
    try {
      final Response? response = await _networkClient.get(
        endpoint: "${Endpoints.pokemonEndpoint}/$id",
      );

      if (response != null && response.data != null) {
        return _parseDataUtil.fromJson(
          json: response.data,
          fromJsonFunction: Pokemon.fromJson,
        );
      }

      throw Exception("Pokemon can't be null");
    } catch (error) {
      logger.e(error);
      rethrow;
    }
  }

  @override
  Future<List<IPokemon>> fetchBasicPokemonList({
    int limit = 10,
    int offset = 0,
  }) async {
    final Response? response = await _networkClient.get(
      endpoint: Endpoints.pokemonEndpoint,
      queryParameters: {"limit": limit, "offset": offset},
    );

    if (response == null || response.data == null) return [];

    final List results = response.data['results'] as List;
    final List<IPokemon> pokemonList = results.asMap().entries.map(
      (entry) {
        final index = offset + entry.key + 1;
        final name = entry.value['name'];
        return Pokemon.fromNameAndId(name, index);
      },
    ).toList();

    return pokemonList;
  }
}

import 'package:dio/dio.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/data/networking/endpoints.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';
import 'package:pika_master/domain/pokemon/ipokemon_repository.dart';

class PokemonRepository implements IPokemonRepository {
  PokemonRepository({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  final INetworkClient _networkClient;

  @override
  Future<IPokemon?> getPokemon(int id) async {
    try {
      final Response? response = await _networkClient.get(
        endpoint: "${Endpoints.pokemonEndpoint}/$id",
      );
    } catch (error) {
      logger.e(error);
    }
    return null;
  }
}

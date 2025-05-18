import 'package:pika_master/domain/pokemon/ipokemon.dart';

abstract interface class IPokemonRepository {
  Future<IPokemon?> getPokemon(int id);
}

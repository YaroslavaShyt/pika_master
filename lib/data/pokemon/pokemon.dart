import 'package:pika_master/data/networking/endpoints.dart';
import 'package:pika_master/domain/pokemon/ipokemon.dart';

class Pokemon implements IPokemon {
  const Pokemon({
    required this.name,
    required this.image,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      image: json['sprites']['front_default'],
    );
  }

  factory Pokemon.fromNameAndId(String name, int id) {
    return Pokemon(
      name: name,
      image: '${Endpoints.pokemonImageEndpoint}/$id.png',
    );
  }

  @override
  final String image;

  @override
  final String name;
}

import 'package:pika_master/domain/pokemon/ipokemon.dart';

class Pokemon implements IPokemon {
  const Pokemon({
    required this.name,
    required this.image,
  });

  @override
  final String image;

  @override
  final String name;
}

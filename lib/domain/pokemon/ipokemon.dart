abstract interface class IPokemon {
  const IPokemon({
    required this.name,
    required this.image,
  });

  final String image;
  final String name;
}

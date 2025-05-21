abstract interface class ILeader {
  ILeader({
    required this.name,
    required this.profilePhoto,
    required this.xp,
  });

  final String name;
  final int xp;
  final String? profilePhoto;
}

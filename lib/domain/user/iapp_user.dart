abstract interface class IAppUser {
  IAppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
    this.streak,
    this.achievements = const [],
    this.xp,
  });

  final String id;
  final String name;
  final String? email;
  final int? streak;
  final List<String> achievements;
  final String? profilePhoto;
  final int? xp;

  Map<String, dynamic> toJson();

  IAppUser copyWith({
    int? xp,
    int? streak,
  });
}

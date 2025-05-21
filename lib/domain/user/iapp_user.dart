abstract interface class IAppUser {
  IAppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
    this.streak,
    this.achievements = const [],
  });

  final String id;
  final String name;
  final String? email;
  final int? streak;
  final List<String> achievements;
  final String? profilePhoto;

  Map<String, dynamic> toJson();
}

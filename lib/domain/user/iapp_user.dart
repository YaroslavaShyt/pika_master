abstract interface class IAppUser {
  IAppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
    this.streak,
    this.xp,
    this.lastActiveAt,
  });

  final String id;
  final String name;
  final String? email;
  final int? streak;
  final String? profilePhoto;
  final int? xp;
  final DateTime? lastActiveAt;

  Map<String, dynamic> toJson();

  IAppUser copyWith({
    int? xp,
    int? streak,
    DateTime? lastActiveAt,
  });
}

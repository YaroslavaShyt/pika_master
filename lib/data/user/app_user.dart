import 'package:pika_master/domain/user/iapp_user.dart';

class AppUser implements IAppUser {
  AppUser({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.email,
    this.streak,
    this.achievements = const [],
    this.xp,
  });

  @override
  Map<String, dynamic> toJson() => {
        'streak': streak,
        'achievements': achievements,
        'profilePhoto': profilePhoto,
        "xp": xp,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      streak: json['streak'] ?? 0,
      achievements: List<String>.from(json['achievements'] ?? []),
      profilePhoto: json['profilePhoto'],
      xp: json['xp'],
    );
  }

  @override
  final String id;

  @override
  final String name;

  @override
  final String? email;

  @override
  final String? profilePhoto;

  @override
  final int? streak;

  @override
  final int? xp;

  @override
  final List<String> achievements;
}

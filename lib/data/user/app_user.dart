import 'package:pika_master/domain/user/iapp_user.dart';

class AppUser implements IAppUser {
  AppUser({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.email,
    this.streak = 0,
    this.xp = 0,
  });

  @override
  IAppUser copyWith({
    int? xp,
    int? streak,
    DateTime? lastActiveDate,
  }) {
    return AppUser(
      id: id,
      name: name,
      email: email,
      profilePhoto: profilePhoto,
      streak: streak ?? this.streak,
      xp: xp != null ? xp + this.xp : this.xp,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'streak': streak,
        'profilePhoto': profilePhoto,
        "xp": xp,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      streak: json['streak'] ?? 0,
      profilePhoto: json['profilePhoto'],
      xp: json['xp'] ?? 0,
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
  final int streak;

  @override
  final int xp;
}

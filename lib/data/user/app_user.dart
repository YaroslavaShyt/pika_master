import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pika_master/domain/user/iapp_user.dart';

class AppUser implements IAppUser {
  AppUser({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.email,
    this.streak = 0,
    this.xp = 0,
    this.lastActiveAt,
  });

  @override
  IAppUser copyWith({
    int? xp,
    int? streak,
    DateTime? lastActiveAt,
  }) {
    return AppUser(
      id: id,
      name: name,
      email: email,
      profilePhoto: profilePhoto,
      streak: streak ?? this.streak,
      xp: xp != null ? xp + this.xp : this.xp,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        if (email != null) 'email': email,
        'streak': streak,
        'profilePhoto': profilePhoto,
        "xp": xp,
        'lastActiveAt': lastActiveAt,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final timestamp = json['lastActiveAt'];
    final lastActive = timestamp is Timestamp ? timestamp.toDate() : null;

    return AppUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      streak: json['streak'] ?? 0,
      profilePhoto: json['profilePhoto'],
      xp: json['xp'] ?? 0,
      lastActiveAt: lastActive,
      email: json['email'],
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

  @override
  final DateTime? lastActiveAt;
}

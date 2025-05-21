import 'package:pika_master/domain/leader/ileader.dart';

class Leader implements ILeader {
  Leader({
    required this.name,
    required this.profilePhoto,
    required this.xp,
  });

  factory Leader.fromJson(Map<String, dynamic> data) {
    return Leader(
      name: data["name"],
      profilePhoto: data["profilePhoto"],
      xp: data["xp"],
    );
  }

  @override
  final String name;
  @override
  final int xp;
  @override
  final String? profilePhoto;
}

import 'package:pika_master/domain/user/iapp_user.dart';

class AppUser implements IAppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhoto,
  });

  @override
  final String id;

  @override
  final String name;

  @override
  final String? email;

  @override
  final String? profilePhoto;
}

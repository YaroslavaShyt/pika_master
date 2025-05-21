import 'package:pika_master/domain/user/iapp_user.dart';

abstract interface class IUserRepository {
  Future<void> createUser({required IAppUser user});

  Future<IAppUser?> getUser({required String email});

  Future<void> updateUser({required IAppUser newUser});

  Future<void> deleteUser({required String id});
}

import 'package:pika_master/domain/user/iapp_user.dart';

abstract interface class IUserRepository {
  Future<IAppUser?> getUser({required String id});

  Future<void> deleteUser({required String id});
}

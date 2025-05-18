import 'package:pika_master/domain/user/iapp_user.dart';

abstract interface class IAuthRepository {
  Future<IAppUser?> loginGoogle();

  Future<bool> logout();
}

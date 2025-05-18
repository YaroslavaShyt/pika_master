import 'package:pika_master/domain/user/iapp_user.dart';

enum AuthState { authorized, notAuthorized }

abstract interface class IAuthService {
  IAppUser? get appUser;

  Stream<AuthState> authStateStream();

  Future<void> loginWithGoogle();

  Future<void> logout();
}

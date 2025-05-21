import 'package:pika_master/domain/user/iapp_user.dart';

enum UserState { initialized, notInitialized }

abstract interface class IUserService {
  void init();

  IAppUser? get appUser;

  Stream<UserState> userStateStream();

  Future<void> updateUser({
    int? xp,
    int? streak,
  });
}

enum UserState { initialized, notInitialized }

abstract interface class IUserService {
  void init();

  Stream<UserState> userStateStream();
}

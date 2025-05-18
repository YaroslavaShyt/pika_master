enum UserState { initialized, notInitialized }

abstract interface class IUserService {
  Stream<UserState> userStateStream();
}

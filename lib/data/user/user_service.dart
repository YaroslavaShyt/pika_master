import 'dart:async';

import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/user/iapp_user.dart';
import 'package:pika_master/domain/user/iuser_service.dart';

class UserService implements IUserService {
  UserService({
    required IAuthService authService,
  }) : _authService = authService;

  final IAuthService _authService;

  IAppUser? _appUser;

  final StreamController<UserState> _userStateStreamController =
      StreamController.broadcast();

  @override
  void init() {
    userStateStream();
    _authService.checkAuth();
  }

  @override
  Stream<UserState> userStateStream() {
    _authService.authStateStream().listen(
      (AuthState authState) {
        return switch (authState) {
          AuthState.authorized => _onUserAuthorized(),
          AuthState.notAuthorized =>
            _userStateStreamController.add(UserState.notInitialized),
        };
      },
    );
    return _userStateStreamController.stream;
  }

  Future<void> _onUserAuthorized() async {
    try {
      _appUser = _authService.appUser;
      if (_appUser == null) return;

      _userStateStreamController.add(UserState.initialized);
    } catch (error) {
      logger.e(error);
    }
  }
}

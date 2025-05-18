import 'dart:async';

import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/auth/iauth_repository.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/user/iapp_user.dart';

class AuthService implements IAuthService {
  AuthService({
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository;

  final IAuthRepository _authRepository;

  final StreamController<AuthState> _authStateStreamController =
      StreamController();

  @override
  Stream<AuthState> authStateStream() => _authStateStreamController.stream;

  @override
  IAppUser? get appUser => _appUser;
  IAppUser? _appUser;

  @override
  Future<void> loginWithGoogle() async {
    try {
      _appUser = await _authRepository.loginGoogle();
      if (_appUser == null) return;

      _authStateStreamController.add(AuthState.authorized);
    } catch (error) {
      logger.e(error);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final bool isLoggedOut = await _authRepository.logout();

      if (isLoggedOut) {
        _authStateStreamController.add(AuthState.notAuthorized);
      }
    } catch (error) {
      logger.e(error);
    }
  }
}

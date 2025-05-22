import 'dart:async';

import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/user/iapp_user.dart';
import 'package:pika_master/domain/user/iuser_repository.dart';
import 'package:pika_master/domain/user/iuser_service.dart';

class UserService implements IUserService {
  UserService({
    required IAuthService authService,
    required IUserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  final IAuthService _authService;
  final IUserRepository _userRepository;

  IAppUser? _appUser;

  final StreamController<UserState> _userStateStreamController =
      StreamController.broadcast();

  @override
  void init() {
    userStateStream();
    _authService.checkAuth();
  }

  @override
  IAppUser? get appUser => _appUser;

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
      final String? userEmail = _authService.appUser?.email;

      if (userEmail == null) {
        _userStateStreamController.add(UserState.notInitialized);
        return;
      }

      _appUser = await _userRepository.getUser(email: userEmail);

      if (_appUser == null) {
        _authService.logout();
        _userStateStreamController.add(UserState.notInitialized);
        return;
      }

      _userStateStreamController.add(UserState.initialized);
      final DateTime lastActiveAt = _appUser?.lastActiveAt ?? DateTime.now();

      final bool isLostStreak = _isLostStreak(lastActiveAt);
      if (isLostStreak) updateUser();
    } catch (error) {
      logger.e(error);
      if (_appUser == null) {
        _authService.logout();
        _userStateStreamController.add(UserState.notInitialized);
        return;
      }
    }
  }

  @override
  Future<void> updateUser({int? xp}) async {
    try {
      if (_appUser == null) return;

      int userStreak = _appUser!.streak ?? 0;
      final DateTime? lastActiveAt = _appUser!.lastActiveAt;
      final DateTime now = DateTime.now();

      bool isLostStreak = false;

      if (lastActiveAt != null) {
        final int diffDays = now.difference(lastActiveAt).inDays;
        isLostStreak = diffDays > 1;

        if (diffDays == 1) {
          userStreak++;
        } else if (isLostStreak) {
          userStreak = 1;
        }
      } else {
        userStreak = 1;
      }

      final IAppUser updatedUser = _appUser!.copyWith(
        xp: xp,
        streak: userStreak,
        lastActiveAt: now,
      );

      _appUser = updatedUser;

      await _userRepository.updateUser(newUser: updatedUser);
    } catch (error) {
      logger.e(error);
    }
  }

  bool _isLostStreak(DateTime? lastActiveAt) {
    if (lastActiveAt == null) return false;
    final now = DateTime.now();
    final differenceInDays = now.difference(lastActiveAt).inDays;
    return differenceInDays > 1;
  }
}

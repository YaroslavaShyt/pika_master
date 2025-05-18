import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pika_master/data/auth/auth_repository.dart';
import 'package:pika_master/data/auth/auth_service.dart';
import 'package:pika_master/data/user/user_service.dart';
import 'package:pika_master/domain/auth/iauth_repository.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/user/iuser_service.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    _initRepos();
    _initStorage();
    _initServices();
    _initHandlers();
  }

  void _initRepos() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    sl.registerSingleton<IAuthRepository>(
      AuthRepository(firebaseAuth: firebaseAuth),
    );
  }

  void _initServices() {
    final IAuthService authService =
        AuthService(authRepository: sl.get<IAuthRepository>());

    sl.registerSingleton<IAuthService>(authService);

    sl.registerSingleton<IUserService>(
      UserService(authService: authService),
    );
  }

  void _initHandlers() {}

  void _initStorage() {}
}

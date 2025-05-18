import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pika_master/core/constants/config_constants.dart';
import 'package:pika_master/core/routing/navigation_util.dart';
import 'package:pika_master/data/auth/auth_repository.dart';
import 'package:pika_master/data/auth/auth_service.dart';
import 'package:pika_master/data/networking/dio/dio_configuration.dart';
import 'package:pika_master/data/networking/dio/dio_network_client.dart';
import 'package:pika_master/data/pokemon/pokemon_repository.dart';
import 'package:pika_master/data/user/user_service.dart';
import 'package:pika_master/data/utils/random_generator_util.dart';
import 'package:pika_master/domain/auth/iauth_repository.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/pokemon/ipokemon_repository.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/domain/utils/irandom_generator_util.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    _initNavigation();
    _initRepos();
    _initStorage();
    _initServices();
    _initHandlers();
  }

  void _initNavigation() {
    sl.registerSingleton<INavigationUtil>(NavigationUtil());
  }

  void _initRepos() {
    final INetworkClient networkClient = DioNetworkClient()
      ..init(appConfig: DioConfiguration());

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    sl.registerSingleton<IAuthRepository>(
      AuthRepository(firebaseAuth: firebaseAuth),
    );

    sl.registerFactory<IPokemonRepository>(
      () => PokemonRepository(networkClient: networkClient),
    );
  }

  void _initServices() {
    final IAuthService authService =
        AuthService(authRepository: sl.get<IAuthRepository>());

    sl.registerSingleton<IAuthService>(authService);

    sl.registerSingleton<IUserService>(UserService(authService: authService));
  }

  void _initHandlers() {
    sl.registerFactory<IRandomGeneratorUtil>(
      () => RandomGeneratorUtil(
        min: ConfigConstants.minPokemonId,
        max: ConfigConstants.maxPokemonId,
      ),
    );
  }

  void _initStorage() {}
}

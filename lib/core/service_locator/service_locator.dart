import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pika_master/core/constants/config_constants.dart';
import 'package:pika_master/data/auth/auth_repository.dart';
import 'package:pika_master/data/auth/auth_service.dart';
import 'package:pika_master/data/game/game_service.dart';
import 'package:pika_master/data/leader/leader_repository.dart';
import 'package:pika_master/data/networking/dio/dio_configuration.dart';
import 'package:pika_master/data/networking/dio/dio_network_client.dart';
import 'package:pika_master/data/networking/firestore/firestore_network_client.dart';
import 'package:pika_master/data/pokemon/pokemon_repository.dart';
import 'package:pika_master/data/statistics/statistics_service.dart';
import 'package:pika_master/data/user/user_repository.dart';
import 'package:pika_master/data/user/user_service.dart';
import 'package:pika_master/data/utils/navigation_util.dart';
import 'package:pika_master/data/utils/parse_data_util.dart';
import 'package:pika_master/data/utils/random_generator_util.dart';
import 'package:pika_master/domain/auth/iauth_repository.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/game/igame_service.dart';
import 'package:pika_master/domain/leader/ileader_repository.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/pokemon/ipokemon_repository.dart';
import 'package:pika_master/domain/statistics/istatistics_service.dart';
import 'package:pika_master/domain/user/iuser_repository.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/domain/utils/ibackground_parser_util.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/domain/utils/irandom_generator_util.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    _initNavigation();
    _initUtils();
    _initRepos();
    _initStorage();
    _initServices();
  }

  void _initNavigation() {
    sl.registerSingleton<INavigationUtil>(NavigationUtil());
  }

  void _initRepos() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final INetworkClient fireStoreNetworkClient = FireStoreNetworkClient(
      fireStore: firebaseFirestore,
    );

    final INetworkClient baseNetworkClient =
        DioNetworkClient(appConfig: DioConfiguration());

    final IParseDataUtil parseDataUtil = ParseDataUtil();

    sl.registerFactory<IUserRepository>(
      () => UserRepository(
        networkClient: fireStoreNetworkClient,
      ),
    );

    sl.registerSingleton<IAuthRepository>(
      AuthRepository(firebaseAuth: firebaseAuth),
    );

    sl.registerFactory<IPokemonRepository>(
      () => PokemonRepository(
        networkClient: baseNetworkClient,
        parseDataUtil: parseDataUtil,
      ),
    );

    sl.registerFactory<ILeaderRepository>(
      () => LeaderRepository(
        networkClient: fireStoreNetworkClient,
      ),
    );
  }

  void _initServices() {
    final IUserRepository userRepository = sl.get<IUserRepository>();

    final IAuthService authService = AuthService(
      authRepository: sl.get<IAuthRepository>(),
      userRepository: userRepository,
    );

    sl.registerSingleton<IAuthService>(authService);

    sl.registerSingleton<IUserService>(
      UserService(
        authService: authService,
        userRepository: userRepository,
      ),
    );

    sl.registerFactory<IGameService>(
      () => GameService(
        randomGeneratorUtil: sl.get<IRandomGeneratorUtil>(),
        pokemonRepository: sl.get<IPokemonRepository>(),
      ),
    );

    sl.registerSingleton<IStatisticsService>(
      StatisticsService(
        leaderRepository: sl.get<ILeaderRepository>(),
      ),
    );
  }

  void _initUtils() {
    sl.registerFactory<IRandomGeneratorUtil>(
      () => RandomGeneratorUtil(
        min: ConfigConstants.minPokemonId,
        max: ConfigConstants.maxPokemonId,
      ),
    );
  }

  void _initStorage() {}
}

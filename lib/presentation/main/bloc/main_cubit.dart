import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/core/routing/routes.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/leader/ileader.dart';
import 'package:pika_master/domain/statistics/istatistics_service.dart';
import 'package:pika_master/domain/user/iapp_user.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/presentation/game/game_factory.dart';
import 'package:pika_master/presentation/main/bloc/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({
    required IAuthService authService,
    required INavigationUtil navigationUtil,
    required IUserService userService,
    required IStatisticsService statisticsService,
  })  : _authService = authService,
        _navigationUtil = navigationUtil,
        _userService = userService,
        _statisticsService = statisticsService,
        super(const MainState());

  final IAuthService _authService;
  final INavigationUtil _navigationUtil;
  final IUserService _userService;
  final IStatisticsService _statisticsService;

  Future<void> init() async {
    try {
      final IAppUser? user = _userService.appUser;
      final MainStatus status =
          user != null ? MainStatus.success : MainStatus.failure;

      final List<ILeader> leaders = await _statisticsService.getLeaders();

      emit(
        state.copyWith(
          status: status,
          userName: user?.name,
          userAvatar: user?.profilePhoto,
          userStreak: user?.streak,
          xp: user?.xp,
          leaders: leaders
              .map(
                (leader) => {
                  "name": leader.name,
                  "profilePhoto": leader.profilePhoto,
                  "xp": leader.xp,
                },
              )
              .toList()
            ..sort(
              (a, b) => (b['xp'] as int).compareTo(a['xp'] as int),
            ),
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: MainStatus.failure));
    }
  }

  void onLogoutTapped() {
    _authService.logout();
  }

  void onStartRoundButtonTapped() {
    _navigationUtil.navigateTo(
      Routes.routeGame,
      data: GameRoutingArgs(onGameFinished: init),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/routing/routes.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/presentation/main/bloc/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({
    required IAuthService authService,
    required INavigationUtil navigationUtil,
  })  : _authService = authService,
        _navigationUtil = navigationUtil,
        super(const MainState());

  final IAuthService _authService;
  final INavigationUtil _navigationUtil;

  void logout() {
    _authService.logout();
  }

  void onStartRoundButtonTapped() {
    _navigationUtil.navigateTo(Routes.routeGame);
  }
}

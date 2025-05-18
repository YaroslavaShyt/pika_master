import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/presentation/main/bloc/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({
    required IAuthService authService,
  })  : _authService = authService,
        super(const MainState());

  final IAuthService _authService;

  void logout() {
    _authService.logout();
  }
}

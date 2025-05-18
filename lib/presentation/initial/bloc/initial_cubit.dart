import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/presentation/initial/bloc/initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit({
    required IUserService userService,
  })  : _userService = userService,
        super(const InitialState());

  final IUserService _userService;

  void init() {
    _userService.userStateStream().listen(
      (UserState userState) {
        return switch (userState) {
          UserState.initialized =>
            emit(state.copyWith(status: InitialStatus.main)),
          UserState.notInitialized =>
            emit(state.copyWith(status: InitialStatus.auth)),
        };
      },
    );
  }
}

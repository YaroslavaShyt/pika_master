import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/presentation/auth/bloc/auth_state.dart'
    as cubit_state;

class AuthCubit extends Cubit<cubit_state.AuthState> {
  AuthCubit({
    required IAuthService authService,
  })  : _authService = authService,
        super(const cubit_state.AuthState());

  final IAuthService _authService;

  Future<void> onAuthButtonTapped() async {
    try {
      emit(
        state.copyWith(
          status: cubit_state.AuthStatus.loading,
        ),
      );

      await _authService.loginWithGoogle();

      emit(
        state.copyWith(
          status: cubit_state.AuthStatus.success,
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: cubit_state.AuthStatus.failure,
        ),
      );
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/presentation/auth/auth_screen.dart';
import 'package:pika_master/presentation/auth/bloc/auth_cubit.dart';

class AuthFactory {
  static Widget build() {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(
        authService: sl.get<IAuthService>(),
      ),
      child: Builder(
        builder: (context) {
          return AuthScreen(
            cubit: BlocProvider.of<AuthCubit>(context),
          );
        },
      ),
    );
  }
}

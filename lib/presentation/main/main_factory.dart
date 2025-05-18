import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/domain/auth/iauth_service.dart';
import 'package:pika_master/presentation/main/bloc/main_cubit.dart';
import 'package:pika_master/presentation/main/main_screen.dart';

class MainFactory {
  static Widget build() {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(
        authService: sl.get<IAuthService>(),
      ),
      child: Builder(
        builder: (context) {
          return MainScreen(
            cubit: BlocProvider.of<MainCubit>(context),
          );
        },
      ),
    );
  }
}

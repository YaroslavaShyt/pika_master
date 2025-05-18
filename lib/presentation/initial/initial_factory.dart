import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/domain/user/iuser_service.dart';
import 'package:pika_master/presentation/initial/bloc/initial_cubit.dart';
import 'package:pika_master/presentation/initial/initial_screen.dart';

class InitialFactory {
  static Widget build() {
    return BlocProvider<InitialCubit>(
      create: (_) => InitialCubit(
        userService: sl.get<IUserService>(),
      ),
      child: Builder(
        builder: (context) {
          return InitialScreen(
            cubit: BlocProvider.of<InitialCubit>(context),
          );
        },
      ),
    );
  }
}

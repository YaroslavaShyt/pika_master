import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/presentation/auth/auth_factory.dart';
import 'package:pika_master/presentation/initial/bloc/initial_cubit.dart';
import 'package:pika_master/presentation/initial/bloc/initial_state.dart';
import 'package:pika_master/presentation/loader/loader_factory.dart';
import 'package:pika_master/presentation/main/main_factory.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    required this.cubit,
    super.key,
  });

  final InitialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialCubit, InitialState>(
      builder: (_, InitialState state) {
        return switch (state.status) {
          InitialStatus.auth => AuthFactory.build(),
          InitialStatus.main => MainFactory.build(),
          InitialStatus.loading => LoaderFactory.build(),
        };
      },
    );
  }
}

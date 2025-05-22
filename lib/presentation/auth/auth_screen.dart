import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pika_master/presentation/auth/bloc/auth_cubit.dart';
import 'package:pika_master/presentation/auth/bloc/auth_state.dart';
import 'package:pika_master/presentation/auth/widgets/auth_button.dart';
import 'package:pika_master/presentation/auth/widgets/pikachu_animation_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    required this.cubit,
    super.key,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  const PikachuAnimationWidget(),
                  Text(
                    context.tr('whoThatPokemon'),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (_, state) {
                final bool isLoading = state.status == AuthStatus.loading;

                return Flexible(
                  flex: 2,
                  child: AuthButton(
                    isLoading: isLoading,
                    onTap: cubit.onAuthButtonTapped,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pika_master/presentation/auth/bloc/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    required this.cubit,
    super.key,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: cubit.onAuthButtonTapped,
            child: Text("Authorization"),
          ),
        ],
      ),
    );
  }
}

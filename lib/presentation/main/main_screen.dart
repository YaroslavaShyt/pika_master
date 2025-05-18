import 'package:flutter/material.dart';
import 'package:pika_master/presentation/main/bloc/main_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.cubit,
    super.key,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: cubit.logout,
          child: Text("Logout"),
        ),
      ),
    );
  }
}

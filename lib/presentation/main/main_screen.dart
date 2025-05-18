import 'package:flutter/material.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';
import 'package:pika_master/presentation/main/bloc/main_cubit.dart';
import 'package:pika_master/presentation/widgets/buttons/main_outlined_button.dart';

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
        child: MainOutlinedButton(
          onPressed: cubit.onStartRoundButtonTapped,
          child: Text(
            "Start round",
            style: TextStyle(
              color: getColorScheme(context).onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

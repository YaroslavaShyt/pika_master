import 'package:flutter/material.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';
import 'package:pika_master/presentation/initial/initial_factory.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppColorTheme.theme(context),
      home: InitialFactory.build(),
    );
  }
}

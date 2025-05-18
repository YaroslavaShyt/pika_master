import 'package:flutter/material.dart';
import 'package:pika_master/core/theme/app_color_theme.dart';
import 'package:pika_master/presentation/initial/initial_factory.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: AppColorTheme.theme(context),
      home: InitialFactory.build(),
    );
  }
}

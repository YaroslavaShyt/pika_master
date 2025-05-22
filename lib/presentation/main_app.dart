import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pika_master/core/routing/routing.dart';
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: Routing.generateRoute,
      theme: AppColorTheme.theme(context),
      home: InitialFactory.build(),
    );
  }
}

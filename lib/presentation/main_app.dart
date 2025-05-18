import 'package:flutter/material.dart';
import 'package:pika_master/presentation/initial/initial_factory.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialFactory.build(),
    );
  }
}

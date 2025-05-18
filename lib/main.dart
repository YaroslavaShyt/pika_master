import 'package:flutter/material.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/presentation/main_app.dart';

Future<void> main() async {
  ServiceLocator().init();

  runApp(MainApp());
}

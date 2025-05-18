import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/firebase_options.dart';
import 'package:pika_master/presentation/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ServiceLocator().init();

  runApp(MainApp());
}

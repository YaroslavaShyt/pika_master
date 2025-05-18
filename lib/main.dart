import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_master/core/service_locator/service_locator.dart';
import 'package:pika_master/core/theme/color_palette.dart';
import 'package:pika_master/domain/utils/inavigation_util.dart';
import 'package:pika_master/firebase_options.dart';
import 'package:pika_master/presentation/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: ColorPalette.yellow1,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ServiceLocator().init();

  runApp(
    MainApp(
      navigatorKey: sl.get<INavigationUtil>().navigatorKey,
    ),
  );
}

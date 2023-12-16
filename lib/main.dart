import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jogging_app/constant/hive_db.dart';
import 'package:jogging_app/data/local/hiking.dart';
import 'package:jogging_app/data/local/observation.dart';
import 'package:jogging_app/ui/splash/splash_screen.dart';

void main() async {
  await initDB();
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..dismissOnTap = false;
}

Future initDB() async {
  await Hive.initFlutter("hikingAppDB");
  Hive
    ..registerAdapter(HikingAdapter())
    ..registerAdapter(ObservationAdapter());
  await Hive.openBox<Hiking>(HiveBoxName.hiking);
  await Hive.openBox<Observation>(HiveBoxName.observation);
}

import 'package:flutter/material.dart';
import 'config/config.dart';
import 'screens/get_started.dart';

void main() async {
  await startApp();
}

Future<void> startApp() async {
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  Config.manager.initConfig(env);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const GetStarted(),
    );
  }
}

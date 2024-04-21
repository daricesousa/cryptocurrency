import 'package:cryptocurrency/app/pages/home_page.dart';
import 'package:cryptocurrency/app/repositories/count_repository.dart';
import 'package:cryptocurrency/app/repositories/favorites_repository.dart';
import 'package:cryptocurrency/configs/app_settings.dart';
import 'package:cryptocurrency/configs/hive_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CountRepository()),
      ChangeNotifierProvider(create: (context) => AppSettings()),
      ChangeNotifierProvider(create: (context) => FavoritesRepository()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrency',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_news/application/home_page.dart';
import 'package:project_news/data/fav_news.dart';

void main() async {
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(FavoriteNewsAdapter());
  // Opening the box
  await Hive.openBox('favoriteBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        // ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: HomePage());
  }
}

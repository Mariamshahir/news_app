import 'package:flutter/material.dart';
import 'package:news_app/homescreen.dart';
import 'package:news_app/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (_) => Splash(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: Splash.routeName,
    );
  }
}

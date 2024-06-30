import 'package:flutter/material.dart';
import 'package:weather_app/src/config/app_color.dart';
import 'package:weather_app/src/config/app_config.dart';
import 'package:weather_app/src/ui/homepage/homepage.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        primarySwatch: primaryMaterialColor,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

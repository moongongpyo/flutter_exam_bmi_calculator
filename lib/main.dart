import 'package:bmi_calculator/screen/gps_map/gps_map.dart';
import 'package:bmi_calculator/screen/xylophone/xylophone.dart';
import 'package:flutter/material.dart';

import 'main/main_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bmi calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      //home: const MainPage(),
      home: const MainPage(),
    );
  }
}

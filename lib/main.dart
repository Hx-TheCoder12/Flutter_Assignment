// main.dart

import 'package:flutter/material.dart';

import 'services_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServicesScreen(),
    );
  }
}

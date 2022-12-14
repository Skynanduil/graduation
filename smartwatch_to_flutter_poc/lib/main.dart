import 'package:flutter/material.dart';

import 'screens/health_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartwatch Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HealthPage(),
    );
  }
}

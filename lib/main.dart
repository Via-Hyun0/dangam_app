import 'package:flutter/material.dart';
import 'package:farm_work_app/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Work App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: DashboardPage(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:farm_work_app/pages/dashboard_body.dart';
import 'package:farm_work_app/widgets/mobile_layout.dart';

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
      home: const MobileLayout(
        title: 'Dashboard',
        body: DashboardBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:farm_work_app/pages/dashboard_body.dart';
import 'package:farm_work_app/widgets/mobile_layout.dart';
import 'package:google_fonts/google_fonts.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5), // neutral, global blue
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFF7E57C2), // subtle accent
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MobileLayout(
        title: 'Farm Work',
        body: DashboardBody(),
      ),
    );
  }
}

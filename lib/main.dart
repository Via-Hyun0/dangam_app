import 'package:flutter/material.dart';
import 'package:dangam_app/pages/dashboard_body.dart';
import 'package:dangam_app/widgets/mobile_layout.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '단감',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFc75d31), // 단감 오렌지
          primary: const Color(0xFFc75d31), // 단감 오렌지
          secondary: const Color(0xFFa48e7b), // 보조 브라운
          surface: const Color(0xFFfdfdfd), // 중성 배경
          onPrimary: Colors.white, // 오렌지 위의 텍스트
          onSurface: const Color(0xFF503123), // 다크 액센트
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF503123), // 다크 액센트
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color(0xFFfdfdfd),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MobileLayout(
        title: '단감',
        body: DashboardBody(),
      ),
    );
  }
}

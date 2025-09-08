import 'package:flutter/material.dart';
import 'package:dangam_app/pages/dashboard_body.dart';
import 'package:dangam_app/widgets/mobile_layout.dart';
import 'package:dangam_app/theme/app_theme.dart';
import 'package:dangam_app/services/data_service.dart';

/// 단감 앱의 메인 진입점
///
/// 디자이너 가이드:
/// - 이 파일은 앱의 전체 테마를 설정합니다
/// - AppTheme.lightTheme을 사용하여 일관된 디자인을 적용합니다
/// - 다크 모드 지원을 위해 AppTheme.darkTheme도 사용할 수 있습니다
///
/// TODO::LUKA - Firebase 초기화 추가
/// - Firebase.initializeApp() 호출
/// - 에러 핸들링 추가
/// - 앱 시작 시 데이터 동기화
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 데이터 서비스 초기화
  DataService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '단감',

      // 라이트 테마 적용
      // 디자이너가 다크 모드를 테스트하고 싶다면 AppTheme.darkTheme으로 변경하세요
      theme: AppTheme.lightTheme,

      // 다크 테마 지원 (선택사항)
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system, // 시스템 설정에 따라 자동 전환

      home: const MobileLayout(
        title: '단감',
        body: DashboardBody(),
      ),
    );
  }
}

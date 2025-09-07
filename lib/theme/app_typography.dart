import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 앱의 모든 타이포그래피를 중앙에서 관리하는 클래스
/// 
/// 디자이너 가이드:
/// - 모든 폰트 스타일은 여기서 정의하고 관리합니다
/// - 폰트 크기, 굵기, 색상을 일관성 있게 관리할 수 있습니다
/// - 새로운 텍스트 스타일이 필요하면 이 클래스에 추가하세요
/// - 폰트 변경 시 이 파일만 수정하면 전체 앱에 반영됩니다
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // ============================================================================
  // 폰트 패밀리 (Font Family)
  // ============================================================================
  
  /// 메인 폰트 패밀리 - Inter
  /// 사용처: 모든 텍스트에 기본으로 사용
  /// 특징: 가독성이 좋고 모던한 느낌
  static const String _fontFamily = 'Inter';

  // ============================================================================
  // 폰트 크기 (Font Sizes)
  // ============================================================================
  
  /// 96px - 매우 큰 제목
  /// 사용처: 스플래시 화면, 메인 히어로 텍스트
  static const double _displayLarge = 96.0;
  
  /// 60px - 큰 제목
  /// 사용처: 페이지 메인 제목
  static const double _displayMedium = 60.0;
  
  /// 48px - 중간 제목
  /// 사용처: 섹션 제목
  static const double _displaySmall = 48.0;
  
  /// 34px - 헤드라인
  /// 사용처: 카드 제목, 중요한 텍스트
  static const double _headlineLarge = 34.0;
  
  /// 24px - 서브 헤드라인
  /// 사용처: 서브 제목, 섹션 헤더
  static const double _headlineMedium = 24.0;
  
  /// 20px - 작은 헤드라인
  /// 사용처: 작은 제목, 카테고리 헤더
  static const double _headlineSmall = 20.0;
  
  /// 16px - 제목
  /// 사용처: 일반 제목, 버튼 텍스트
  static const double _titleLarge = 16.0;
  
  /// 14px - 서브 제목
  /// 사용처: 서브 제목, 카드 헤더
  static const double _titleMedium = 14.0;
  
  /// 12px - 작은 제목
  /// 사용처: 작은 제목, 라벨
  static const double _titleSmall = 12.0;
  
  /// 16px - 본문
  /// 사용처: 일반 텍스트, 설명
  static const double _bodyLarge = 16.0;
  
  /// 14px - 서브 본문
  /// 사용처: 서브 텍스트, 설명
  static const double _bodyMedium = 14.0;
  
  /// 12px - 작은 본문
  /// 사용처: 작은 텍스트, 캡션
  static const double _bodySmall = 12.0;
  
  /// 14px - 라벨
  /// 사용처: 버튼, 탭, 라벨
  static const double _labelLarge = 14.0;
  
  /// 12px - 서브 라벨
  /// 사용처: 작은 버튼, 작은 라벨
  static const double _labelMedium = 12.0;
  
  /// 10px - 작은 라벨
  /// 사용처: 매우 작은 라벨, 배지
  static const double _labelSmall = 10.0;

  // ============================================================================
  // 폰트 굵기 (Font Weights)
  // ============================================================================
  
  /// 100 - 가장 얇음
  static const FontWeight _thin = FontWeight.w100;
  
  /// 200 - 매우 얇음
  static const FontWeight _extraLight = FontWeight.w200;
  
  /// 300 - 얇음
  static const FontWeight _light = FontWeight.w300;
  
  /// 400 - 일반 (기본)
  static const FontWeight _regular = FontWeight.w400;
  
  /// 500 - 중간
  static const FontWeight _medium = FontWeight.w500;
  
  /// 600 - 세미볼드
  static const FontWeight _semiBold = FontWeight.w600;
  
  /// 700 - 볼드
  static const FontWeight _bold = FontWeight.w700;
  
  /// 800 - 매우 볼드
  static const FontWeight _extraBold = FontWeight.w800;
  
  /// 900 - 가장 볼드
  static const FontWeight _black = FontWeight.w900;

  // ============================================================================
  // 디스플레이 스타일 (Display Styles)
  // ============================================================================
  
  /// 매우 큰 제목 스타일
  /// 사용처: 스플래시 화면, 메인 히어로 텍스트
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: _displayLarge,
    fontWeight: _light,
    letterSpacing: -1.5,
    height: 1.2,
  );
  
  /// 큰 제목 스타일
  /// 사용처: 페이지 메인 제목
  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: _displayMedium,
    fontWeight: _light,
    letterSpacing: -0.5,
    height: 1.2,
  );
  
  /// 중간 제목 스타일
  /// 사용처: 섹션 제목
  static TextStyle get displaySmall => GoogleFonts.inter(
    fontSize: _displaySmall,
    fontWeight: _regular,
    letterSpacing: 0,
    height: 1.2,
  );

  // ============================================================================
  // 헤드라인 스타일 (Headline Styles)
  // ============================================================================
  
  /// 큰 헤드라인 스타일
  /// 사용처: 카드 제목, 중요한 텍스트
  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: _headlineLarge,
    fontWeight: _semiBold,
    letterSpacing: 0,
    height: 1.3,
  );
  
  /// 중간 헤드라인 스타일
  /// 사용처: 서브 제목, 섹션 헤더
  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: _headlineMedium,
    fontWeight: _semiBold,
    letterSpacing: 0,
    height: 1.3,
  );
  
  /// 작은 헤드라인 스타일
  /// 사용처: 작은 제목, 카테고리 헤더
  static TextStyle get headlineSmall => GoogleFonts.inter(
    fontSize: _headlineSmall,
    fontWeight: _medium,
    letterSpacing: 0,
    height: 1.3,
  );

  // ============================================================================
  // 제목 스타일 (Title Styles)
  // ============================================================================
  
  /// 큰 제목 스타일
  /// 사용처: 일반 제목, 버튼 텍스트
  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: _titleLarge,
    fontWeight: _medium,
    letterSpacing: 0,
    height: 1.4,
  );
  
  /// 중간 제목 스타일
  /// 사용처: 서브 제목, 카드 헤더
  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: _titleMedium,
    fontWeight: _medium,
    letterSpacing: 0.15,
    height: 1.4,
  );
  
  /// 작은 제목 스타일
  /// 사용처: 작은 제목, 라벨
  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: _titleSmall,
    fontWeight: _medium,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // ============================================================================
  // 본문 스타일 (Body Styles)
  // ============================================================================
  
  /// 큰 본문 스타일
  /// 사용처: 일반 텍스트, 설명
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: _bodyLarge,
    fontWeight: _regular,
    letterSpacing: 0.15,
    height: 1.5,
  );
  
  /// 중간 본문 스타일
  /// 사용처: 서브 텍스트, 설명
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: _bodyMedium,
    fontWeight: _regular,
    letterSpacing: 0.25,
    height: 1.5,
  );
  
  /// 작은 본문 스타일
  /// 사용처: 작은 텍스트, 캡션
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: _bodySmall,
    fontWeight: _regular,
    letterSpacing: 0.4,
    height: 1.5,
  );

  // ============================================================================
  // 라벨 스타일 (Label Styles)
  // ============================================================================
  
  /// 큰 라벨 스타일
  /// 사용처: 버튼, 탭, 라벨
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: _labelLarge,
    fontWeight: _medium,
    letterSpacing: 0.1,
    height: 1.4,
  );
  
  /// 중간 라벨 스타일
  /// 사용처: 작은 버튼, 작은 라벨
  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: _labelMedium,
    fontWeight: _medium,
    letterSpacing: 0.5,
    height: 1.4,
  );
  
  /// 작은 라벨 스타일
  /// 사용처: 매우 작은 라벨, 배지
  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: _labelSmall,
    fontWeight: _medium,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ============================================================================
  // 특수 스타일 (Special Styles)
  // ============================================================================
  
  /// 버튼 텍스트 스타일
  /// 사용처: 모든 버튼의 텍스트
  static TextStyle get button => GoogleFonts.inter(
    fontSize: _labelLarge,
    fontWeight: _semiBold,
    letterSpacing: 0.1,
    height: 1.2,
  );
  
  /// 카드 제목 스타일
  /// 사용처: 카드의 제목 텍스트
  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: _titleLarge,
    fontWeight: _semiBold,
    letterSpacing: 0,
    height: 1.3,
  );
  
  /// 카드 서브타이틀 스타일
  /// 사용처: 카드의 서브타이틀 텍스트
  static TextStyle get cardSubtitle => GoogleFonts.inter(
    fontSize: _bodyMedium,
    fontWeight: _regular,
    letterSpacing: 0.25,
    height: 1.4,
  );
  
  /// 배지 텍스트 스타일
  /// 사용처: 상태 배지, 태그 텍스트
  static TextStyle get badge => GoogleFonts.inter(
    fontSize: _labelSmall,
    fontWeight: _semiBold,
    letterSpacing: 0.5,
    height: 1.2,
  );
  
  /// 캡션 스타일
  /// 사용처: 이미지 캡션, 작은 설명
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: _bodySmall,
    fontWeight: _regular,
    letterSpacing: 0.4,
    height: 1.4,
  );
  
  /// 오버라인 스타일
  /// 사용처: 오버라인 텍스트, 작은 라벨
  static TextStyle get overline => GoogleFonts.inter(
    fontSize: _labelSmall,
    fontWeight: _medium,
    letterSpacing: 1.5,
    height: 1.2,
  );
}

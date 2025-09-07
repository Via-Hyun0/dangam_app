import 'package:flutter/material.dart';

/// 앱의 모든 색상을 중앙에서 관리하는 클래스
/// 
/// 디자이너 가이드:
/// - 모든 색상은 여기서 정의하고 관리합니다
/// - 새로운 색상이 필요하면 이 클래스에 추가하세요
/// - 색상 변경 시 이 파일만 수정하면 전체 앱에 반영됩니다
/// - 브랜드 색상은 상단에, 유틸리티 색상은 하단에 배치했습니다
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============================================================================
  // 브랜드 색상 (Brand Colors)
  // ============================================================================
  
  /// 메인 브랜드 색상 - 단감 오렌지
  /// 사용처: 주요 버튼, 선택된 탭, 강조 요소
  /// Hex: #c75d31, RGB: (199, 93, 49)
  static const Color primary = Color(0xFFc75d31);
  
  /// 보조 브랜드 색상 - 브라운
  /// 사용처: 보조 버튼, 서브 텍스트, 구분선
  /// Hex: #a48e7b, RGB: (168, 142, 123)
  static const Color secondary = Color(0xFFa48e7b);
  
  /// 다크 액센트 색상
  /// 사용처: 제목 텍스트, 중요한 정보
  /// Hex: #503123, RGB: (80, 49, 35)
  static const Color darkAccent = Color(0xFF503123);

  // ============================================================================
  // 투명도가 적용된 브랜드 색상 (Brand Colors with Opacity)
  // ============================================================================
  
  /// Primary 색상의 5% 투명도 버전
  /// 사용처: 배경, 그라데이션의 연한 부분
  static const Color primaryLight = Color(0x0Dc75d31);
  
  /// Primary 색상의 10% 투명도 버전
  /// 사용처: 카드 배경, 버튼 호버 상태
  static const Color primaryLighter = Color(0x1Ac75d31);
  
  /// Primary 색상의 20% 투명도 버전
  /// 사용처: 테두리, 구분선
  static const Color primaryLightest = Color(0x33c75d31);
  
  /// Primary 색상의 30% 투명도 버전
  /// 사용처: 비활성 상태, 플레이스홀더
  static const Color primaryMuted = Color(0x4Dc75d31);
  
  /// Primary 색상의 60% 투명도 버전
  /// 사용처: 오버레이, 모달 배경
  static const Color primaryOverlay = Color(0x99c75d31);

  // ============================================================================
  // 상태 색상 (Status Colors)
  // ============================================================================
  
  /// 성공/완료 상태 색상
  /// 사용처: 성공 메시지, 완료된 작업, 체크마크
  /// Hex: #4CAF50, RGB: (76, 175, 80)
  static const Color success = Color(0xFF4CAF50);
  
  /// 경고/주의 상태 색상
  /// 사용처: 경고 메시지, 주의가 필요한 항목
  /// Hex: #FF9800, RGB: (255, 152, 0)
  static const Color warning = Color(0xFFFF9800);
  
  /// 에러/위험 상태 색상
  /// 사용처: 에러 메시지, 삭제 버튼, 위험한 작업
  /// Hex: #F44336, RGB: (244, 67, 54)
  static const Color error = Color(0xFFF44336);
  
  /// 정보/알림 상태 색상
  /// 사용처: 정보 메시지, 알림, 도움말
  /// Hex: #2196F3, RGB: (33, 150, 243)
  static const Color info = Color(0xFF2196F3);

  // ============================================================================
  // 상태 색상 투명도 버전 (Status Colors with Opacity)
  // ============================================================================
  
  /// Success 색상의 10% 투명도 버전
  static const Color successLight = Color(0x1A4CAF50);
  
  /// Success 색상의 30% 투명도 버전
  static const Color successMuted = Color(0x4D4CAF50);
  
  /// Warning 색상의 10% 투명도 버전
  static const Color warningLight = Color(0x1AFF9800);
  
  /// Warning 색상의 30% 투명도 버전
  static const Color warningMuted = Color(0x4DFF9800);
  
  /// Error 색상의 10% 투명도 버전
  static const Color errorLight = Color(0x1AF44336);
  
  /// Error 색상의 30% 투명도 버전
  static const Color errorMuted = Color(0x4DF44336);
  
  /// Info 색상의 10% 투명도 버전
  static const Color infoLight = Color(0x1A2196F3);
  
  /// Info 색상의 30% 투명도 버전
  static const Color infoMuted = Color(0x4D2196F3);

  // ============================================================================
  // 중성 색상 (Neutral Colors)
  // ============================================================================
  
  /// 순수한 흰색
  /// 사용처: 배경, 카드, 텍스트 (다크 배경 위)
  static const Color white = Color(0xFFFFFFFF);
  
  /// 거의 흰색 (98% 흰색)
  /// 사용처: 메인 배경, 카드 배경
  /// Hex: #fdfdfd, RGB: (253, 253, 253)
  static const Color background = Color(0xFFfdfdfd);
  
  /// 연한 회색 (95% 흰색)
  /// 사용처: 구분선, 테두리, 비활성 요소
  /// Hex: #cfcac9, RGB: (207, 202, 201)
  static const Color divider = Color(0xFFcfcac9);
  
  /// 중간 회색 (50% 흰색)
  /// 사용처: 플레이스홀더, 비활성 텍스트
  static const Color grey = Color(0xFF808080);
  
  /// 진한 회색 (25% 흰색)
  /// 사용처: 서브 텍스트, 보조 정보
  static const Color darkGrey = Color(0xFF404040);
  
  /// 순수한 검은색
  /// 사용처: 제목 텍스트, 중요한 정보
  static const Color black = Color(0xFF000000);

  // ============================================================================
  // 투명도가 적용된 중성 색상 (Neutral Colors with Opacity)
  // ============================================================================
  
  /// 검은색의 4% 투명도 버전
  /// 사용처: 그림자, 미묘한 구분선
  static const Color shadowLight = Color(0x0A000000);
  
  /// 검은색의 5% 투명도 버전
  /// 사용처: 카드 그림자, 호버 효과
  static const Color shadowMedium = Color(0x0D000000);
  
  /// 검은색의 6% 투명도 버전
  /// 사용처: 강한 그림자, 모달 오버레이
  static const Color shadowDark = Color(0x0F000000);
  
  /// 흰색의 80% 투명도 버전
  /// 사용처: 반투명 오버레이, 글래스모피즘 효과
  static const Color whiteOverlay = Color(0xCCFFFFFF);
  
  /// 흰색의 90% 투명도 버전
  /// 사용처: 연한 오버레이, 배경 블러
  static const Color whiteLight = Color(0xE6FFFFFF);

  // ============================================================================
  // 작업 상태별 색상 (Job Status Colors)
  // ============================================================================
  
  /// 작업 가능 상태 (Available)
  /// 사용처: 신규 작업, 지원 가능한 작업
  static const Color jobAvailable = success;
  
  /// 지원한 작업 상태 (Applied)
  /// 사용처: 내가 지원한 작업
  static const Color jobApplied = info;
  
  /// 관심 있는 작업 상태 (Interested)
  /// 사용처: 관심 목록에 추가한 작업
  static const Color jobInterested = warning;
  
  /// 완료된 작업 상태 (Completed)
  /// 사용처: 완료된 작업, 이력
  static const Color jobCompleted = grey;
  
  /// 취소된 작업 상태 (Cancelled)
  /// 사용처: 취소된 작업, 실패한 작업
  static const Color jobCancelled = error;

  // ============================================================================
  // 메시지 상태별 색상 (Message Status Colors)
  // ============================================================================
  
  /// 요청함 상태
  /// 사용처: 내가 보낸 요청
  static const Color messageRequested = info;
  
  /// 요청받음 상태
  /// 사용처: 받은 요청
  static const Color messageReceived = warning;
  
  /// 수락함 상태
  /// 사용처: 수락된 요청
  static const Color messageAccepted = success;
  
  /// 거절됨 상태
  /// 사용처: 거절된 요청
  static const Color messageRejected = error;
  
  /// 완료됨 상태
  /// 사용처: 완료된 대화
  static const Color messageCompleted = grey;
  
  /// 취소됨 상태
  /// 사용처: 취소된 대화
  static const Color messageCancelled = error;
  
  /// 대기중 상태
  /// 사용처: 응답 대기 중인 메시지
  static const Color messagePending = warning;

  // ============================================================================
  // 계약 상태별 색상 (Contract Status Colors)
  // ============================================================================
  
  /// 제안됨 상태
  /// 사용처: 새로 제안된 계약
  static const Color contractProposed = info;
  
  /// 수락됨 상태
  /// 사용처: 수락된 계약
  static const Color contractAccepted = success;
  
  /// 거절됨 상태
  /// 사용처: 거절된 계약
  static const Color contractRejected = error;
  
  /// 수정됨 상태
  /// 사용처: 수정된 계약
  static const Color contractModified = warning;
  
  /// 대기중 상태
  /// 사용처: 검토 대기 중인 계약
  static const Color contractPending = warning;
  
  /// 만료됨 상태
  /// 사용처: 만료된 계약
  static const Color contractExpired = grey;
}

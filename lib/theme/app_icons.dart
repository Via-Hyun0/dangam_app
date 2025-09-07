import 'package:flutter/material.dart';

/// 앱에서 사용하는 모든 아이콘을 중앙에서 관리하는 클래스
///
/// 디자이너 가이드:
/// - 이 클래스는 앱 전체에서 사용되는 아이콘들을 정의합니다
/// - 아이콘을 변경할 때는 이 파일만 수정하면 됩니다
/// - 각 아이콘은 용도별로 그룹화되어 있습니다
/// - 새로운 아이콘이 필요할 때는 적절한 그룹에 추가하세요
class AppIcons {
  // Private constructor to prevent instantiation
  AppIcons._();

  // ============================================================================
  // 프로필 관련 아이콘
  // ============================================================================

  /// 사용자 프로필 아이콘
  static const IconData user = Icons.person;

  /// 사용자 프로필 (아웃라인) 아이콘
  static const IconData userOutline = Icons.person_outline;

  /// 프로필 편집 아이콘
  static const IconData edit = Icons.edit;

  /// 인증된 사용자 아이콘
  static const IconData verified = Icons.verified;

  /// 인증된 사용자 (아웃라인) 아이콘
  static const IconData verifiedOutline = Icons.verified_user_outlined;

  /// 위치 아이콘
  static const IconData location = Icons.location_on;

  /// 위치 (아웃라인) 아이콘
  static const IconData locationOutline = Icons.location_on_outlined;

  // ============================================================================
  // 작업 관련 아이콘
  // ============================================================================

  /// 작업 아이콘
  static const IconData work = Icons.work;

  /// 작업 (아웃라인) 아이콘
  static const IconData workOutline = Icons.work_outline;

  /// 스케줄 아이콘
  static const IconData schedule = Icons.schedule;

  /// 스케줄 (아웃라인) 아이콘
  static const IconData scheduleOutline = Icons.schedule_outlined;

  /// 별점 아이콘
  static const IconData star = Icons.star;

  /// 별점 (아웃라인) 아이콘
  static const IconData starOutline = Icons.star_outline;

  // ============================================================================
  // 메시지/채팅 관련 아이콘
  // ============================================================================

  /// 채팅 버블 아이콘
  static const IconData chat = Icons.chat_bubble;

  /// 채팅 버블 (아웃라인) 아이콘
  static const IconData chatOutline = Icons.chat_bubble_outline;

  /// 메시지 아이콘
  static const IconData message = Icons.message;

  /// 메시지 (아웃라인) 아이콘
  static const IconData messageOutline = Icons.message_outlined;

  // ============================================================================
  // 지원/도움말 관련 아이콘
  // ============================================================================

  /// 도움말 아이콘
  static const IconData help = Icons.help;

  /// 도움말 (아웃라인) 아이콘
  static const IconData helpOutline = Icons.help_outline;

  /// 고객 지원 아이콘
  static const IconData support = Icons.support_agent;

  /// 문의하기 아이콘
  static const IconData contactSupport = Icons.contact_support_outlined;

  /// 정보 아이콘
  static const IconData info = Icons.info;

  /// 정보 (아웃라인) 아이콘
  static const IconData infoOutline = Icons.info_outline;

  // ============================================================================
  // 네비게이션 관련 아이콘
  // ============================================================================

  /// 오른쪽 화살표 아이콘
  static const IconData chevronRight = Icons.chevron_right;

  /// 왼쪽 화살표 아이콘
  static const IconData chevronLeft = Icons.chevron_left;

  /// 위쪽 화살표 아이콘
  static const IconData chevronUp = Icons.keyboard_arrow_up;

  /// 아래쪽 화살표 아이콘
  static const IconData chevronDown = Icons.keyboard_arrow_down;

  // ============================================================================
  // 액션 관련 아이콘
  // ============================================================================

  /// 검색 아이콘
  static const IconData search = Icons.search;

  /// 닫기 아이콘
  static const IconData close = Icons.close;

  /// 지우기 아이콘
  static const IconData clear = Icons.clear;

  /// 설정 아이콘
  static const IconData settings = Icons.settings;

  /// 설정 (아웃라인) 아이콘
  static const IconData settingsOutline = Icons.settings_outlined;

  // ============================================================================
  // 상태 관련 아이콘
  // ============================================================================

  /// 체크 아이콘
  static const IconData check = Icons.check;

  /// 체크 (원형) 아이콘
  static const IconData checkCircle = Icons.check_circle;

  /// 경고 아이콘
  static const IconData warning = Icons.warning;

  /// 경고 (아웃라인) 아이콘
  static const IconData warningOutline = Icons.warning_outlined;

  /// 오류 아이콘
  static const IconData error = Icons.error;

  /// 오류 (아웃라인) 아이콘
  static const IconData errorOutline = Icons.error_outline;

  // ============================================================================
  // 파일/문서 관련 아이콘
  // ============================================================================

  /// 문서 아이콘
  static const IconData document = Icons.description;

  /// 문서 (아웃라인) 아이콘
  static const IconData documentOutline = Icons.description_outlined;

  /// 개인정보처리방침 아이콘
  static const IconData privacy = Icons.privacy_tip;

  /// 개인정보처리방침 (아웃라인) 아이콘
  static const IconData privacyOutline = Icons.privacy_tip_outlined;

  /// 저작권 아이콘
  static const IconData copyright = Icons.copyright;

  /// 저작권 (아웃라인) 아이콘
  static const IconData copyrightOutline = Icons.copyright_outlined;

  /// 보안 아이콘
  static const IconData security = Icons.security;

  /// 보안 (아웃라인) 아이콘
  static const IconData securityOutline = Icons.security_outlined;

  // ============================================================================
  // 통신 관련 아이콘
  // ============================================================================

  /// 이메일 아이콘
  static const IconData email = Icons.email;

  /// 이메일 (아웃라인) 아이콘
  static const IconData emailOutline = Icons.email_outlined;

  /// 전화 아이콘
  static const IconData phone = Icons.phone;

  /// 전화 (아웃라인) 아이콘
  static const IconData phoneOutline = Icons.phone_outlined;

  /// 웹사이트 아이콘
  static const IconData language = Icons.language;

  /// 캘린더 아이콘
  static const IconData calendar = Icons.calendar_today;

  /// 캘린더 (아웃라인) 아이콘
  static const IconData calendarOutline = Icons.calendar_today_outlined;

  // ============================================================================
  // 농업 관련 아이콘
  // ============================================================================

  /// 농업 아이콘
  static const IconData agriculture = Icons.agriculture;

  /// 농업 (아웃라인) 아이콘
  static const IconData agricultureOutline = Icons.agriculture_outlined;

  /// 식물 아이콘
  static const IconData local_florist = Icons.local_florist;

  /// 자연 아이콘
  static const IconData nature = Icons.nature;

  /// 자연 (아웃라인) 아이콘
  static const IconData natureOutline = Icons.nature_outlined;

  // ============================================================================
  // 유틸리티 아이콘
  // ============================================================================

  /// 홈 아이콘
  static const IconData home = Icons.home;

  /// 홈 (아웃라인) 아이콘
  static const IconData homeOutline = Icons.home_outlined;

  /// 메뉴 아이콘
  static const IconData menu = Icons.menu;

  /// 더보기 아이콘
  static const IconData more = Icons.more_horiz;

  /// 더보기 (세로) 아이콘
  static const IconData moreVertical = Icons.more_vert;
}

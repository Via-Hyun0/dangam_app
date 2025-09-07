/// 앱의 모든 간격과 크기를 중앙에서 관리하는 클래스
/// 
/// 디자이너 가이드:
/// - 모든 간격, 패딩, 마진, 크기는 여기서 정의하고 관리합니다
/// - 8px 그리드 시스템을 기반으로 일관성 있는 간격을 제공합니다
/// - 새로운 간격이 필요하면 이 클래스에 추가하세요
/// - 간격 변경 시 이 파일만 수정하면 전체 앱에 반영됩니다
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // ============================================================================
  // 기본 간격 단위 (Base Spacing Unit)
  // ============================================================================
  
  /// 기본 간격 단위 - 8px
  /// 모든 간격은 이 단위의 배수로 정의됩니다
  static const double _baseUnit = 8.0;

  // ============================================================================
  // 마이크로 간격 (Micro Spacing) - 0-8px
  // ============================================================================
  
  /// 0px - 간격 없음
  static const double none = 0.0;
  
  /// 2px - 매우 작은 간격
  /// 사용처: 아이콘과 텍스트 사이, 작은 요소들 사이
  static const double xs = 2.0;
  
  /// 4px - 작은 간격
  /// 사용처: 작은 요소들 사이, 세밀한 조정
  static const double sm = 4.0;
  
  /// 8px - 기본 간격
  /// 사용처: 일반적인 요소들 사이, 기본 패딩
  static const double md = 8.0;

  // ============================================================================
  // 소간격 (Small Spacing) - 8-24px
  // ============================================================================
  
  /// 12px - 작은-중간 간격
  /// 사용처: 카드 내부 요소들 사이
  static const double smMd = 12.0;
  
  /// 16px - 중간 간격
  /// 사용처: 섹션 내부 요소들 사이, 기본 패딩
  static const double lg = 16.0;
  
  /// 20px - 중간-큰 간격
  /// 사용처: 카드와 카드 사이, 섹션 간격
  static const double lgXl = 20.0;
  
  /// 24px - 큰 간격
  /// 사용처: 섹션 간격, 카드 패딩
  static const double xl = 24.0;

  // ============================================================================
  // 중간격 (Medium Spacing) - 24-48px
  // ============================================================================
  
  /// 32px - 큰-매우 큰 간격
  /// 사용처: 주요 섹션 간격, 큰 카드 패딩
  static const double xxl = 32.0;
  
  /// 40px - 매우 큰 간격
  /// 사용처: 페이지 섹션 간격, 큰 여백
  static const double xxxl = 40.0;
  
  /// 48px - 매우 큰 간격
  /// 사용처: 페이지 섹션 간격, 큰 여백
  static const double huge = 48.0;

  // ============================================================================
  // 대간격 (Large Spacing) - 48px+
  // ============================================================================
  
  /// 56px - 거대한 간격
  /// 사용처: 페이지 간격, 큰 섹션 간격
  static const double massive = 56.0;
  
  /// 64px - 거대한 간격
  /// 사용처: 페이지 간격, 큰 섹션 간격
  static const double enormous = 64.0;
  
  /// 80px - 매우 거대한 간격
  /// 사용처: 페이지 간격, 큰 섹션 간격
  static const double gigantic = 80.0;

  // ============================================================================
  // 컴포넌트별 간격 (Component Spacing)
  // ============================================================================
  
  /// 앱바 높이
  static const double appBarHeight = 56.0;
  
  /// 하단 네비게이션 높이
  static const double bottomNavHeight = 60.0;
  
  /// 카드 패딩 (내부)
  static const double cardPadding = lg;
  
  /// 카드 마진 (외부)
  static const double cardMargin = md;
  
  /// 버튼 패딩 (세로)
  static const double buttonPaddingVertical = sm;
  
  /// 버튼 패딩 (가로)
  static const double buttonPaddingHorizontal = lg;
  
  /// 입력 필드 패딩
  static const double inputPadding = md;
  
  /// 리스트 아이템 패딩
  static const double listItemPadding = lg;
  
  /// 섹션 패딩 (페이지 내부)
  static const double sectionPadding = xl;
  
  /// 페이지 패딩 (전체 페이지)
  static const double pagePadding = lg;

  // ============================================================================
  // 테두리 반지름 (Border Radius)
  // ============================================================================
  
  /// 4px - 작은 모서리
  /// 사용처: 작은 버튼, 작은 카드
  static const double radiusSmall = 4.0;
  
  /// 8px - 기본 모서리
  /// 사용처: 일반적인 카드, 버튼
  static const double radiusMedium = 8.0;
  
  /// 12px - 중간 모서리
  /// 사용처: 큰 카드, 중요한 요소
  static const double radiusLarge = 12.0;
  
  /// 16px - 큰 모서리
  /// 사용처: 매우 큰 카드, 특별한 요소
  static const double radiusXLarge = 16.0;
  
  /// 20px - 매우 큰 모서리
  /// 사용처: 모달, 특별한 카드
  static const double radiusXXLarge = 20.0;
  
  /// 24px - 거대한 모서리
  /// 사용처: 매우 특별한 요소
  static const double radiusHuge = 24.0;
  
  /// 원형 (50%)
  /// 사용처: 아바타, 원형 버튼
  static const double radiusCircular = 50.0;

  // ============================================================================
  // 그림자 (Shadows)
  // ============================================================================
  
  /// 작은 그림자 오프셋
  static const double shadowSmallOffset = 2.0;
  
  /// 중간 그림자 오프셋
  static const double shadowMediumOffset = 4.0;
  
  /// 큰 그림자 오프셋
  static const double shadowLargeOffset = 8.0;
  
  /// 작은 그림자 블러
  static const double shadowSmallBlur = 4.0;
  
  /// 중간 그림자 블러
  static const double shadowMediumBlur = 8.0;
  
  /// 큰 그림자 블러
  static const double shadowLargeBlur = 16.0;

  // ============================================================================
  // 아이콘 크기 (Icon Sizes)
  // ============================================================================
  
  /// 16px - 작은 아이콘
  /// 사용처: 작은 버튼, 작은 요소
  static const double iconSmall = 16.0;
  
  /// 20px - 기본 아이콘
  /// 사용처: 일반적인 아이콘
  static const double iconMedium = 20.0;
  
  /// 24px - 큰 아이콘
  /// 사용처: 중요한 아이콘, 버튼
  static const double iconLarge = 24.0;
  
  /// 32px - 매우 큰 아이콘
  /// 사용처: 큰 버튼, 중요한 요소
  static const double iconXLarge = 32.0;
  
  /// 48px - 거대한 아이콘
  /// 사용처: 매우 중요한 요소, 아바타
  static const double iconHuge = 48.0;

  // ============================================================================
  // 아바타 크기 (Avatar Sizes)
  // ============================================================================
  
  /// 24px - 작은 아바타
  static const double avatarSmall = 24.0;
  
  /// 32px - 기본 아바타
  static const double avatarMedium = 32.0;
  
  /// 40px - 큰 아바타
  static const double avatarLarge = 40.0;
  
  /// 48px - 매우 큰 아바타
  static const double avatarXLarge = 48.0;
  
  /// 64px - 거대한 아바타
  static const double avatarHuge = 64.0;

  // ============================================================================
  // 버튼 크기 (Button Sizes)
  // ============================================================================
  
  /// 작은 버튼 높이
  static const double buttonSmallHeight = 32.0;
  
  /// 기본 버튼 높이
  static const double buttonMediumHeight = 40.0;
  
  /// 큰 버튼 높이
  static const double buttonLargeHeight = 48.0;
  
  /// 매우 큰 버튼 높이
  static const double buttonXLargeHeight = 56.0;

  // ============================================================================
  // 입력 필드 크기 (Input Field Sizes)
  // ============================================================================
  
  /// 작은 입력 필드 높이
  static const double inputSmallHeight = 32.0;
  
  /// 기본 입력 필드 높이
  static const double inputMediumHeight = 40.0;
  
  /// 큰 입력 필드 높이
  static const double inputLargeHeight = 48.0;
  
  /// 매우 큰 입력 필드 높이
  static const double inputXLargeHeight = 56.0;
}

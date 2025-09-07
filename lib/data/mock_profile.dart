/// 프로필 관련 목업 데이터
///
/// 디자이너 가이드:
/// - 이 파일은 프로필 페이지에서 사용되는 모든 목업 데이터를 관리합니다
/// - 사용자 정보, 통계, 설정 등을 포함합니다
/// - 실제 앱에서는 API에서 가져오는 데이터입니다

/// 사용자 프로필 정보
class UserProfile {
  final String userName;
  final String userTitle;
  final String userLocation;
  final String profileImage;
  final bool isVerified;
  final int completedJobs;
  final double rating;
  final int responseRate;
  final String bio;
  final DateTime joinDate;
  final List<String> skills;
  final List<String> certifications;

  const UserProfile({
    required this.userName,
    required this.userTitle,
    required this.userLocation,
    required this.profileImage,
    required this.isVerified,
    required this.completedJobs,
    required this.rating,
    required this.responseRate,
    required this.bio,
    required this.joinDate,
    required this.skills,
    required this.certifications,
  });
}

/// 사용자 통계 정보
class UserStats {
  final int completedJobs;
  final double rating;
  final int responseRate;
  final int totalEarnings;
  final int activeJobs;
  final int completedThisMonth;

  const UserStats({
    required this.completedJobs,
    required this.rating,
    required this.responseRate,
    required this.totalEarnings,
    required this.activeJobs,
    required this.completedThisMonth,
  });
}

/// 사용자 설정 정보
class UserSettings {
  final bool notificationsEnabled;
  final bool locationSharingEnabled;
  final bool profilePublic;
  final String language;
  final String timezone;

  const UserSettings({
    required this.notificationsEnabled,
    required this.locationSharingEnabled,
    required this.profilePublic,
    required this.language,
    required this.timezone,
  });
}

/// 목업 데이터
class MockProfileData {
  /// 기본 사용자 프로필
  static final UserProfile defaultProfile = UserProfile(
    userName: '김농부',
    userTitle: '농업 근로자 • 5년 경력',
    userLocation: '김제시 금구면',
    profileImage: '',
    isVerified: false,
    completedJobs: 47,
    rating: 4.8,
    responseRate: 98,
    bio: '5년간 다양한 농업 작업에 참여한 경험이 있습니다. 특히 과수원 관리와 수확 작업에 전문성을 가지고 있습니다.',
    joinDate: DateTime(2022, 3, 15),
    skills: [
      '과수원 관리',
      '수확 작업',
      '농기계 조작',
      '토양 관리',
      '병해충 방제',
    ],
    certifications: [
      '농업기술사 자격증',
      '안전교육 이수증',
      '농기계 운전면허',
    ],
  );

  /// 인증된 사용자 프로필
  static final UserProfile verifiedProfile = UserProfile(
    userName: '김농부',
    userTitle: '농업 근로자 • 5년 경력',
    userLocation: '김제시 금구면',
    profileImage: '',
    isVerified: true,
    completedJobs: 47,
    rating: 4.8,
    responseRate: 98,
    bio: '5년간 다양한 농업 작업에 참여한 경험이 있습니다. 특히 과수원 관리와 수확 작업에 전문성을 가지고 있습니다.',
    joinDate: DateTime(2022, 3, 15),
    skills: [
      '과수원 관리',
      '수확 작업',
      '농기계 조작',
      '토양 관리',
      '병해충 방제',
    ],
    certifications: [
      '농업기술사 자격증',
      '안전교육 이수증',
      '농기계 운전면허',
    ],
  );

  /// 사용자 통계
  static const UserStats userStats = UserStats(
    completedJobs: 47,
    rating: 4.8,
    responseRate: 98,
    totalEarnings: 12500000, // 1,250만원
    activeJobs: 3,
    completedThisMonth: 8,
  );

  /// 사용자 설정
  static const UserSettings userSettings = UserSettings(
    notificationsEnabled: true,
    locationSharingEnabled: true,
    profilePublic: true,
    language: 'ko',
    timezone: 'Asia/Seoul',
  );

  /// 다른 사용자 프로필들 (리뷰, 추천 등에서 사용)
  static final List<UserProfile> otherProfiles = [
    UserProfile(
      userName: '박농장주',
      userTitle: '농장주 • 10년 경력',
      userLocation: '김제시 성덕면',
      profileImage: '',
      isVerified: true,
      completedJobs: 0,
      rating: 0.0,
      responseRate: 0,
      bio: '10년간 농장을 운영하며 다양한 농업 작업을 관리해왔습니다.',
      joinDate: DateTime(2020, 1, 1),
      skills: ['농장 관리', '작물 재배', '농기계 수리'],
      certifications: ['농업경영사', '농기계 정비사'],
    ),
    UserProfile(
      userName: '이근로자',
      userTitle: '농업 근로자 • 3년 경력',
      userLocation: '김제시 백산면',
      profileImage: '',
      isVerified: false,
      completedJobs: 23,
      rating: 4.5,
      responseRate: 95,
      bio: '3년간 다양한 농업 작업에 참여하며 경험을 쌓아왔습니다.',
      joinDate: DateTime(2023, 6, 1),
      skills: ['밭작물 재배', '수확 작업', '포장 작업'],
      certifications: ['안전교육 이수증'],
    ),
  ];
}

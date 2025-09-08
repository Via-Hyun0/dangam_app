/// 사용자 프로필 모델
///
/// TODO::LUKA - Firebase Firestore 컬렉션 'users'와 매핑
/// - 문서 ID: userId (uid)
/// - 필드명: Firebase 규칙에 맞게 수정 필요
/// - 보안 규칙: 사용자는 자신의 프로필만 읽기/쓰기 가능
class UserProfile {
  final String userId;
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
  final DateTime? lastActiveAt;
  final Map<String, dynamic> preferences;

  const UserProfile({
    required this.userId,
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
    this.lastActiveAt,
    this.preferences = const {},
  });

  /// Firebase에서 데이터를 가져올 때 사용
  factory UserProfile.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return UserProfile(
      userId: documentId,
      userName: data['userName'] ?? '',
      userTitle: data['userTitle'] ?? '',
      userLocation: data['userLocation'] ?? '',
      profileImage: data['profileImage'] ?? '',
      isVerified: data['isVerified'] ?? false,
      completedJobs: data['completedJobs'] ?? 0,
      rating: (data['rating'] ?? 0.0).toDouble(),
      responseRate: data['responseRate'] ?? 0,
      bio: data['bio'] ?? '',
      joinDate: DateTime.fromMillisecondsSinceEpoch(data['joinDate'] ?? 0),
      skills: List<String>.from(data['skills'] ?? []),
      certifications: List<String>.from(data['certifications'] ?? []),
      lastActiveAt: data['lastActiveAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['lastActiveAt'])
          : null,
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
    );
  }

  /// Firebase에 데이터를 저장할 때 사용
  Map<String, dynamic> toFirestore() {
    return {
      'userName': userName,
      'userTitle': userTitle,
      'userLocation': userLocation,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'completedJobs': completedJobs,
      'rating': rating,
      'responseRate': responseRate,
      'bio': bio,
      'joinDate': joinDate.millisecondsSinceEpoch,
      'skills': skills,
      'certifications': certifications,
      'lastActiveAt': lastActiveAt?.millisecondsSinceEpoch,
      'preferences': preferences,
    };
  }

  /// 데이터 복사 (일부 필드만 업데이트)
  UserProfile copyWith({
    String? userId,
    String? userName,
    String? userTitle,
    String? userLocation,
    String? profileImage,
    bool? isVerified,
    int? completedJobs,
    double? rating,
    int? responseRate,
    String? bio,
    DateTime? joinDate,
    List<String>? skills,
    List<String>? certifications,
    DateTime? lastActiveAt,
    Map<String, dynamic>? preferences,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userTitle: userTitle ?? this.userTitle,
      userLocation: userLocation ?? this.userLocation,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      completedJobs: completedJobs ?? this.completedJobs,
      rating: rating ?? this.rating,
      responseRate: responseRate ?? this.responseRate,
      bio: bio ?? this.bio,
      joinDate: joinDate ?? this.joinDate,
      skills: skills ?? this.skills,
      certifications: certifications ?? this.certifications,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      preferences: preferences ?? this.preferences,
    );
  }
}

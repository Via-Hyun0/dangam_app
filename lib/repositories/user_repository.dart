import '../models/user_profile.dart';

/// 사용자 데이터 Repository 인터페이스
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - FirebaseAuth로 사용자 인증 관리
/// - Firestore로 사용자 데이터 CRUD
/// - Storage로 프로필 이미지 업로드/다운로드
/// - 보안 규칙: 사용자는 자신의 데이터만 접근 가능
abstract class UserRepository {
  /// 현재 사용자 프로필 가져오기
  Future<UserProfile?> getCurrentUser();

  /// 사용자 프로필 업데이트
  Future<void> updateProfile(UserProfile profile);

  /// 프로필 이미지 업로드
  Future<String> uploadProfileImage(String imagePath);

  /// 사용자 검색 (이름, 위치 등으로)
  Future<List<UserProfile>> searchUsers(String query);

  /// 사용자 통계 업데이트
  Future<void> updateUserStats({
    required String userId,
    int? completedJobs,
    double? rating,
    int? responseRate,
  });
}

/// 목업 사용자 Repository 구현체
///
/// TODO::LUKA - Firebase 구현체로 교체
class MockUserRepository implements UserRepository {
  static const String _currentUserId = 'mock_user_001';

  @override
  Future<UserProfile?> getCurrentUser() async {
    // TODO::LUKA - Firebase Auth에서 현재 사용자 ID 가져오기
    // final user = FirebaseAuth.instance.currentUser;
    // if (user == null) return null;

    // 목업 데이터 반환
    await Future.delayed(const Duration(milliseconds: 500)); // 네트워크 지연 시뮬레이션

    return UserProfile(
      userId: _currentUserId,
      userName: '김농부',
      userTitle: '경험 많은 농업 근로자',
      userLocation: '김제시 금구면',
      profileImage: 'https://example.com/profile.jpg',
      isVerified: true,
      completedJobs: 15,
      rating: 4.8,
      responseRate: 95,
      bio: '10년 경력의 농업 전문가입니다. 과일 수확, 트랙터 작업 등 다양한 농업 작업에 경험이 있습니다.',
      joinDate: DateTime(2023, 1, 15),
      skills: const ['과일 수확', '트랙터 조작', '관개 시설', '가지치기'],
      certifications: const ['농업 안전 교육', '트랙터 운전 면허'],
      lastActiveAt: DateTime.now(),
      preferences: const {
        'notifications': true,
        'locationSharing': true,
        'language': 'ko',
      },
    );
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    // TODO::LUKA - Firestore에 프로필 업데이트
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(profile.userId)
    //     .update(profile.toFirestore());

    await Future.delayed(const Duration(milliseconds: 800)); // 네트워크 지연 시뮬레이션
    print('프로필 업데이트됨: ${profile.userName}');
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    // TODO::LUKA - Firebase Storage에 이미지 업로드
    // final ref = FirebaseStorage.instance
    //     .ref()
    //     .child('profile_images')
    //     .child('${_currentUserId}_${DateTime.now().millisecondsSinceEpoch}.jpg');
    // await ref.putFile(File(imagePath));
    // return await ref.getDownloadURL();

    await Future.delayed(const Duration(milliseconds: 1200)); // 업로드 지연 시뮬레이션
    return 'https://example.com/uploaded_profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  @override
  Future<List<UserProfile>> searchUsers(String query) async {
    // TODO::LUKA - Firestore에서 사용자 검색
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('userName', isGreaterThanOrEqualTo: query)
    //     .where('userName', isLessThan: query + 'z')
    //     .limit(20)
    //     .get();

    await Future.delayed(const Duration(milliseconds: 600));

    // 목업 검색 결과
    return [
      UserProfile(
        userId: 'user_002',
        userName: '이농부',
        userTitle: '유기농 전문가',
        userLocation: '김제시 봉남면',
        profileImage: '',
        isVerified: true,
        completedJobs: 8,
        rating: 4.6,
        responseRate: 90,
        bio: '유기농 재배 전문가입니다.',
        joinDate: DateTime(2023, 3, 10),
        skills: const ['유기농 재배', '토양 관리'],
        certifications: const ['유기농 인증'],
      ),
    ];
  }

  @override
  Future<void> updateUserStats({
    required String userId,
    int? completedJobs,
    double? rating,
    int? responseRate,
  }) async {
    // TODO::LUKA - Firestore에서 사용자 통계 업데이트
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userId)
    //     .update({
    //       if (completedJobs != null) 'completedJobs': completedJobs,
    //       if (rating != null) 'rating': rating,
    //       if (responseRate != null) 'responseRate': responseRate,
    //       'updatedAt': FieldValue.serverTimestamp(),
    //     });

    await Future.delayed(const Duration(milliseconds: 400));
    print('사용자 통계 업데이트됨: $userId');
  }
}

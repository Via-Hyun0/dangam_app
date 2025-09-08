import '../repositories/user_repository.dart';
import '../repositories/job_repository.dart';
import '../repositories/notification_repository.dart';
import '../models/user_profile.dart';
import '../models/job.dart';
import '../models/notification.dart';

/// 데이터 서비스 중앙 관리 클래스
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - Repository 구현체들을 Firebase 버전으로 교체
/// - 의존성 주입으로 Repository 관리
/// - 에러 핸들링 및 로깅 추가
class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Repository 인스턴스들
  late final UserRepository _userRepository;
  late final JobRepository _jobRepository;
  late final NotificationRepository _notificationRepository;

  /// 서비스 초기화
  ///
  /// TODO::LUKA - Firebase 초기화로 교체
  /// - Firebase.initializeApp() 호출
  /// - Firebase Auth, Firestore, Storage 초기화
  /// - Repository들을 Firebase 구현체로 교체
  void initialize() {
    // TODO::LUKA - Firebase 초기화
    // await Firebase.initializeApp();

    // 목업 Repository들 초기화
    _userRepository = MockUserRepository();
    _jobRepository = MockJobRepository();
    _notificationRepository = MockNotificationRepository();

    print('DataService 초기화 완료 (목업 모드)');
  }

  // ============================================================================
  // 사용자 관련 서비스
  // ============================================================================

  /// 현재 사용자 프로필 가져오기
  Future<UserProfile?> getCurrentUser() async {
    try {
      return await _userRepository.getCurrentUser();
    } catch (e) {
      print('사용자 프로필 가져오기 실패: $e');
      return null;
    }
  }

  /// 사용자 프로필 업데이트
  Future<bool> updateProfile(UserProfile profile) async {
    try {
      await _userRepository.updateProfile(profile);
      return true;
    } catch (e) {
      print('프로필 업데이트 실패: $e');
      return false;
    }
  }

  /// 프로필 이미지 업로드
  Future<String?> uploadProfileImage(String imagePath) async {
    try {
      return await _userRepository.uploadProfileImage(imagePath);
    } catch (e) {
      print('이미지 업로드 실패: $e');
      return null;
    }
  }

  /// 사용자 검색
  Future<List<UserProfile>> searchUsers(String query) async {
    try {
      return await _userRepository.searchUsers(query);
    } catch (e) {
      print('사용자 검색 실패: $e');
      return [];
    }
  }

  // ============================================================================
  // 작업 관련 서비스
  // ============================================================================

  /// 모든 작업 목록 가져오기
  Future<List<Job>> getAllJobs() async {
    try {
      return await _jobRepository.getAllJobs();
    } catch (e) {
      print('작업 목록 가져오기 실패: $e');
      return [];
    }
  }

  /// 위치 기반 작업 검색
  Future<List<Job>> searchJobsByLocation({
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    try {
      return await _jobRepository.searchJobsByLocation(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );
    } catch (e) {
      print('위치 기반 작업 검색 실패: $e');
      return [];
    }
  }

  /// 작업 타입별 검색
  Future<List<Job>> searchJobsByType(JobType type) async {
    try {
      return await _jobRepository.searchJobsByType(type);
    } catch (e) {
      print('타입별 작업 검색 실패: $e');
      return [];
    }
  }

  /// 작업 상세 정보 가져오기
  Future<Job?> getJobById(String jobId) async {
    try {
      return await _jobRepository.getJobById(jobId);
    } catch (e) {
      print('작업 상세 정보 가져오기 실패: $e');
      return null;
    }
  }

  /// 작업 지원
  Future<bool> applyToJob(String jobId, String userId) async {
    try {
      await _jobRepository.applyToJob(jobId, userId);
      return true;
    } catch (e) {
      print('작업 지원 실패: $e');
      return false;
    }
  }

  // ============================================================================
  // 알림 관련 서비스
  // ============================================================================

  /// 사용자 알림 목록 가져오기
  Future<List<NotificationItem>> getUserNotifications(String userId) async {
    try {
      return await _notificationRepository.getUserNotifications(userId);
    } catch (e) {
      print('알림 목록 가져오기 실패: $e');
      return [];
    }
  }

  /// 읽지 않은 알림 개수 가져오기
  Future<int> getUnreadCount(String userId) async {
    try {
      return await _notificationRepository.getUnreadCount(userId);
    } catch (e) {
      print('읽지 않은 알림 개수 가져오기 실패: $e');
      return 0;
    }
  }

  /// 알림을 읽음으로 표시
  Future<bool> markNotificationAsRead(String notificationId) async {
    try {
      await _notificationRepository.markAsRead(notificationId);
      return true;
    } catch (e) {
      print('알림 읽음 처리 실패: $e');
      return false;
    }
  }

  /// 모든 알림을 읽음으로 표시
  Future<bool> markAllNotificationsAsRead(String userId) async {
    try {
      await _notificationRepository.markAllAsRead(userId);
      return true;
    } catch (e) {
      print('모든 알림 읽음 처리 실패: $e');
      return false;
    }
  }

  // ============================================================================
  // 유틸리티 메서드
  // ============================================================================

  /// 네트워크 연결 상태 확인
  ///
  /// TODO::LUKA - Firebase 연결 상태 확인으로 교체
  /// - Firebase 연결 상태 모니터링
  /// - 오프라인 모드 지원
  Future<bool> isConnected() async {
    // TODO::LUKA - Firebase 연결 상태 확인
    // return FirebaseFirestore.instance.enableNetwork() != null;

    // 목업: 항상 연결됨으로 가정
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  /// 캐시 초기화
  ///
  /// TODO::LUKA - Firebase 캐시 초기화로 교체
  /// - Firestore 캐시 클리어
  /// - 로컬 저장소 정리
  Future<void> clearCache() async {
    // TODO::LUKA - Firebase 캐시 초기화
    // await FirebaseFirestore.instance.clearPersistence();

    print('캐시 초기화 완료');
  }
}

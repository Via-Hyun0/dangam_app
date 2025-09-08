import '../models/user_profile.dart';
import '../models/job.dart';
import '../models/notification.dart';

/// 목업 데이터 관리 클래스
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - 이 클래스는 Firebase 연결 후 제거 예정
/// - 모든 데이터는 Firestore에서 관리
/// - Cloud Functions로 데이터 초기화
class MockData {
  static const String _currentUserId = 'mock_user_001';

  /// 기본 사용자 프로필 데이터
  static UserProfile get defaultProfile => UserProfile(
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
        skills: ['과일 수확', '트랙터 조작', '관개 시설', '가지치기'],
        certifications: ['농업 안전 교육', '트랙터 운전 면허'],
        lastActiveAt: null, // 현재 시간으로 설정
        preferences: {
          'notifications': true,
          'locationSharing': true,
          'language': 'ko',
          'theme': 'light',
        },
      );

  /// 사용자 통계 데이터
  static const Map<String, dynamic> userStats = {
    'completedJobs': 15,
    'rating': 4.8,
    'responseRate': 95,
    'totalEarnings': 2500000,
    'thisMonthJobs': 3,
    'averageRating': 4.7,
  };

  /// 사용자 설정 데이터
  static const Map<String, dynamic> userSettings = {
    'notifications': {
      'push': true,
      'email': false,
      'sms': false,
    },
    'privacy': {
      'profileVisible': true,
      'locationVisible': true,
      'contactVisible': false,
    },
    'appearance': {
      'theme': 'light',
      'language': 'ko',
      'fontSize': 'medium',
    },
  };

  /// 샘플 작업 데이터
  static List<Job> get sampleJobs => [
        Job(
          jobId: 'job_001',
          title: '포도 수확팀',
          crop: '포도',
          location: '김제시 금구면',
          areaHectares: 3.2,
          requiredEquipment: const ['수확 바구니', '가위'],
          scheduledDate: DateTime.now().add(const Duration(days: 5)),
          type: JobType.fruitPicking,
          distanceKm: 2.1,
          employerName: '김제 포도농장',
          status: JobStatus.available,
          description: '포도 수확 작업을 도와주실 분을 찾습니다. 경험이 있으시면 우대합니다.',
          hourlyRate: 15000.0,
          estimatedHours: 8,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
          createdBy: 'employer_001',
        ),
        Job(
          jobId: 'job_002',
          title: '사과 수확 - 홍로',
          crop: '사과',
          location: '김제시 봉남면',
          areaHectares: 4.5,
          requiredEquipment: const ['수확 가방', '사다리'],
          scheduledDate: DateTime.now().add(const Duration(days: 3)),
          type: JobType.fruitPicking,
          distanceKm: 6.4,
          employerName: '봉남 과수원',
          status: JobStatus.available,
          description: '홍로 사과 수확 작업입니다. 신중하게 작업해주세요.',
          hourlyRate: 18000.0,
          estimatedHours: 6,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          createdBy: 'employer_002',
        ),
        Job(
          jobId: 'job_003',
          title: '트랙터 제초 작업',
          crop: '사과',
          location: '김제시 봉남면',
          areaHectares: 5.0,
          requiredEquipment: const ['트랙터 + 제초기'],
          scheduledDate: DateTime.now().add(const Duration(days: 2)),
          type: JobType.tractorMowing,
          distanceKm: 6.4,
          employerName: '봉남 과수원',
          status: JobStatus.available,
          description: '과수원 잡초 제거 작업입니다. 트랙터 운전 경험이 필요합니다.',
          hourlyRate: 25000.0,
          estimatedHours: 4,
          createdAt: DateTime.now().subtract(const Duration(hours: 12)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
          createdBy: 'employer_002',
        ),
      ];

  /// 샘플 알림 데이터
  static List<NotificationItem> get sampleNotifications => [
        NotificationItem(
          notificationId: 'notif_001',
          userId: _currentUserId,
          title: '2025 스마트팜 지원사업',
          content: 'IoT 센서와 자동화를 통한 농업 현대화를 위한 정부 지원금 신청하세요.',
          type: NotificationType.announcement,
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          data: {
            'link': 'https://example.com/smart-farming-support',
            'category': 'support',
          },
        ),
        NotificationItem(
          notificationId: 'notif_002',
          userId: _currentUserId,
          title: '새로운 작업 제안',
          content: '김제시 금구면에서 포도 수확 작업이 제안되었습니다.',
          type: NotificationType.job,
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          data: {
            'jobId': 'job_001',
            'action': 'view_job',
          },
        ),
        NotificationItem(
          notificationId: 'notif_003',
          userId: _currentUserId,
          title: '계약 상태 업데이트',
          content: '신청하신 작업의 계약이 승인되었습니다.',
          type: NotificationType.contract,
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(hours: 12)),
          readAt: DateTime.now().subtract(const Duration(hours: 10)),
          data: {
            'contractId': 'contract_001',
            'action': 'view_contract',
          },
        ),
        NotificationItem(
          notificationId: 'notif_004',
          userId: _currentUserId,
          title: '메시지 알림',
          content: '고용주로부터 새로운 메시지가 도착했습니다.',
          type: NotificationType.message,
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          data: {
            'chatId': 'chat_001',
            'action': 'open_chat',
          },
        ),
      ];

  /// 샘플 공지사항 데이터
  static List<Map<String, dynamic>> get sampleNotices => [
        {
          'id': 'notice_001',
          'title': '2025 스마트팜 지원사업',
          'content': 'IoT 센서와 자동화를 통한 농업 현대화를 위한 정부 지원금 신청하세요.',
          'type': 'support',
          'publishedAt': DateTime.now().subtract(const Duration(days: 2)),
          'link': 'https://example.com/smart-farming-support',
        },
        {
          'id': 'notice_002',
          'title': '농촌 일자리 인센티브 제도',
          'content': '농촌 지역 계절근로자 고용에 대한 재정적 인센티브. 근로자당 최대 500만원.',
          'type': 'support',
          'publishedAt': DateTime.now().subtract(const Duration(days: 5)),
          'link': 'https://example.com/rural-employment',
        },
        {
          'id': 'notice_003',
          'title': '농업 근로자 안전 규정 신규 제정',
          'content': '2025년 3월부터 시행되는 농업 근로자 안전 가이드라인이 업데이트되었습니다.',
          'type': 'policy',
          'publishedAt': DateTime.now().subtract(const Duration(days: 4)),
        },
        {
          'id': 'notice_004',
          'title': '2025 농업기술 전시회',
          'content': '최신 농업 기술과 장비를 선보이는 연례 전시회에 참여하세요.',
          'type': 'event',
          'publishedAt': DateTime.now().subtract(const Duration(days: 3)),
          'link': 'https://example.com/agtech-expo-2025',
        },
      ];

  /// 샘플 채팅 데이터
  static List<Map<String, dynamic>> get sampleChats => [
        {
          'id': 'chat_001',
          'title': '김제 포도농장',
          'lastMessage': '안녕하세요! 포도 수확 작업에 관심이 있으시군요.',
          'lastMessageAt': DateTime.now().subtract(const Duration(minutes: 30)),
          'unreadCount': 2,
          'participants': ['mock_user_001', 'employer_001'],
        },
        {
          'id': 'chat_002',
          'title': '봉남 과수원',
          'lastMessage': '사과 수확 작업 일정을 확인해주세요.',
          'lastMessageAt': DateTime.now().subtract(const Duration(hours: 2)),
          'unreadCount': 0,
          'participants': ['mock_user_001', 'employer_002'],
        },
      ];

  /// 샘플 계약 데이터
  static List<Map<String, dynamic>> get sampleContracts => [
        {
          'id': 'contract_001',
          'jobTitle': '포도 수확 작업',
          'employerName': '김제 포도농장',
          'status': 'in_progress',
          'startDate': DateTime.now().subtract(const Duration(days: 2)),
          'endDate': DateTime.now().add(const Duration(days: 3)),
          'hourlyRate': 15000.0,
          'totalHours': 8,
          'progress': 0.6,
        },
        {
          'id': 'contract_002',
          'jobTitle': '사과 수확 작업',
          'employerName': '봉남 과수원',
          'status': 'completed',
          'startDate': DateTime.now().subtract(const Duration(days: 10)),
          'endDate': DateTime.now().subtract(const Duration(days: 8)),
          'hourlyRate': 18000.0,
          'totalHours': 6,
          'progress': 1.0,
        },
      ];
}

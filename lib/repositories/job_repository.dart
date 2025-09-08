import '../models/job.dart';

/// 작업 데이터 Repository 인터페이스
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - Firestore로 작업 데이터 CRUD
/// - GeoFirestore로 위치 기반 검색
/// - Cloud Functions로 작업 매칭 로직
/// - 보안 규칙: 모든 사용자가 읽기 가능, 작성자만 수정 가능
abstract class JobRepository {
  /// 모든 작업 목록 가져오기
  Future<List<Job>> getAllJobs();

  /// 위치 기반 작업 검색
  Future<List<Job>> searchJobsByLocation({
    required double latitude,
    required double longitude,
    required double radiusKm,
  });

  /// 작업 타입별 검색
  Future<List<Job>> searchJobsByType(JobType type);

  /// 작업 상태별 검색
  Future<List<Job>> searchJobsByStatus(JobStatus status);

  /// 사용자가 지원한 작업 목록
  Future<List<Job>> getAppliedJobs(String userId);

  /// 작업 상세 정보 가져오기
  Future<Job?> getJobById(String jobId);

  /// 작업 생성
  Future<String> createJob(Job job);

  /// 작업 업데이트
  Future<void> updateJob(Job job);

  /// 작업 삭제
  Future<void> deleteJob(String jobId);

  /// 작업 지원
  Future<void> applyToJob(String jobId, String userId);

  /// 작업 지원 취소
  Future<void> cancelJobApplication(String jobId, String userId);
}

/// 목업 작업 Repository 구현체
///
/// TODO::LUKA - Firebase 구현체로 교체
class MockJobRepository implements JobRepository {
  @override
  Future<List<Job>> getAllJobs() async {
    // TODO::LUKA - Firestore에서 모든 작업 가져오기
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .where('status', isEqualTo: 'available')
    //     .orderBy('createdAt', descending: true)
    //     .get();

    await Future.delayed(const Duration(milliseconds: 800));

    // 목업 데이터 반환
    return [
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
        description: '포도 수확 작업을 도와주실 분을 찾습니다.',
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
        description: '홍로 사과 수확 작업입니다.',
        hourlyRate: 18000.0,
        estimatedHours: 6,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        createdBy: 'employer_002',
      ),
    ];
  }

  @override
  Future<List<Job>> searchJobsByLocation({
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    // TODO::LUKA - GeoFirestore로 위치 기반 검색
    // final center = GeoPoint(latitude, longitude);
    // final radius = radiusKm * 1000; // 미터로 변환
    // final query = GeoFirestore.collection('jobs')
    //     .within(center: center, radius: radius, field: 'location');

    await Future.delayed(const Duration(milliseconds: 600));

    // 목업: 현재 위치에서 10km 이내 작업들
    return await getAllJobs();
  }

  @override
  Future<List<Job>> searchJobsByType(JobType type) async {
    // TODO::LUKA - Firestore에서 타입별 검색
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .where('type', isEqualTo: type.toString().split('.').last)
    //     .where('status', isEqualTo: 'available')
    //     .get();

    await Future.delayed(const Duration(milliseconds: 500));

    final allJobs = await getAllJobs();
    return allJobs.where((job) => job.type == type).toList();
  }

  @override
  Future<List<Job>> searchJobsByStatus(JobStatus status) async {
    // TODO::LUKA - Firestore에서 상태별 검색
    await Future.delayed(const Duration(milliseconds: 500));

    final allJobs = await getAllJobs();
    return allJobs.where((job) => job.status == status).toList();
  }

  @override
  Future<List<Job>> getAppliedJobs(String userId) async {
    // TODO::LUKA - Firestore에서 사용자가 지원한 작업들 가져오기
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('job_applications')
    //     .where('userId', isEqualTo: userId)
    //     .where('status', isEqualTo: 'applied')
    //     .get();

    await Future.delayed(const Duration(milliseconds: 600));

    // 목업: 사용자가 지원한 작업들
    return [];
  }

  @override
  Future<Job?> getJobById(String jobId) async {
    // TODO::LUKA - Firestore에서 특정 작업 가져오기
    // final doc = await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .doc(jobId)
    //     .get();

    await Future.delayed(const Duration(milliseconds: 400));

    final allJobs = await getAllJobs();
    try {
      return allJobs.firstWhere((job) => job.jobId == jobId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> createJob(Job job) async {
    // TODO::LUKA - Firestore에 새 작업 생성
    // final docRef = await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .add(job.toFirestore());
    // return docRef.id;

    await Future.delayed(const Duration(milliseconds: 1000));

    final newJobId = 'job_${DateTime.now().millisecondsSinceEpoch}';
    print('새 작업 생성됨: $newJobId');
    return newJobId;
  }

  @override
  Future<void> updateJob(Job job) async {
    // TODO::LUKA - Firestore에서 작업 업데이트
    // await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .doc(job.jobId)
    //     .update(job.toFirestore());

    await Future.delayed(const Duration(milliseconds: 800));
    print('작업 업데이트됨: ${job.jobId}');
  }

  @override
  Future<void> deleteJob(String jobId) async {
    // TODO::LUKA - Firestore에서 작업 삭제
    // await FirebaseFirestore.instance
    //     .collection('jobs')
    //     .doc(jobId)
    //     .delete();

    await Future.delayed(const Duration(milliseconds: 600));
    print('작업 삭제됨: $jobId');
  }

  @override
  Future<void> applyToJob(String jobId, String userId) async {
    // TODO::LUKA - Firestore에 작업 지원 기록
    // await FirebaseFirestore.instance
    //     .collection('job_applications')
    //     .add({
    //       'jobId': jobId,
    //       'userId': userId,
    //       'status': 'applied',
    //       'appliedAt': FieldValue.serverTimestamp(),
    //     });

    await Future.delayed(const Duration(milliseconds: 700));
    print('작업 지원됨: $jobId by $userId');
  }

  @override
  Future<void> cancelJobApplication(String jobId, String userId) async {
    // TODO::LUKA - Firestore에서 작업 지원 취소
    // await FirebaseFirestore.instance
    //     .collection('job_applications')
    //     .where('jobId', isEqualTo: jobId)
    //     .where('userId', isEqualTo: userId)
    //     .get()
    //     .then((snapshot) {
    //       for (var doc in snapshot.docs) {
    //         doc.reference.delete();
    //       }
    //     });

    await Future.delayed(const Duration(milliseconds: 500));
    print('작업 지원 취소됨: $jobId by $userId');
  }
}

import 'package:flutter/material.dart';
import 'package:dangam_app/models/job.dart';

/// 목업 작업 데이터
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - 이 파일은 Firebase 연결 후 제거 예정
/// - 모든 데이터는 Firestore에서 관리
/// - Cloud Functions로 데이터 초기화
final List<Job> mockJobs = [
  // 과일 수확 작업
  Job(
    jobId: 'j1',
    title: '포도 수확팀',
    crop: '포도',
    location: '김제시 금구면',
    areaHectares: 3.2,
    requiredEquipment: const ['수확 바구니', '가위'],
    scheduledDate: DateTime.now().add(const Duration(days: 5)),
    type: JobType.fruitPicking,
    distanceKm: 2.1,
    employerName: '김제 포도농장',
    status: JobStatus.applied,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_001',
  ),
  Job(
    jobId: 'j2',
    title: '사과 수확 - 홍로',
    crop: '사과',
    location: '김제시 봉남면',
    areaHectares: 4.5,
    requiredEquipment: const ['수확 가방', '사다리'],
    scheduledDate: DateTime.now().add(const Duration(days: 3)),
    type: JobType.fruitPicking,
    distanceKm: 6.4,
    employerName: '봉남 과수원',
    status: JobStatus.interested,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_002',
  ),
  Job(
    jobId: 'j3',
    title: '딸기 수확',
    crop: '딸기',
    location: '김제시 성덕면',
    areaHectares: 2.1,
    requiredEquipment: const ['수확 용기', '무릎 보호대'],
    scheduledDate: DateTime.now().add(const Duration(days: 1)),
    type: JobType.fruitPicking,
    distanceKm: 4.2,
    employerName: '성덕 딸기농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    createdBy: 'employer_003',
  ),
  Job(
    jobId: 'j4',
    title: '감귤 수확팀',
    crop: '감귤',
    location: '김제시 부량면',
    areaHectares: 6.8,
    requiredEquipment: const ['수확 가방', '가위'],
    scheduledDate: DateTime.now().add(const Duration(days: 7)),
    type: JobType.fruitPicking,
    distanceKm: 8.3,
    employerName: '부량 감귤농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    createdBy: 'employer_004',
  ),

  // 트랙터 작업
  Job(
    jobId: 'j5',
    title: '트랙터 제초 (과수원)',
    crop: '사과',
    location: '김제시 봉남면',
    areaHectares: 5.0,
    requiredEquipment: const ['트랙터 + 제초기'],
    scheduledDate: DateTime.now().add(const Duration(days: 2)),
    type: JobType.tractorMowing,
    distanceKm: 6.4,
    employerName: '봉남 과수원',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    createdBy: 'employer_002',
  ),
  Job(
    jobId: 'j6',
    title: '트랙터 밭갈이 작업',
    crop: '밀',
    location: 'Wimmera',
    areaHectares: 12.5,
    requiredEquipment: const ['트랙터', '경운기'],
    scheduledDate: DateTime.now().add(const Duration(days: 4)),
    type: JobType.tractorMowing,
    distanceKm: 15.2,
    employerName: 'Wheatfield Agriculture',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_005',
  ),
  Job(
    jobId: 'j7',
    title: '목초지 예초 작업',
    crop: '목초',
    location: 'Gippsland',
    areaHectares: 8.3,
    requiredEquipment: const ['트랙터 + 회전 예초기'],
    scheduledDate: DateTime.now().add(const Duration(days: 6)),
    type: JobType.tractorMowing,
    distanceKm: 9.7,
    employerName: 'Green Pastures Ltd',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_006',
  ),

  // 관개 시설
  Job(
    jobId: 'j8',
    title: '밭작물 관개 시설 설치',
    crop: '상추',
    location: '김제시 성덕면',
    areaHectares: 1.8,
    requiredEquipment: const ['관수 파이프', '펌프'],
    scheduledDate: null,
    type: JobType.irrigationSetup,
    distanceKm: 1.3,
    employerName: '성덕 농산물',
    status: JobStatus.interested,
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    createdBy: 'employer_003',
  ),
  Job(
    jobId: 'j9',
    title: '적하 관개 시설 설치',
    crop: '토마토',
    location: 'Lockyer Valley',
    areaHectares: 3.7,
    requiredEquipment: const ['적하 테이프', '필터', '압력 조절기'],
    scheduledDate: DateTime.now().add(const Duration(days: 2)),
    type: JobType.irrigationSetup,
    distanceKm: 5.8,
    employerName: 'Tomato Growers Inc',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
    createdBy: 'employer_007',
  ),
  Job(
    jobId: 'j10',
    title: '스프링클러 시스템 점검',
    crop: '옥수수',
    location: 'Darling Downs',
    areaHectares: 15.2,
    requiredEquipment: const ['스프링클러 헤드', '파이프 피팅', '도구'],
    scheduledDate: DateTime.now().add(const Duration(days: 1)),
    type: JobType.irrigationSetup,
    distanceKm: 12.4,
    employerName: 'Cornfield Enterprises',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
    createdBy: 'employer_008',
  ),

  // 심기 작업
  Job(
    jobId: 'j11',
    title: '옥수수 종자 파종',
    crop: '옥수수',
    location: 'Darling Downs',
    areaHectares: 20.0,
    requiredEquipment: const ['파종기', '종자', '비료'],
    scheduledDate: DateTime.now().add(const Duration(days: 3)),
    type: JobType.planting,
    distanceKm: 12.4,
    employerName: 'Cornfield Enterprises',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_008',
  ),
  Job(
    jobId: 'j12',
    title: '유칼립투스 나무 심기',
    crop: '유칼립투스',
    location: 'Blue Mountains',
    areaHectares: 5.5,
    requiredEquipment: const ['삽', '묘목', '멀칭재'],
    scheduledDate: DateTime.now().add(const Duration(days: 8)),
    type: JobType.planting,
    distanceKm: 18.6,
    employerName: 'Forest Restoration Co.',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_009',
  ),
  Job(
    jobId: 'j13',
    title: '채소 모종 이식',
    crop: '양배추',
    location: 'Lockyer Valley',
    areaHectares: 2.3,
    requiredEquipment: const ['이식기', '묘목'],
    scheduledDate: DateTime.now().add(const Duration(days: 2)),
    type: JobType.planting,
    distanceKm: 5.8,
    employerName: 'Fresh Veggie Farms',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 10)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 10)),
    createdBy: 'employer_010',
  ),

  // 수확 작업
  Job(
    jobId: 'j14',
    title: '밀 수확',
    crop: '밀',
    location: '김제시 금구면',
    areaHectares: 25.0,
    requiredEquipment: const ['콤바인', '곡물 트럭'],
    scheduledDate: DateTime.now().add(const Duration(days: 10)),
    type: JobType.harvesting,
    distanceKm: 15.2,
    employerName: '금구 밀농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    createdBy: 'employer_011',
  ),
  Job(
    jobId: 'j15',
    title: '감자 수확',
    crop: '감자',
    location: '김제시 성덕면',
    areaHectares: 8.7,
    requiredEquipment: const ['감자 수확기', '저장용 바구니'],
    scheduledDate: DateTime.now().add(const Duration(days: 5)),
    type: JobType.harvesting,
    distanceKm: 22.1,
    employerName: '성덕 감자농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_012',
  ),
  Job(
    jobId: 'j16',
    title: '면화 수확',
    crop: '면화',
    location: '김제시 봉남면',
    areaHectares: 30.0,
    requiredEquipment: const ['면화 수확기', '모듈 빌더'],
    scheduledDate: DateTime.now().add(const Duration(days: 12)),
    type: JobType.harvesting,
    distanceKm: 45.3,
    employerName: '봉남 면화농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    createdBy: 'employer_013',
  ),

  // 토양 준비
  Job(
    jobId: 'j17',
    title: '채소용 토양 준비',
    crop: '당근',
    location: '김제시 부량면',
    areaHectares: 3.2,
    requiredEquipment: const ['로터틸러', '퇴비 살포기'],
    scheduledDate: DateTime.now().add(const Duration(days: 4)),
    type: JobType.soilPreparation,
    distanceKm: 5.8,
    employerName: '부량 채소농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    createdBy: 'employer_004',
  ),
  Job(
    jobId: 'j18',
    title: '밭 갈기',
    crop: '콩',
    location: '김제시 금구면',
    areaHectares: 18.5,
    requiredEquipment: const ['보습 쟁기', '트랙터'],
    scheduledDate: DateTime.now().add(const Duration(days: 6)),
    type: JobType.soilPreparation,
    distanceKm: 12.4,
    employerName: '금구 콩농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_011',
  ),

  // 가지치기
  Job(
    jobId: 'j19',
    title: '포도 덩굴 가지치기',
    crop: '포도',
    location: '김제시 봉남면',
    areaHectares: 4.8,
    requiredEquipment: const ['전지 가위', '사다리'],
    scheduledDate: DateTime.now().add(const Duration(days: 9)),
    type: JobType.pruning,
    distanceKm: 7.2,
    employerName: '봉남 포도농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_014',
  ),
  Job(
    jobId: 'j20',
    title: '과수원 가지치기',
    crop: '복숭아',
    location: '김제시 성덕면',
    areaHectares: 6.2,
    requiredEquipment: const ['전지 톱', '고지 가위'],
    scheduledDate: DateTime.now().add(const Duration(days: 11)),
    type: JobType.pruning,
    distanceKm: 13.8,
    employerName: '성덕 복숭아농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    createdBy: 'employer_015',
  ),

  // 비료 주기
  Job(
    jobId: 'j21',
    title: '비료 시용',
    crop: '밀',
    location: '김제시 금구면',
    areaHectares: 22.0,
    requiredEquipment: const ['비료 살포기', '트랙터'],
    scheduledDate: DateTime.now().add(const Duration(days: 7)),
    type: JobType.fertilizing,
    distanceKm: 15.2,
    employerName: '금구 밀농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_011',
  ),
  Job(
    jobId: 'j22',
    title: '유기 퇴비 살포',
    crop: '상추',
    location: '김제시 부량면',
    areaHectares: 2.5,
    requiredEquipment: const ['퇴비 살포기', '손수레'],
    scheduledDate: DateTime.now().add(const Duration(days: 3)),
    type: JobType.fertilizing,
    distanceKm: 1.3,
    employerName: '부량 채소농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
    createdBy: 'employer_004',
  ),

  // 해충 방제
  Job(
    jobId: 'j23',
    title: '해충 방제 살포',
    crop: '면화',
    location: '김제시 봉남면',
    areaHectares: 25.0,
    requiredEquipment: const ['살포기', '보호장비', '농약'],
    scheduledDate: DateTime.now().add(const Duration(days: 4)),
    type: JobType.pestControl,
    distanceKm: 45.3,
    employerName: '봉남 면화농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdBy: 'employer_013',
  ),
  Job(
    jobId: 'j24',
    title: '종합 해충 관리',
    crop: '토마토',
    location: '김제시 부량면',
    areaHectares: 3.5,
    requiredEquipment: const ['천적 곤충', '모니터링 트랩'],
    scheduledDate: DateTime.now().add(const Duration(days: 6)),
    type: JobType.pestControl,
    distanceKm: 5.8,
    employerName: '부량 토마토농장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    createdBy: 'employer_016',
  ),

  // 울타리 설치
  Job(
    jobId: 'j25',
    title: '농장 울타리 수리',
    crop: '소',
    location: '김제시 금구면',
    areaHectares: 0.0,
    requiredEquipment: const ['철사', '기둥', '울타리 도구'],
    scheduledDate: DateTime.now().add(const Duration(days: 5)),
    type: JobType.fencing,
    distanceKm: 28.7,
    employerName: '금구 목장',
    status: JobStatus.available,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    createdBy: 'employer_017',
  ),
];

/// 작업 타입 라벨 함수
///
/// TODO::LUKA - 다국어 지원으로 교체
/// - Flutter의 intl 패키지 사용
/// - 다국어 리소스 파일 관리
String jobTypeLabel(JobType type) {
  switch (type) {
    case JobType.fruitPicking:
      return '과일 수확';
    case JobType.tractorMowing:
      return '트랙터 작업';
    case JobType.irrigationSetup:
      return '관개 시설';
    case JobType.planting:
      return '심기';
    case JobType.harvesting:
      return '수확';
    case JobType.soilPreparation:
      return '토양 준비';
    case JobType.pruning:
      return '가지치기';
    case JobType.fertilizing:
      return '비료 주기';
    case JobType.pestControl:
      return '해충 방제';
    case JobType.fencing:
      return '울타리 설치';
  }
}

/// 작업 상태 라벨 함수
///
/// TODO::LUKA - 다국어 지원으로 교체
String jobStatusLabel(JobStatus status) {
  switch (status) {
    case JobStatus.available:
      return '모집중';
    case JobStatus.applied:
      return '지원함';
    case JobStatus.interested:
      return '관심있음';
    case JobStatus.inProgress:
      return '진행중';
    case JobStatus.completed:
      return '완료';
    case JobStatus.cancelled:
      return '취소됨';
  }
}

/// 작업 상태 색상 함수
Color jobStatusColor(JobStatus status) {
  switch (status) {
    case JobStatus.available:
      return const Color(0xFF4CAF50); // 초록색
    case JobStatus.applied:
      return const Color(0xFF2196F3); // 파란색
    case JobStatus.interested:
      return const Color(0xFFFF9800); // 주황색
    case JobStatus.inProgress:
      return const Color(0xFF9C27B0); // 보라색
    case JobStatus.completed:
      return const Color(0xFF607D8B); // 회색
    case JobStatus.cancelled:
      return const Color(0xFFF44336); // 빨간색
  }
}

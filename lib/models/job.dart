/// 작업 모델
///
/// TODO::LUKA - Firebase Firestore 컬렉션 'jobs'와 매핑
/// - 문서 ID: jobId (자동 생성)
/// - 필드명: Firebase 규칙에 맞게 수정 필요
/// - 보안 규칙: 모든 사용자가 읽기 가능, 작성자만 수정 가능
/// - 인덱싱: location, type, status, scheduledDate 필드에 복합 인덱스 필요
enum JobType {
  fruitPicking, // 과일 수확
  tractorMowing, // 트랙터 작업
  irrigationSetup, // 관개 시설
  planting, // 심기
  harvesting, // 수확
  soilPreparation, // 토양 준비
  pruning, // 가지치기
  fertilizing, // 비료 주기
  pestControl, // 해충 방제
  fencing, // 울타리 설치
}

enum JobStatus {
  available, // 모집중
  applied, // 지원함
  interested, // 관심있음
  inProgress, // 진행중
  completed, // 완료
  cancelled, // 취소됨
}

class Job {
  final String jobId;
  final String title;
  final String crop;
  final String location;
  final double areaHectares;
  final List<String> requiredEquipment;
  final DateTime? scheduledDate;
  final JobType type;
  final double distanceKm;
  final String employerName;
  final JobStatus status;
  final String? description;
  final double? hourlyRate;
  final int? estimatedHours;
  final List<String>? images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy; // employer userId
  final Map<String, dynamic>? metadata;

  const Job({
    required this.jobId,
    required this.title,
    required this.crop,
    required this.location,
    required this.areaHectares,
    required this.requiredEquipment,
    this.scheduledDate,
    required this.type,
    required this.distanceKm,
    required this.employerName,
    this.status = JobStatus.available,
    this.description,
    this.hourlyRate,
    this.estimatedHours,
    this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.metadata,
  });

  /// Firebase에서 데이터를 가져올 때 사용
  factory Job.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Job(
      jobId: documentId,
      title: data['title'] ?? '',
      crop: data['crop'] ?? '',
      location: data['location'] ?? '',
      areaHectares: (data['areaHectares'] ?? 0.0).toDouble(),
      requiredEquipment: List<String>.from(data['requiredEquipment'] ?? []),
      scheduledDate: data['scheduledDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['scheduledDate'])
          : null,
      type: JobType.values.firstWhere(
        (e) => e.toString() == 'JobType.${data['type']}',
        orElse: () => JobType.fruitPicking,
      ),
      distanceKm: (data['distanceKm'] ?? 0.0).toDouble(),
      employerName: data['employerName'] ?? '',
      status: JobStatus.values.firstWhere(
        (e) => e.toString() == 'JobStatus.${data['status']}',
        orElse: () => JobStatus.available,
      ),
      description: data['description'],
      hourlyRate: data['hourlyRate']?.toDouble(),
      estimatedHours: data['estimatedHours'],
      images: data['images'] != null ? List<String>.from(data['images']) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(data['updatedAt'] ?? 0),
      createdBy: data['createdBy'] ?? '',
      metadata: data['metadata'] != null
          ? Map<String, dynamic>.from(data['metadata'])
          : null,
    );
  }

  /// Firebase에 데이터를 저장할 때 사용
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'crop': crop,
      'location': location,
      'areaHectares': areaHectares,
      'requiredEquipment': requiredEquipment,
      'scheduledDate': scheduledDate?.millisecondsSinceEpoch,
      'type': type.toString().split('.').last,
      'distanceKm': distanceKm,
      'employerName': employerName,
      'status': status.toString().split('.').last,
      'description': description,
      'hourlyRate': hourlyRate,
      'estimatedHours': estimatedHours,
      'images': images,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'metadata': metadata,
    };
  }

  /// 데이터 복사
  Job copyWith({
    String? jobId,
    String? title,
    String? crop,
    String? location,
    double? areaHectares,
    List<String>? requiredEquipment,
    DateTime? scheduledDate,
    JobType? type,
    double? distanceKm,
    String? employerName,
    JobStatus? status,
    String? description,
    double? hourlyRate,
    int? estimatedHours,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    Map<String, dynamic>? metadata,
  }) {
    return Job(
      jobId: jobId ?? this.jobId,
      title: title ?? this.title,
      crop: crop ?? this.crop,
      location: location ?? this.location,
      areaHectares: areaHectares ?? this.areaHectares,
      requiredEquipment: requiredEquipment ?? this.requiredEquipment,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      type: type ?? this.type,
      distanceKm: distanceKm ?? this.distanceKm,
      employerName: employerName ?? this.employerName,
      status: status ?? this.status,
      description: description ?? this.description,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// 알림 모델
///
/// TODO::LUKA - Firebase Firestore 컬렉션 'notifications'와 매핑
/// - 문서 ID: notificationId (자동 생성)
/// - 필드명: Firebase 규칙에 맞게 수정 필요
/// - 보안 규칙: 사용자는 자신의 알림만 읽기 가능
/// - 인덱싱: userId, isRead, createdAt 필드에 복합 인덱스 필요
enum NotificationType {
  announcement, // 공지사항
  job, // 작업 관련
  contract, // 계약 관련
  message, // 메시지
  system, // 시스템 알림
}

class NotificationItem {
  final String notificationId;
  final String userId;
  final String title;
  final String content;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final Map<String, dynamic>? data; // 추가 데이터 (링크, 액션 등)
  final String? imageUrl;

  const NotificationItem({
    required this.notificationId,
    required this.userId,
    required this.title,
    required this.content,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.readAt,
    this.data,
    this.imageUrl,
  });

  /// Firebase에서 데이터를 가져올 때 사용
  factory NotificationItem.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return NotificationItem(
      notificationId: documentId,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${data['type']}',
        orElse: () => NotificationType.system,
      ),
      isRead: data['isRead'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] ?? 0),
      readAt: data['readAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['readAt'])
          : null,
      data:
          data['data'] != null ? Map<String, dynamic>.from(data['data']) : null,
      imageUrl: data['imageUrl'],
    );
  }

  /// Firebase에 데이터를 저장할 때 사용
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'type': type.toString().split('.').last,
      'isRead': isRead,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'readAt': readAt?.millisecondsSinceEpoch,
      'data': data,
      'imageUrl': imageUrl,
    };
  }

  /// 데이터 복사
  NotificationItem copyWith({
    String? notificationId,
    String? userId,
    String? title,
    String? content,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    Map<String, dynamic>? data,
    String? imageUrl,
  }) {
    return NotificationItem(
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      data: data ?? this.data,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

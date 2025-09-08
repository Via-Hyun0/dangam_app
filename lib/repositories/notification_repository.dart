import '../models/notification.dart';

/// 알림 데이터 Repository 인터페이스
///
/// TODO::LUKA - Firebase 구현체로 교체
/// - Firestore로 알림 데이터 CRUD
/// - Cloud Functions로 알림 생성/발송
/// - FCM으로 푸시 알림 발송
/// - 보안 규칙: 사용자는 자신의 알림만 접근 가능
abstract class NotificationRepository {
  /// 사용자의 알림 목록 가져오기
  Future<List<NotificationItem>> getUserNotifications(String userId);

  /// 읽지 않은 알림 개수 가져오기
  Future<int> getUnreadCount(String userId);

  /// 알림을 읽음으로 표시
  Future<void> markAsRead(String notificationId);

  /// 모든 알림을 읽음으로 표시
  Future<void> markAllAsRead(String userId);

  /// 알림 생성
  Future<String> createNotification(NotificationItem notification);

  /// 알림 삭제
  Future<void> deleteNotification(String notificationId);

  /// 알림 타입별 필터링
  Future<List<NotificationItem>> getNotificationsByType(
    String userId,
    NotificationType type,
  );
}

/// 목업 알림 Repository 구현체
///
/// TODO::LUKA - Firebase 구현체로 교체
class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<NotificationItem>> getUserNotifications(String userId) async {
    // TODO::LUKA - Firestore에서 사용자 알림 가져오기
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .where('userId', isEqualTo: userId)
    //     .orderBy('createdAt', descending: true)
    //     .get();

    await Future.delayed(const Duration(milliseconds: 600));

    // 목업 알림 데이터
    return [
      NotificationItem(
        notificationId: 'notif_001',
        userId: userId,
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
        userId: userId,
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
        userId: userId,
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
        userId: userId,
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
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    // TODO::LUKA - Firestore에서 읽지 않은 알림 개수 가져오기
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .where('userId', isEqualTo: userId)
    //     .where('isRead', isEqualTo: false)
    //     .get();
    // return snapshot.docs.length;

    await Future.delayed(const Duration(milliseconds: 300));

    final notifications = await getUserNotifications(userId);
    return notifications.where((n) => !n.isRead).length;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    // TODO::LUKA - Firestore에서 알림을 읽음으로 표시
    // await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .doc(notificationId)
    //     .update({
    //       'isRead': true,
    //       'readAt': FieldValue.serverTimestamp(),
    //     });

    await Future.delayed(const Duration(milliseconds: 400));
    print('알림 읽음 처리됨: $notificationId');
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    // TODO::LUKA - Firestore에서 모든 알림을 읽음으로 표시
    // final batch = FirebaseFirestore.instance.batch();
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .where('userId', isEqualTo: userId)
    //     .where('isRead', isEqualTo: false)
    //     .get();

    // for (var doc in snapshot.docs) {
    //   batch.update(doc.reference, {
    //     'isRead': true,
    //     'readAt': FieldValue.serverTimestamp(),
    //   });
    // }
    // await batch.commit();

    await Future.delayed(const Duration(milliseconds: 800));
    print('모든 알림 읽음 처리됨: $userId');
  }

  @override
  Future<String> createNotification(NotificationItem notification) async {
    // TODO::LUKA - Firestore에 새 알림 생성
    // final docRef = await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .add(notification.toFirestore());
    // return docRef.id;

    await Future.delayed(const Duration(milliseconds: 600));

    final newNotificationId = 'notif_${DateTime.now().millisecondsSinceEpoch}';
    print('새 알림 생성됨: $newNotificationId');
    return newNotificationId;
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    // TODO::LUKA - Firestore에서 알림 삭제
    // await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .doc(notificationId)
    //     .delete();

    await Future.delayed(const Duration(milliseconds: 400));
    print('알림 삭제됨: $notificationId');
  }

  @override
  Future<List<NotificationItem>> getNotificationsByType(
    String userId,
    NotificationType type,
  ) async {
    // TODO::LUKA - Firestore에서 타입별 알림 검색
    // final snapshot = await FirebaseFirestore.instance
    //     .collection('notifications')
    //     .where('userId', isEqualTo: userId)
    //     .where('type', isEqualTo: type.toString().split('.').last)
    //     .orderBy('createdAt', descending: true)
    //     .get();

    await Future.delayed(const Duration(milliseconds: 500));

    final allNotifications = await getUserNotifications(userId);
    return allNotifications.where((n) => n.type == type).toList();
  }
}

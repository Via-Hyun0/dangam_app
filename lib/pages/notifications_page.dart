import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

/// 알림 페이지
///
/// 디자이너 가이드:
/// - 이 페이지는 모든 알림과 공지사항을 표시합니다
/// - 카테고리별로 필터링할 수 있습니다
/// - 읽음/읽지 않음 상태를 관리합니다
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _selectedFilter = 'all';
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: '2025 스마트팜 지원사업',
      content: 'IoT 센서와 자동화를 통한 농업 현대화를 위한 정부 지원금 신청하세요.',
      type: NotificationType.announcement,
      isRead: false,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    NotificationItem(
      id: '2',
      title: '농촌 일자리 인센티브 제도',
      content: '농촌 지역 일자리 참여 시 추가 인센티브를 받을 수 있습니다.',
      type: NotificationType.announcement,
      isRead: false,
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
    ),
    NotificationItem(
      id: '3',
      title: '새로운 작업 제안',
      content: '김제시 금구면에서 포도 수확 작업이 제안되었습니다.',
      type: NotificationType.job,
      isRead: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationItem(
      id: '4',
      title: '계약 상태 업데이트',
      content: '신청하신 작업의 계약이 승인되었습니다.',
      type: NotificationType.contract,
      isRead: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    NotificationItem(
      id: '5',
      title: '메시지 알림',
      content: '고용주로부터 새로운 메시지가 도착했습니다.',
      type: NotificationType.message,
      isRead: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];

  List<NotificationItem> get _filteredNotifications {
    if (_selectedFilter == 'all') {
      return _notifications;
    }
    return _notifications.where((notification) {
      return notification.type.toString().split('.').last == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '알림',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkAccent,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              '모두 읽음',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 필터 바
          _FilterBar(
            selectedFilter: _selectedFilter,
            onFilterChanged: (value) => setState(() => _selectedFilter = value),
          ),

          // 알림 목록
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      return _NotificationCard(
                        notification: notification,
                        onTap: () => _markAsRead(notification.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    });
  }
}

/// 필터 바 위젯
class _FilterBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterBar({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _FilterChip(
              label: '전체',
              isSelected: selectedFilter == 'all',
              onTap: () => onFilterChanged('all'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _FilterChip(
              label: '공지사항',
              isSelected: selectedFilter == 'announcement',
              onTap: () => onFilterChanged('announcement'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _FilterChip(
              label: '작업',
              isSelected: selectedFilter == 'job',
              onTap: () => onFilterChanged('job'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _FilterChip(
              label: '계약',
              isSelected: selectedFilter == 'contract',
              onTap: () => onFilterChanged('contract'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _FilterChip(
              label: '메시지',
              isSelected: selectedFilter == 'message',
              onTap: () => onFilterChanged('message'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 필터 칩 위젯
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.white : AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 알림 카드 위젯
class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: notification.isRead
                  ? AppColors.white
                  : AppColors.primaryLighter,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                color: notification.isRead
                    ? AppColors.divider
                    : AppColors.primaryLight,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 아이콘
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getNotificationColor(notification.type)
                        .withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                  child: Icon(
                    _getNotificationIcon(notification.type),
                    color: _getNotificationColor(notification.type),
                    size: AppSpacing.iconMedium,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: notification.isRead
                                    ? FontWeight.w600
                                    : FontWeight.w700,
                                color: AppColors.darkAccent,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        notification.content,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _formatTime(notification.timestamp),
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.announcement:
        return AppColors.info;
      case NotificationType.job:
        return AppColors.primary;
      case NotificationType.contract:
        return AppColors.success;
      case NotificationType.message:
        return AppColors.warning;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.announcement:
        return AppIcons.announcement;
      case NotificationType.job:
        return AppIcons.workOutline;
      case NotificationType.contract:
        return AppIcons.contract;
      case NotificationType.message:
        return AppIcons.message;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

/// 빈 상태 위젯
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.notifications,
            size: AppSpacing.iconHuge * 2,
            color: AppColors.grey,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '알림이 없습니다',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '새로운 알림이 오면 여기에 표시됩니다',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 알림 아이템 데이터 클래스
class NotificationItem {
  final String id;
  final String title;
  final String content;
  final NotificationType type;
  final bool isRead;
  final DateTime timestamp;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? content,
    NotificationType? type,
    bool? isRead,
    DateTime? timestamp,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// 알림 타입 열거형
enum NotificationType {
  announcement,
  job,
  contract,
  message,
}

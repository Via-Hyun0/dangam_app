import 'package:flutter/material.dart';

class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime publishedAt;
  final NoticeType type;
  final String? link;

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.type,
    this.link,
  });
}

enum NoticeType {
  support, // 지원사업
  policy, // 정책
  event, // 행사
  update, // 업데이트
}

String noticeTypeLabel(NoticeType type) {
  switch (type) {
    case NoticeType.support:
      return 'Support Program';
    case NoticeType.policy:
      return 'Policy';
    case NoticeType.event:
      return 'Event';
    case NoticeType.update:
      return 'Update';
  }
}

Color noticeTypeColor(NoticeType type) {
  switch (type) {
    case NoticeType.support:
      return Colors.green;
    case NoticeType.policy:
      return Colors.blue;
    case NoticeType.event:
      return Colors.orange;
    case NoticeType.update:
      return Colors.purple;
  }
}

final List<Notice> mockNotices = [
  Notice(
    id: 'n1',
    title: '2025 Smart Farming Support Program',
    content:
        'Apply for government funding to modernize your farming operations with IoT sensors and automation.',
    publishedAt: DateTime(2025, 1, 10),
    type: NoticeType.support,
    link: 'https://example.com/smart-farming-support',
  ),
  Notice(
    id: 'n2',
    title: 'New Safety Regulations for Farm Workers',
    content:
        'Updated safety guidelines for agricultural workers effective March 2025.',
    publishedAt: DateTime(2025, 1, 8),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n3',
    title: 'Agricultural Technology Expo 2025',
    content:
        'Join us at the annual expo showcasing the latest in farming technology and equipment.',
    publishedAt: DateTime(2025, 1, 5),
    type: NoticeType.event,
    link: 'https://example.com/agtech-expo-2025',
  ),
  Notice(
    id: 'n4',
    title: 'Platform Maintenance Scheduled',
    content:
        'Scheduled maintenance on January 15th from 2-4 AM. Some features may be temporarily unavailable.',
    publishedAt: DateTime(2025, 1, 3),
    type: NoticeType.update,
  ),
];


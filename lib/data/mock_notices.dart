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
      return '지원사업';
    case NoticeType.policy:
      return '정책';
    case NoticeType.event:
      return '행사';
    case NoticeType.update:
      return '업데이트';
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
  // 지원사업
  Notice(
    id: 'n1',
    title: '2025 스마트팜 지원사업',
    content: 'IoT 센서와 자동화를 통한 농업 현대화를 위한 정부 지원금 신청하세요.',
    publishedAt: DateTime.now().subtract(const Duration(days: 2)),
    type: NoticeType.support,
    link: 'https://example.com/smart-farming-support',
  ),
  Notice(
    id: 'n2',
    title: '농촌 일자리 인센티브 제도',
    content: '농촌 지역 계절근로자 고용에 대한 재정적 인센티브. 근로자당 최대 500만원.',
    publishedAt: DateTime.now().subtract(const Duration(days: 5)),
    type: NoticeType.support,
    link: 'https://example.com/rural-employment',
  ),
  Notice(
    id: 'n3',
    title: 'Sustainable Agriculture Grant',
    content:
        'Funding available for farmers implementing eco-friendly practices and renewable energy.',
    publishedAt: DateTime.now().subtract(const Duration(days: 7)),
    type: NoticeType.support,
    link: 'https://example.com/sustainable-agriculture',
  ),
  Notice(
    id: 'n4',
    title: 'Young Farmer Development Program',
    content:
        'Mentorship and financial support for farmers under 35 starting their agricultural business.',
    publishedAt: DateTime.now().subtract(const Duration(days: 10)),
    type: NoticeType.support,
    link: 'https://example.com/young-farmer-program',
  ),

  // Policy Updates
  Notice(
    id: 'n5',
    title: 'New Safety Regulations for Farm Workers',
    content:
        'Updated safety guidelines for agricultural workers effective March 2025.',
    publishedAt: DateTime.now().subtract(const Duration(days: 4)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n6',
    title: 'Minimum Wage Increase for Seasonal Workers',
    content:
        'New minimum wage rates for agricultural workers effective February 1st, 2025.',
    publishedAt: DateTime.now().subtract(const Duration(days: 6)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n7',
    title: 'Updated Pesticide Use Guidelines',
    content:
        'New regulations for pesticide application and worker safety protocols.',
    publishedAt: DateTime.now().subtract(const Duration(days: 8)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n8',
    title: 'Water Usage Restrictions Update',
    content:
        'Revised water allocation limits for agricultural use during dry season.',
    publishedAt: DateTime.now().subtract(const Duration(days: 12)),
    type: NoticeType.policy,
  ),

  // Events
  Notice(
    id: 'n9',
    title: 'Agricultural Technology Expo 2025',
    content:
        'Join us at the annual expo showcasing the latest in farming technology and equipment.',
    publishedAt: DateTime.now().subtract(const Duration(days: 3)),
    type: NoticeType.event,
    link: 'https://example.com/agtech-expo-2025',
  ),
  Notice(
    id: 'n10',
    title: 'Farm Safety Workshop Series',
    content:
        'Free workshops on farm safety, equipment operation, and emergency procedures.',
    publishedAt: DateTime.now().subtract(const Duration(days: 9)),
    type: NoticeType.event,
    link: 'https://example.com/farm-safety-workshop',
  ),
  Notice(
    id: 'n11',
    title: 'Organic Farming Conference',
    content:
        'Learn about organic farming techniques, certification, and market opportunities.',
    publishedAt: DateTime.now().subtract(const Duration(days: 11)),
    type: NoticeType.event,
    link: 'https://example.com/organic-farming-conference',
  ),
  Notice(
    id: 'n12',
    title: 'Rural Jobs Fair 2025',
    content:
        'Connect with employers and find seasonal work opportunities in rural areas.',
    publishedAt: DateTime.now().subtract(const Duration(days: 13)),
    type: NoticeType.event,
    link: 'https://example.com/rural-jobs-fair',
  ),

  // Platform Updates
  Notice(
    id: 'n13',
    title: 'Platform Maintenance Scheduled',
    content:
        'Scheduled maintenance on January 15th from 2-4 AM. Some features may be temporarily unavailable.',
    publishedAt: DateTime.now().subtract(const Duration(days: 1)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n14',
    title: 'New Mobile App Features',
    content:
        'Check out the latest updates: offline mode, push notifications, and improved job matching.',
    publishedAt: DateTime.now().subtract(const Duration(days: 14)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n15',
    title: 'Enhanced Job Search Filters',
    content:
        'New filtering options by distance, pay rate, and work duration now available.',
    publishedAt: DateTime.now().subtract(const Duration(days: 16)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n16',
    title: 'Payment System Upgrade',
    content:
        'Faster and more secure payment processing for completed contracts.',
    publishedAt: DateTime.now().subtract(const Duration(days: 18)),
    type: NoticeType.update,
  ),

  // Weather & Seasonal
  Notice(
    id: 'n17',
    title: 'Heat Wave Safety Alert',
    content:
        'Extreme heat conditions expected. Ensure adequate hydration and rest breaks for workers.',
    publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n18',
    title: 'Harvest Season Preparation',
    content:
        'Tips and resources for preparing your farm for the upcoming harvest season.',
    publishedAt: DateTime.now().subtract(const Duration(days: 20)),
    type: NoticeType.support,
  ),
];

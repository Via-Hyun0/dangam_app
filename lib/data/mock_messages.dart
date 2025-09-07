import 'package:flutter/material.dart';

class Chat {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String avatarUrl;
  final ChatType type;

  const Chat({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.avatarUrl = '',
    required this.type,
  });
}

enum ChatType {
  job, // 작업 관련 채팅
  support, // 지원사업 문의
  general, // 일반 문의
}

String chatTypeLabel(ChatType type) {
  switch (type) {
    case ChatType.job:
      return 'Job';
    case ChatType.support:
      return 'Support';
    case ChatType.general:
      return 'General';
  }
}

Color chatTypeColor(ChatType type) {
  switch (type) {
    case ChatType.job:
      return Colors.blue;
    case ChatType.support:
      return Colors.green;
    case ChatType.general:
      return Colors.grey;
  }
}

final List<Chat> mockChats = [
  // Job-related chats
  Chat(
    id: 'c1',
    title: 'Grape Harvesting - Barossa Valley',
    lastMessage: 'Thanks for your interest! When can you start?',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
    unreadCount: 2,
    type: ChatType.job,
  ),
  Chat(
    id: 'c2',
    title: 'Apple Orchard Maintenance',
    lastMessage: 'The equipment will be ready by tomorrow morning.',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
    unreadCount: 1,
    type: ChatType.job,
  ),
  Chat(
    id: 'c3',
    title: 'Wheat Planting - Murray Region',
    lastMessage: 'Weather looks good for next week. Are you still available?',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 3,
    type: ChatType.job,
  ),
  Chat(
    id: 'c4',
    title: 'Strawberry Harvest - Sunshine Coast',
    lastMessage: 'Great work yesterday! Same time tomorrow?',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
    unreadCount: 0,
    type: ChatType.job,
  ),
  Chat(
    id: 'c5',
    title: 'Tractor Mowing - Huon Valley',
    lastMessage: 'The field is ready. Please bring your own fuel.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
    unreadCount: 1,
    type: ChatType.job,
  ),
  Chat(
    id: 'c6',
    title: 'Irrigation Setup - Lockyer Valley',
    lastMessage: 'We need to reschedule due to rain forecast.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    unreadCount: 0,
    type: ChatType.job,
  ),
  Chat(
    id: 'c7',
    title: 'Cotton Picking - Moree Plains',
    lastMessage:
        'Payment has been processed. Thank you for the excellent work!',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
    unreadCount: 0,
    type: ChatType.job,
  ),
  Chat(
    id: 'c8',
    title: 'Soil Preparation - Darling Downs',
    lastMessage:
        'Can you start earlier than planned? We have good weather window.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 4)),
    unreadCount: 2,
    type: ChatType.job,
  ),

  // Support chats
  Chat(
    id: 'c9',
    title: 'Smart Farming Support Program',
    lastMessage: 'Your application has been approved. Next steps...',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    unreadCount: 0,
    type: ChatType.support,
  ),
  Chat(
    id: 'c10',
    title: 'Rural Employment Incentive',
    lastMessage: 'Please submit your worker documentation by Friday.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
    unreadCount: 1,
    type: ChatType.support,
  ),
  Chat(
    id: 'c11',
    title: 'Sustainable Agriculture Grant',
    lastMessage: 'We need additional information about your irrigation system.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3, hours: 3)),
    unreadCount: 0,
    type: ChatType.support,
  ),
  Chat(
    id: 'c12',
    title: 'Young Farmer Development',
    lastMessage:
        'Your mentor assignment is complete. Check your email for details.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 5)),
    unreadCount: 0,
    type: ChatType.support,
  ),

  // General support
  Chat(
    id: 'c13',
    title: 'Platform Support',
    lastMessage: 'We\'ve resolved the issue with your profile verification.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
    unreadCount: 0,
    type: ChatType.general,
  ),
  Chat(
    id: 'c14',
    title: 'Account Verification',
    lastMessage: 'Your identity documents have been verified successfully.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
    unreadCount: 0,
    type: ChatType.general,
  ),
  Chat(
    id: 'c15',
    title: 'Payment Inquiry',
    lastMessage:
        'Your payment has been processed and should appear in 2-3 business days.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 4, hours: 2)),
    unreadCount: 0,
    type: ChatType.general,
  ),
  Chat(
    id: 'c16',
    title: 'Safety Training',
    lastMessage:
        'Your safety certification has been updated. Valid for 2 years.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 6)),
    unreadCount: 1,
    type: ChatType.general,
  ),
  Chat(
    id: 'c17',
    title: 'App Feedback',
    lastMessage:
        'Thank you for your feedback! We\'re working on the suggested improvements.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 7, hours: 3)),
    unreadCount: 0,
    type: ChatType.general,
  ),
  Chat(
    id: 'c18',
    title: 'Weather Alerts',
    lastMessage:
        'Heat wave warning for your area. Stay hydrated and take frequent breaks.',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 6)),
    unreadCount: 1,
    type: ChatType.general,
  ),
];

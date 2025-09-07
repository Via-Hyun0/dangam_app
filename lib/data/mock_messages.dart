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
  Chat(
    id: 'c1',
    title: 'Grape Harvesting - Barossa Valley',
    lastMessage: 'Thanks for your interest! When can you start?',
    lastMessageTime: DateTime(2025, 1, 12, 14, 30),
    unreadCount: 2,
    type: ChatType.job,
  ),
  Chat(
    id: 'c2',
    title: 'Smart Farming Support Program',
    lastMessage: 'Your application has been approved. Next steps...',
    lastMessageTime: DateTime(2025, 1, 11, 9, 15),
    unreadCount: 0,
    type: ChatType.support,
  ),
  Chat(
    id: 'c3',
    title: 'Apple Orchard Maintenance',
    lastMessage: 'The equipment will be ready by tomorrow morning.',
    lastMessageTime: DateTime(2025, 1, 10, 16, 45),
    unreadCount: 1,
    type: ChatType.job,
  ),
  Chat(
    id: 'c4',
    title: 'Platform Support',
    lastMessage: 'We\'ve resolved the issue with your profile verification.',
    lastMessageTime: DateTime(2025, 1, 9, 11, 20),
    unreadCount: 0,
    type: ChatType.general,
  ),
  Chat(
    id: 'c5',
    title: 'Wheat Planting - Murray Region',
    lastMessage: 'Weather looks good for next week. Are you still available?',
    lastMessageTime: DateTime(2025, 1, 8, 13, 10),
    unreadCount: 3,
    type: ChatType.job,
  ),
];


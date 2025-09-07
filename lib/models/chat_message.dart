import 'package:flutter/material.dart';

class ChatMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isFromUser;
  final MessageType type;
  final ContractData? contractData;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isFromUser,
    required this.type,
    this.contractData,
  });
}

enum MessageType {
  text,           // 일반 텍스트
  contract,       // 계약 제안/수정
  system,         // 시스템 메시지
  image,          // 이미지
  file,           // 파일
}

class ContractData {
  final String jobTitle;
  final String jobDescription;
  final double hourlyRate;
  final int estimatedHours;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> requirements;
  final ContractStatus status;
  final String? notes;

  const ContractData({
    required this.jobTitle,
    required this.jobDescription,
    required this.hourlyRate,
    required this.estimatedHours,
    required this.startDate,
    required this.endDate,
    required this.requirements,
    required this.status,
    this.notes,
  });
}

enum ContractStatus {
  proposed,       // 제안됨
  accepted,       // 수락됨
  rejected,       // 거절됨
  modified,       // 수정됨
  pending,        // 대기중
  expired,        // 만료됨
}

String contractStatusLabel(ContractStatus status) {
  switch (status) {
    case ContractStatus.proposed:
      return '계약 제안';
    case ContractStatus.accepted:
      return '계약 수락';
    case ContractStatus.rejected:
      return '계약 거절';
    case ContractStatus.modified:
      return '계약 수정';
    case ContractStatus.pending:
      return '검토 중';
    case ContractStatus.expired:
      return '계약 만료';
  }
}

Color contractStatusColor(ContractStatus status) {
  switch (status) {
    case ContractStatus.proposed:
      return Colors.blue;
    case ContractStatus.accepted:
      return Colors.green;
    case ContractStatus.rejected:
      return Colors.red;
    case ContractStatus.modified:
      return Colors.orange;
    case ContractStatus.pending:
      return Colors.amber;
    case ContractStatus.expired:
      return Colors.grey;
  }
}

IconData contractStatusIcon(ContractStatus status) {
  switch (status) {
    case ContractStatus.proposed:
      return Icons.handshake_outlined;
    case ContractStatus.accepted:
      return Icons.check_circle_outline;
    case ContractStatus.rejected:
      return Icons.cancel_outlined;
    case ContractStatus.modified:
      return Icons.edit_outlined;
    case ContractStatus.pending:
      return Icons.schedule_outlined;
    case ContractStatus.expired:
      return Icons.access_time_outlined;
  }
}

import 'package:flutter/material.dart';

class Contract {
  final String id;
  final String jobId;
  final String workerId;
  final String employerId;
  final ContractStatus status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final String? message;
  final double? agreedRate;
  final String? notes;

  const Contract({
    required this.id,
    required this.jobId,
    required this.workerId,
    required this.employerId,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
    this.message,
    this.agreedRate,
    this.notes,
  });
}

enum ContractStatus {
  pending, // 대기중
  accepted, // 수락됨
  rejected, // 거절됨
  inProgress, // 진행중
  completed, // 완료됨
  cancelled, // 취소됨
}

String contractStatusLabel(ContractStatus status) {
  switch (status) {
    case ContractStatus.pending:
      return 'Pending';
    case ContractStatus.accepted:
      return 'Accepted';
    case ContractStatus.rejected:
      return 'Rejected';
    case ContractStatus.inProgress:
      return 'In Progress';
    case ContractStatus.completed:
      return 'Completed';
    case ContractStatus.cancelled:
      return 'Cancelled';
  }
}

Color contractStatusColor(ContractStatus status) {
  switch (status) {
    case ContractStatus.pending:
      return Colors.orange;
    case ContractStatus.accepted:
      return Colors.green;
    case ContractStatus.rejected:
      return Colors.red;
    case ContractStatus.inProgress:
      return Colors.blue;
    case ContractStatus.completed:
      return Colors.grey;
    case ContractStatus.cancelled:
      return Colors.red[300]!;
  }
}

class ContractResponse {
  final String contractId;
  final ContractStatus newStatus;
  final String? message;
  final double? counterOffer;

  const ContractResponse({
    required this.contractId,
    required this.newStatus,
    this.message,
    this.counterOffer,
  });
}


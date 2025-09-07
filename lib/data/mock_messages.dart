import 'package:flutter/material.dart';

class Chat {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String avatarUrl;
  final ChatType type;
  final MessageStatus status;
  final String employerName;
  final String jobTitle;

  const Chat({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.avatarUrl = '',
    required this.type,
    required this.status,
    required this.employerName,
    required this.jobTitle,
  });
}

enum ChatType {
  job, // 작업 관련 채팅
  support, // 지원사업 문의
  general, // 일반 문의
}

enum MessageStatus {
  requested,    // 요청함
  received,     // 요청받음
  accepted,     // 수락함
  rejected,     // 거절됨
  completed,    // 완료됨
  cancelled,    // 취소됨
  pending,      // 대기중
}

String chatTypeLabel(ChatType type) {
  switch (type) {
    case ChatType.job:
      return '작업';
    case ChatType.support:
      return '지원사업';
    case ChatType.general:
      return '일반';
  }
}

Color chatTypeColor(ChatType type) {
  switch (type) {
    case ChatType.job:
      return const Color(0xFFc75d31); // 단감 오렌지
    case ChatType.support:
      return const Color(0xFFa48e7b); // 브라운
    case ChatType.general:
      return const Color(0xFF503123); // 다크 액센트
  }
}

String messageStatusLabel(MessageStatus status) {
  switch (status) {
    case MessageStatus.requested:
      return '요청함';
    case MessageStatus.received:
      return '요청받음';
    case MessageStatus.accepted:
      return '수락함';
    case MessageStatus.rejected:
      return '거절됨';
    case MessageStatus.completed:
      return '완료됨';
    case MessageStatus.cancelled:
      return '취소됨';
    case MessageStatus.pending:
      return '대기중';
  }
}

Color messageStatusColor(MessageStatus status) {
  switch (status) {
    case MessageStatus.requested:
      return Colors.blue;
    case MessageStatus.received:
      return Colors.orange;
    case MessageStatus.accepted:
      return Colors.green;
    case MessageStatus.rejected:
      return Colors.red;
    case MessageStatus.completed:
      return const Color(0xFFa48e7b);
    case MessageStatus.cancelled:
      return Colors.grey;
    case MessageStatus.pending:
      return Colors.amber;
  }
}

IconData messageStatusIcon(MessageStatus status) {
  switch (status) {
    case MessageStatus.requested:
      return Icons.send_outlined;
    case MessageStatus.received:
      return Icons.inbox_outlined;
    case MessageStatus.accepted:
      return Icons.check_circle_outline;
    case MessageStatus.rejected:
      return Icons.cancel_outlined;
    case MessageStatus.completed:
      return Icons.task_alt_outlined;
    case MessageStatus.cancelled:
      return Icons.close_outlined;
    case MessageStatus.pending:
      return Icons.schedule_outlined;
  }
}

final List<Chat> mockChats = [
  // 작업 관련 채팅
  Chat(
    id: 'c1',
    title: '포도 수확 작업',
    lastMessage: '관심 가져주셔서 감사합니다! 언제부터 시작 가능하신가요?',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
    unreadCount: 2,
    type: ChatType.job,
    status: MessageStatus.received,
    employerName: '김제 포도농장',
    jobTitle: '포도 수확팀',
  ),
  Chat(
    id: 'c2',
    title: '사과 과수원 관리',
    lastMessage: '내일 아침까지 장비 준비 완료됩니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
    unreadCount: 1,
    type: ChatType.job,
    status: MessageStatus.accepted,
    employerName: '성덕 과수원',
    jobTitle: '사과 과수원 관리',
  ),
  Chat(
    id: 'c3',
    title: '밀 파종 작업',
    lastMessage: '다음 주 날씨가 좋아 보입니다. 아직 가능하신가요?',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 3,
    type: ChatType.job,
    status: MessageStatus.pending,
    employerName: '금구 농협',
    jobTitle: '밀 파종팀',
  ),
  Chat(
    id: 'c4',
    title: '딸기 수확 작업',
    lastMessage: '어제 작업 정말 잘해주셨습니다! 내일도 같은 시간에요?',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
    unreadCount: 0,
    type: ChatType.job,
    status: MessageStatus.completed,
    employerName: '김제 딸기농장',
    jobTitle: '딸기 수확팀',
  ),
  Chat(
    id: 'c5',
    title: '트랙터 잔디깎기',
    lastMessage: '밭 준비 완료되었습니다. 연료는 직접 준비해주세요.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
    unreadCount: 1,
    type: ChatType.job,
    status: MessageStatus.requested,
    employerName: '김제 농업기술센터',
    jobTitle: '트랙터 잔디깎기',
  ),
  Chat(
    id: 'c6',
    title: '관개 시설 설치',
    lastMessage: '비 예보로 인해 일정을 조정해야 합니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    unreadCount: 0,
    type: ChatType.job,
    status: MessageStatus.cancelled,
    employerName: '김제 관개시설',
    jobTitle: '관개 시설 설치',
  ),
  Chat(
    id: 'c7',
    title: '옥수수 수확',
    lastMessage: '급여가 처리되었습니다. 훌륭한 작업 감사합니다!',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
    unreadCount: 0,
    type: ChatType.job,
    status: MessageStatus.completed,
    employerName: '김제 옥수수농장',
    jobTitle: '옥수수 수확팀',
  ),
  Chat(
    id: 'c8',
    title: '토양 준비 작업',
    lastMessage: '예정보다 일찍 시작 가능하신가요? 날씨가 좋을 것 같습니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 4)),
    unreadCount: 2,
    type: ChatType.job,
    status: MessageStatus.received,
    employerName: '김제 토양관리',
    jobTitle: '토양 준비팀',
  ),

  // 지원사업 채팅
  Chat(
    id: 'c9',
    title: '스마트팜 지원사업',
    lastMessage: '신청이 승인되었습니다. 다음 단계는...',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    unreadCount: 0,
    type: ChatType.support,
    status: MessageStatus.accepted,
    employerName: '김제시 농업기술센터',
    jobTitle: '스마트팜 지원사업',
  ),
  Chat(
    id: 'c10',
    title: '농촌 일자리 지원',
    lastMessage: '금요일까지 근로자 서류를 제출해주세요.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
    unreadCount: 1,
    type: ChatType.support,
    status: MessageStatus.pending,
    employerName: '김제시청',
    jobTitle: '농촌 일자리 지원',
  ),
  Chat(
    id: 'c11',
    title: '친환경농업 지원금',
    lastMessage: '관개 시스템에 대한 추가 정보가 필요합니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3, hours: 3)),
    unreadCount: 0,
    type: ChatType.support,
    status: MessageStatus.received,
    employerName: '전북도청',
    jobTitle: '친환경농업 지원금',
  ),
  Chat(
    id: 'c12',
    title: '청년농업인 육성',
    lastMessage: '멘토 배정이 완료되었습니다. 이메일을 확인해주세요.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 5)),
    unreadCount: 0,
    type: ChatType.support,
    status: MessageStatus.completed,
    employerName: '농촌진흥청',
    jobTitle: '청년농업인 육성',
  ),

  // 일반 문의
  Chat(
    id: 'c13',
    title: '플랫폼 지원',
    lastMessage: '프로필 인증 문제를 해결했습니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
    unreadCount: 0,
    type: ChatType.general,
    status: MessageStatus.completed,
    employerName: '단감 고객지원',
    jobTitle: '플랫폼 지원',
  ),
  Chat(
    id: 'c14',
    title: '계정 인증',
    lastMessage: '신분증 서류가 성공적으로 인증되었습니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
    unreadCount: 0,
    type: ChatType.general,
    status: MessageStatus.completed,
    employerName: '단감 인증팀',
    jobTitle: '계정 인증',
  ),
  Chat(
    id: 'c15',
    title: '급여 문의',
    lastMessage: '급여가 처리되어 2-3 영업일 내에 입금될 예정입니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 4, hours: 2)),
    unreadCount: 0,
    type: ChatType.general,
    status: MessageStatus.completed,
    employerName: '단감 급여팀',
    jobTitle: '급여 문의',
  ),
  Chat(
    id: 'c16',
    title: '안전교육',
    lastMessage: '안전 인증서가 업데이트되었습니다. 2년간 유효합니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 6)),
    unreadCount: 1,
    type: ChatType.general,
    status: MessageStatus.pending,
    employerName: '김제 안전교육센터',
    jobTitle: '안전교육',
  ),
  Chat(
    id: 'c17',
    title: '앱 피드백',
    lastMessage: '피드백 감사합니다! 제안해주신 개선사항을 작업 중입니다.',
    lastMessageTime: DateTime.now().subtract(const Duration(days: 7, hours: 3)),
    unreadCount: 0,
    type: ChatType.general,
    status: MessageStatus.accepted,
    employerName: '단감 개발팀',
    jobTitle: '앱 피드백',
  ),
  Chat(
    id: 'c18',
    title: '날씨 알림',
    lastMessage: '지역 폭염 경보가 발령되었습니다. 수분 섭취와 휴식을 자주 취하세요.',
    lastMessageTime: DateTime.now().subtract(const Duration(hours: 6)),
    unreadCount: 1,
    type: ChatType.general,
    status: MessageStatus.pending,
    employerName: '기상청',
    jobTitle: '날씨 알림',
  ),
];

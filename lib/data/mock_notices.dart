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
    title: '친환경 농업 지원금',
    content:
        '친환경 농업 실천과 재생에너지 도입을 위한 농가 지원금 신청하세요.',
    publishedAt: DateTime.now().subtract(const Duration(days: 7)),
    type: NoticeType.support,
    link: 'https://example.com/sustainable-agriculture',
  ),
  Notice(
    id: 'n4',
    title: '청년농업인 육성 프로그램',
    content:
        '35세 미만 청년농업인을 위한 멘토링 및 창업 자금 지원 프로그램입니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 10)),
    type: NoticeType.support,
    link: 'https://example.com/young-farmer-program',
  ),

  // 정책 업데이트
  Notice(
    id: 'n5',
    title: '농업 근로자 안전 규정 신규 제정',
    content:
        '2025년 3월부터 시행되는 농업 근로자 안전 가이드라인이 업데이트되었습니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 4)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n6',
    title: '계절근로자 최저임금 인상',
    content:
        '2025년 2월 1일부터 농업 근로자 최저임금이 인상됩니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 6)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n7',
    title: '농약 사용 지침 개정',
    content:
        '농약 살포 및 근로자 안전 규정이 새롭게 개정되었습니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 8)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n8',
    title: '농업용수 사용 제한 업데이트',
    content:
        '건조기간 중 농업용수 배분 한도가 수정되었습니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 12)),
    type: NoticeType.policy,
  ),

  // 행사
  Notice(
    id: 'n9',
    title: '2025 농업기술 전시회',
    content:
        '최신 농업 기술과 장비를 선보이는 연례 전시회에 참여하세요.',
    publishedAt: DateTime.now().subtract(const Duration(days: 3)),
    type: NoticeType.event,
    link: 'https://example.com/agtech-expo-2025',
  ),
  Notice(
    id: 'n10',
    title: '농장 안전 워크숍 시리즈',
    content:
        '농장 안전, 장비 조작, 비상 절차에 대한 무료 워크숍을 개최합니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 9)),
    type: NoticeType.event,
    link: 'https://example.com/farm-safety-workshop',
  ),
  Notice(
    id: 'n11',
    title: '유기농업 컨퍼런스',
    content:
        '유기농업 기술, 인증, 시장 기회에 대해 알아보세요.',
    publishedAt: DateTime.now().subtract(const Duration(days: 11)),
    type: NoticeType.event,
    link: 'https://example.com/organic-farming-conference',
  ),
  Notice(
    id: 'n12',
    title: '2025 농촌 일자리 박람회',
    content:
        '고용주와 연결되고 농촌 지역 계절근로 기회를 찾아보세요.',
    publishedAt: DateTime.now().subtract(const Duration(days: 13)),
    type: NoticeType.event,
    link: 'https://example.com/rural-jobs-fair',
  ),

  // 플랫폼 업데이트
  Notice(
    id: 'n13',
    title: '플랫폼 정기 점검 예정',
    content:
        '1월 15일 새벽 2-4시 정기 점검으로 일부 기능이 일시적으로 이용 불가할 수 있습니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 1)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n14',
    title: '새로운 모바일 앱 기능',
    content:
        '최신 업데이트를 확인하세요: 오프라인 모드, 푸시 알림, 개선된 작업 매칭.',
    publishedAt: DateTime.now().subtract(const Duration(days: 14)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n15',
    title: '향상된 작업 검색 필터',
    content:
        '거리, 급여, 근무 기간별 새로운 필터링 옵션이 추가되었습니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 16)),
    type: NoticeType.update,
  ),
  Notice(
    id: 'n16',
    title: '결제 시스템 업그레이드',
    content:
        '완료된 계약에 대한 더 빠르고 안전한 결제 처리가 가능합니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 18)),
    type: NoticeType.update,
  ),

  // 날씨 및 계절
  Notice(
    id: 'n17',
    title: '폭염 안전 경보',
    content:
        '극한 고온이 예상됩니다. 근로자들의 충분한 수분 섭취와 휴식 시간을 보장하세요.',
    publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
    type: NoticeType.policy,
  ),
  Notice(
    id: 'n18',
    title: '수확철 준비',
    content:
        '다가오는 수확철을 위한 농장 준비 팁과 자료를 제공합니다.',
    publishedAt: DateTime.now().subtract(const Duration(days: 20)),
    type: NoticeType.support,
  ),
];

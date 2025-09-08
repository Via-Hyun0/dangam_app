import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_notices.dart';
import 'package:dangam_app/data/mock_jobs.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/pages/job_request_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header with stats
          _WelcomeHeader(),
          const SizedBox(height: AppSpacing.xl),

          // Quick actions
          const _SectionTitle('빠른 액션'),
          const SizedBox(height: AppSpacing.sm),
          const _QuickActionsSection(),
          const SizedBox(height: AppSpacing.xl),

          const _SectionTitle('공지사항'),
          const SizedBox(height: AppSpacing.sm),
          const _NoticesList(),
          const SizedBox(height: AppSpacing.xl),

          const _SectionTitle('진행중인 계약'),
          const SizedBox(height: AppSpacing.sm),
          _OngoingContractsList(),
          const SizedBox(height: AppSpacing.xl),

          const _SectionTitle('근처 작업 기회'),
          const SizedBox(height: AppSpacing.sm),
          const _HorizontalChipsCarousel(kind: _CarouselKind.opportunity),
          const SizedBox(height: AppSpacing.xl),

          const _SectionTitle('근처 제공자'),
          const SizedBox(height: AppSpacing.sm),
          const _HorizontalChipsCarousel(kind: _CarouselKind.provider),
        ],
      ),
    );
  }
}

/// 대시보드의 환영 헤더 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 사용자에게 환영 메시지와 주요 통계를 보여줍니다
/// - 그라데이션 배경과 카드 스타일을 사용합니다
/// - 통계 아이템들은 동일한 간격으로 배치됩니다
class _WelcomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryOverlay],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '안녕하세요!',
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '다음 농작업 기회를 찾아보세요!',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.whiteLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              const _StatItem(
                icon: Icons.assignment_turned_in,
                label: '진행중인 계약',
                value: '2',
                color: AppColors.white,
              ),
              const SizedBox(width: AppSpacing.lg),
              _StatItem(
                icon: Icons.work_outline,
                label: '가능한 작업',
                value: '${mockJobs.length}',
                color: AppColors.white,
              ),
              const SizedBox(width: AppSpacing.lg),
              const _StatItem(
                icon: Icons.location_on,
                label: '근처',
                value: '5',
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: AppSpacing.iconLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.titleLarge.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: color.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// 섹션 제목 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 각 섹션의 제목을 표시합니다
/// - 일관된 스타일을 위해 AppTypography를 사용합니다
/// - 색상은 AppColors.darkAccent를 사용합니다
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.titleLarge.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.darkAccent,
      ),
    );
  }
}

enum _CarouselKind { opportunity, provider }

class _OngoingContractsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    // Mock ongoing contracts data
    final List<Map<String, dynamic>> contracts = [
      {
        'title': '밀 수확 - 김제 농장',
        'status': '진행중',
        'daysLeft': 3,
        'progress': 0.7,
        'employer': '김제 농장',
        'type': '수확',
      },
      {
        'title': '토양 준비 - 곡성 농업',
        'status': '시작 대기',
        'daysLeft': 7,
        'progress': 0.0,
        'employer': '곡성 농업',
        'type': '토양 준비',
      },
    ];

    return Column(
      children: contracts.map((contract) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.assignment_turned_in_outlined,
                        color: primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contract['title'],
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkAccent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${contract['status']} • ${contract['daysLeft']}일 남음',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${contract['employer']} • ${contract['type']}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              if (contract['progress'] > 0) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: contract['progress'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(contract['progress'] * 100).round()}% 완료',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _NoticesList extends StatelessWidget {
  const _NoticesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mockNotices.take(3).map((notice) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: noticeTypeColor(notice.type),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: noticeTypeColor(notice.type)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            noticeTypeLabel(notice.type),
                            style: AppTypography.labelSmall.copyWith(
                              color: noticeTypeColor(notice.type),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(notice.publishedAt),
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notice.title,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkAccent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notice.content,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.secondary,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        );
      }).toList(),
    );
  }
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Yesterday';
  if (difference < 7) return '${difference}d ago';
  return '${date.month}/${date.day}';
}

class _HorizontalChipsCarousel extends StatelessWidget {
  final _CarouselKind kind;
  const _HorizontalChipsCarousel({required this.kind});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    // Get relevant jobs for opportunities, mock providers for providers
    final List<dynamic> items = kind == _CarouselKind.opportunity
        ? mockJobs.take(6).toList()
        : _getMockProviders();

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final bool alt = index.isOdd;

          return Container(
            width: 220,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: alt ? Colors.black : primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        kind == _CarouselKind.opportunity
                            ? Icons.work_outline
                            : Icons.person_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        kind == _CarouselKind.opportunity
                            ? jobTypeLabel(item.type)
                            : item['type'],
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  kind == _CarouselKind.opportunity ? item.title : item['name'],
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  kind == _CarouselKind.opportunity
                      ? '${item.location} • ${item.distanceKm.toStringAsFixed(1)} km'
                      : '${item['location']} • ${item['rating']}★',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (kind == _CarouselKind.opportunity &&
                    item.scheduledDate != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '마감: ${_formatJobDate(item.scheduledDate!)}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getMockProviders() {
    return [
      {
        'name': 'Greenfield Farm Services',
        'type': 'Harvesting',
        'location': 'North Valley',
        'rating': '4.8',
      },
      {
        'name': 'Valley Agriculture Co.',
        'type': 'Soil Preparation',
        'location': 'East Hills',
        'rating': '4.6',
      },
      {
        'name': 'Mountain Crop Care',
        'type': 'Planting',
        'location': 'West Range',
        'rating': '4.9',
      },
      {
        'name': 'River Farm Solutions',
        'type': 'Irrigation',
        'location': 'South Plains',
        'rating': '4.7',
      },
      {
        'name': 'Hilltop Harvesting',
        'type': 'Harvesting',
        'location': 'Central Valley',
        'rating': '4.5',
      },
      {
        'name': 'Sunrise Agriculture',
        'type': 'Planting',
        'location': 'North Ridge',
        'rating': '4.8',
      },
    ];
  }
}

String _formatJobDate(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Tomorrow';
  if (difference < 7) return 'In $difference days';
  return '${date.month}/${date.day}';
}

/// 빠른 액션 섹션 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 사용자가 자주 사용하는 기능들에 빠르게 접근할 수 있게 해줍니다
/// - 새로운 작업 요청, 작업 검색, 프로필 편집 등의 기능을 포함합니다
class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: AppIcons.add,
                  title: '새 작업 요청',
                  subtitle: '작업을 등록하세요',
                  color: AppColors.primary,
                  onTap: () => _navigateToJobRequest(context),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _QuickActionButton(
                  icon: AppIcons.search,
                  title: '작업 검색',
                  subtitle: '작업을 찾아보세요',
                  color: AppColors.info,
                  onTap: () => _navigateToJobs(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: AppIcons.locationOutline,
                  title: '위치 설정',
                  subtitle: '근무 지역을 설정하세요',
                  color: AppColors.success,
                  onTap: () => _navigateToLocationSettings(context),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _QuickActionButton(
                  icon: AppIcons.userOutline,
                  title: '프로필 편집',
                  subtitle: '프로필을 업데이트하세요',
                  color: AppColors.warning,
                  onTap: () => _navigateToProfile(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToJobRequest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const JobRequestPage(),
      ),
    );
  }

  void _navigateToJobs(BuildContext context) {
    // TODO: 작업 탭으로 이동하는 로직
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '작업 탭으로 이동합니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _navigateToLocationSettings(BuildContext context) {
    // TODO: 위치 설정 페이지로 이동하는 로직
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '위치 설정 페이지로 이동합니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    // TODO: 프로필 편집 페이지로 이동하는 로직
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '프로필 편집 페이지로 이동합니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.warning,
      ),
    );
  }
}

/// 빠른 액션 버튼 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 개별 빠른 액션을 표시합니다
/// - 아이콘, 제목, 부제목을 포함합니다
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: AppSpacing.iconLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Removed _TrustPillarsRow (not used currently)

// Removed _PillarCard (not used)

// Removed _ActionCard (replaced by recommendations carousel)

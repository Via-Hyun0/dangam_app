import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_jobs.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/pages/job_detail_page.dart';
import 'package:dangam_app/pages/job_request_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

/// 작업 목록 페이지
///
/// 디자이너 가이드:
/// - 이 페이지는 모든 작업 목록을 표시합니다
/// - 필터링과 정렬 기능을 제공합니다
/// - 각 작업 카드는 일관된 디자인을 사용합니다
class JobsBody extends StatefulWidget {
  const JobsBody({super.key});

  @override
  State<JobsBody> createState() => _JobsBodyState();
}

class _JobsBodyState extends State<JobsBody> {
  String _sortBy = 'distance'; // distance, date, type
  String _filterType = 'all'; // all, harvesting, planting, etc.

  List<Job> get _filteredJobs {
    List<Job> jobs = List.from(mockJobs);

    // Filter by type
    if (_filterType != 'all') {
      jobs = jobs
          .where((job) => job.type.toString().split('.').last == _filterType)
          .toList();
    }

    // Sort
    switch (_sortBy) {
      case 'distance':
        jobs.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case 'date':
        jobs.sort((a, b) {
          if (a.scheduledDate == null && b.scheduledDate == null) return 0;
          if (a.scheduledDate == null) return 1;
          if (b.scheduledDate == null) return -1;
          return a.scheduledDate!.compareTo(b.scheduledDate!);
        });
        break;
      case 'type':
        jobs.sort((a, b) => a.type.toString().compareTo(b.type.toString()));
        break;
    }

    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter and Sort Bar
        _FilterSortBar(
          sortBy: _sortBy,
          filterType: _filterType,
          onSortChanged: (value) => setState(() => _sortBy = value),
          onFilterChanged: (value) => setState(() => _filterType = value),
        ),
        // Jobs List
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemBuilder: (context, index) {
                  final Job job = _filteredJobs[index];
                  return _JobCard(job: job);
                },
                itemCount: _filteredJobs.length,
              ),
              // Floating Action Button
              Positioned(
                bottom: AppSpacing.lg,
                right: AppSpacing.lg,
                child: FloatingActionButton(
                  onPressed: () => _navigateToJobRequest(context),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 8,
                  child: const Icon(
                    AppIcons.add,
                    size: AppSpacing.iconLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToJobRequest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const JobRequestPage(),
      ),
    );
  }
}

/// 필터 및 정렬 바 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업 목록의 필터링과 정렬을 담당합니다
/// - 드롭다운 메뉴를 사용하여 사용자 선택을 받습니다
/// - 일관된 스타일을 위해 AppColors와 AppSpacing을 사용합니다
class _FilterSortBar extends StatelessWidget {
  final String sortBy;
  final String filterType;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onFilterChanged;

  const _FilterSortBar({
    required this.sortBy,
    required this.filterType,
    required this.onSortChanged,
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
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          // Filter dropdown
          Expanded(
            child: _DropdownContainer(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: filterType,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: 'all',
                      child: Text(
                        '모든 유형',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.darkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...JobType.values.map((type) => DropdownMenuItem(
                          value: type.toString().split('.').last,
                          child: Text(
                            jobTypeLabel(type),
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.darkAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ],
                  onChanged: (value) => onFilterChanged(value!),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Sort dropdown
          Expanded(
            child: _DropdownContainer(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: sortBy,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'distance',
                      child: Text(
                        '거리',
                        style: TextStyle(
                          color: AppColors.darkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'date',
                      child: Text(
                        '날짜',
                        style: TextStyle(
                          color: AppColors.darkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'type',
                      child: Text(
                        '유형',
                        style: TextStyle(
                          color: AppColors.darkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) => onSortChanged(value!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 드롭다운 컨테이너 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 드롭다운 메뉴의 공통 스타일을 제공합니다
/// - 일관된 패딩, 색상, 테두리를 사용합니다
class _DropdownContainer extends StatelessWidget {
  final Widget child;

  const _DropdownContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

/// 작업 카드 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 개별 작업을 카드 형태로 표시합니다
/// - 작업의 모든 중요한 정보를 포함합니다
/// - 클릭 시 상세 페이지로 이동합니다
class _JobCard extends StatelessWidget {
  final Job job;

  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
            );
          },
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                color: AppColors.primaryLighter,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and status
                  _JobHeader(job: job),

                  const SizedBox(height: AppSpacing.lg),

                  // Key information
                  _JobInfoRow(job: job),

                  const SizedBox(height: AppSpacing.lg),

                  // Location
                  _JobLocation(job: job),

                  // Equipment tags (only if not empty)
                  if (job.requiredEquipment.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    _EquipmentTags(equipment: job.requiredEquipment),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 작업 헤더 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 제목, 유형, 상태를 표시합니다
/// - 거리 정보도 함께 표시합니다
class _JobHeader extends StatelessWidget {
  final Job job;

  const _JobHeader({required this.job});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkAccent,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Text(
                    jobTypeLabel(job.type),
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _StatusBadge(status: job.status),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        _DistanceBadge(distance: job.distanceKm),
      ],
    );
  }
}

/// 상태 배지 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 상태를 배지 형태로 표시합니다
/// - 상태에 따라 다른 색상을 사용합니다
class _StatusBadge extends StatelessWidget {
  final JobStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: AppColors.successMuted,
          width: 1,
        ),
      ),
      child: Text(
        jobStatusLabel(status),
        style: AppTypography.labelSmall.copyWith(
          color: jobStatusColor(status),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 거리 배지 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업까지의 거리를 표시합니다
/// - 중요한 정보이므로 눈에 띄는 스타일을 사용합니다
class _DistanceBadge extends StatelessWidget {
  final double distance;

  const _DistanceBadge({required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLighter,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.primary,
            size: AppSpacing.iconSmall,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${distance.toStringAsFixed(1)}km',
            style: AppTypography.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 작업 정보 행 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 주요 정보를 가로로 배치합니다
/// - 작물, 면적, 날짜 정보를 포함합니다
class _JobInfoRow extends StatelessWidget {
  final Job job;

  const _JobInfoRow({required this.job});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoItem(
            icon: Icons.agriculture_outlined,
            label: '작물',
            value: job.crop,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: _InfoItem(
            icon: Icons.straighten_outlined,
            label: '면적',
            value: '${job.areaHectares.toStringAsFixed(1)} ha',
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: _InfoItem(
            icon: Icons.calendar_today_outlined,
            label: '날짜',
            value: job.scheduledDate != null
                ? _formatDate(job.scheduledDate!)
                : '미정',
          ),
        ),
      ],
    );
  }
}

/// 작업 위치 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 위치 정보를 표시합니다
/// - 아이콘과 텍스트를 함께 표시합니다
class _JobLocation extends StatelessWidget {
  final Job job;

  const _JobLocation({required this.job});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.place_outlined,
          color: AppColors.secondary,
          size: AppSpacing.iconMedium,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            job.location,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// 장비 태그 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 필요한 장비를 태그 형태로 표시합니다
/// - 여러 태그를 가로로 배치합니다
class _EquipmentTags extends StatelessWidget {
  final List<String> equipment;

  const _EquipmentTags({required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: equipment
          .map((item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLighter,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                child: Text(
                  item,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

/// 정보 아이템 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 아이콘, 라벨, 값을 세로로 배치합니다
/// - 일관된 스타일을 사용합니다
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.secondary,
              size: AppSpacing.iconSmall,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.darkAccent,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// 날짜 포맷팅 함수
String _formatDate(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

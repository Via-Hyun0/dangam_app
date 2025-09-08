import 'package:flutter/material.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

class JobDetailPage extends StatelessWidget {
  final Job job;
  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '작업 상세',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 작업 제목
            Text(
              job.title,
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.darkAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 작업 정보 칩들
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _InfoChip(
                  icon: AppIcons.workOutline,
                  label: jobTypeLabel(job.type),
                  color: AppColors.primary,
                ),
                _InfoChip(
                  icon: AppIcons.agriculture,
                  label: job.crop,
                  color: AppColors.success,
                ),
                _InfoChip(
                  icon: Icons.straighten_outlined,
                  label: '${job.areaHectares.toStringAsFixed(1)} ha',
                  color: AppColors.warning,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // 위치 정보
            _DetailSection(
              icon: AppIcons.location,
              title: '위치',
              content:
                  '${job.location} • ${job.distanceKm.toStringAsFixed(1)} km',
            ),

            // 예정 날짜
            if (job.scheduledDate != null) ...[
              const SizedBox(height: AppSpacing.lg),
              _DetailSection(
                icon: AppIcons.calendar,
                title: '예정 날짜',
                content: _formatDate(job.scheduledDate!),
              ),
            ],

            // 고용주 정보
            const SizedBox(height: AppSpacing.lg),
            _DetailSection(
              icon: AppIcons.user,
              title: '고용주',
              content: job.employerName,
            ),

            // 필요한 장비
            const SizedBox(height: AppSpacing.lg),
            Text(
              '필요한 장비',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.darkAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (job.requiredEquipment.isEmpty)
              Text(
                '지정되지 않음',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: job.requiredEquipment
                    .map((equipment) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xs,
                            horizontal: AppSpacing.md,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLighter,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusLarge),
                          ),
                          child: Text(
                            equipment,
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ))
                    .toList(),
              ),

            const SizedBox(height: AppSpacing.xl * 2),

            // 액션 버튼들
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showContractDialog(context, job, false),
                    icon: const Icon(AppIcons.close),
                    label: const Text('관심 없음'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showContractDialog(context, job, true),
                    icon: const Icon(AppIcons.check),
                    label: const Text('관심 표현'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 정보 칩 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 주요 정보를 칩 형태로 표시합니다
/// - 아이콘과 라벨을 포함하며, 색상으로 구분합니다
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppSpacing.iconSmall,
            color: color,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 상세 정보 섹션 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 작업의 상세 정보를 표시합니다
/// - 아이콘, 제목, 내용을 포함합니다
class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _DetailSection({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  content,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.darkAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

void _showContractDialog(BuildContext context, Job job, bool isInterested) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(
        isInterested ? '관심 표현하기' : '관심 없음',
        style: AppTypography.titleLarge.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.darkAccent,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isInterested
                ? '${job.employerName}에게 이 작업에 대한 메시지를 보내시겠습니까?'
                : '이 작업에 관심이 없다고 표시하시겠습니까?',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isInterested) ...[
            const SizedBox(height: AppSpacing.lg),
            TextField(
              decoration: InputDecoration(
                labelText: '메시지 (선택사항)',
                hintText: '관심을 표현하는 이유를 알려주세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                filled: true,
                fillColor: AppColors.background,
              ),
              maxLines: 3,
              style: AppTypography.bodyMedium,
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            '취소',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _showSuccessMessage(context, isInterested);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isInterested ? AppColors.primary : AppColors.error,
            foregroundColor: AppColors.white,
          ),
          child: Text(
            isInterested ? '관심 전달' : '확인',
            style: AppTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

void _showSuccessMessage(BuildContext context, bool isInterested) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isInterested
            ? '관심이 전달되었습니다! 업데이트 알림을 받으실 수 있습니다.'
            : '확인되었습니다. 비슷한 기회를 추천해드리겠습니다.',
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isInterested ? AppColors.success : AppColors.warning,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
    ),
  );
}

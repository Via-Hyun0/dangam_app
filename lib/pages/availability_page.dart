import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({super.key});

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  late final Map<String, List<bool>> _weeklyAvailability;

  @override
  void initState() {
    super.initState();
    _weeklyAvailability = {
      '월': [false, false, false, false, false, false, false, false],
      '화': [false, false, false, false, false, false, false, false],
      '수': [false, false, false, false, false, false, false, false],
      '목': [false, false, false, false, false, false, false, false],
      '금': [false, false, false, false, false, false, false, false],
      '토': [false, false, false, false, false, false, false, false],
      '일': [false, false, false, false, false, false, false, false],
    };
  }

  final List<String> _timeSlots = [
    '06:00',
    '08:00',
    '10:00',
    '12:00',
    '14:00',
    '16:00',
    '18:00',
    '20:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('가능 시간'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveAvailability,
            child: Text(
              '저장',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 안내 메시지
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                border: Border.all(
                  color: AppColors.primaryLightest,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    AppIcons.infoOutline,
                    color: AppColors.primary,
                    size: AppSpacing.iconLarge,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      '근무 가능한 시간을 선택하세요. 고용주가 이 정보를 보고 작업을 제안할 수 있습니다.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.darkAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // 시간표
            _buildAvailabilityTable(),

            const SizedBox(height: AppSpacing.xl),

            // 빠른 설정
            _buildQuickSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityTable() {
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
          // 헤더
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  '요일',
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkAccent,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: _timeSlots
                      .map((time) => Expanded(
                            child: Text(
                              time,
                              textAlign: TextAlign.center,
                              style: AppTypography.labelSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkAccent,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // 요일별 시간 선택
          ..._weeklyAvailability.entries
              .map((entry) => _buildDayRow(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildDayRow(String day, List<bool> availability) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              day,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkAccent,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: availability.asMap().entries.map((entry) {
                final index = entry.key;
                final isAvailable = entry.value;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleAvailability(day, index),
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                      height: AppSpacing.iconHuge,
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? AppColors.primary
                            : AppColors.background,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                        border: Border.all(
                          color: isAvailable
                              ? AppColors.primary
                              : AppColors.divider,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isAvailable ? AppIcons.check : AppIcons.close,
                        color: isAvailable ? AppColors.white : AppColors.grey,
                        size: AppSpacing.iconSmall,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSettings() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '빠른 설정',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.darkAccent,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildQuickSettingButton(
            title: '평일 오전 (08:00-12:00)',
            onTap: () => _setWeekdayMorning(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildQuickSettingButton(
            title: '평일 오후 (14:00-18:00)',
            onTap: () => _setWeekdayAfternoon(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildQuickSettingButton(
            title: '주말 전체',
            onTap: () => _setWeekend(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildQuickSettingButton(
            title: '전체 선택',
            onTap: () => _selectAll(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildQuickSettingButton(
            title: '전체 해제',
            onTap: () => _clearAll(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSettingButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primaryLightest),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
        child: Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _toggleAvailability(String day, int timeIndex) {
    setState(() {
      _weeklyAvailability[day]![timeIndex] =
          !_weeklyAvailability[day]![timeIndex];
    });
  }

  void _setWeekdayMorning() {
    setState(() {
      for (int day = 0; day < 5; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        _weeklyAvailability[dayName]![1] = true; // 08:00
        _weeklyAvailability[dayName]![2] = true; // 10:00
      }
    });
  }

  void _setWeekdayAfternoon() {
    setState(() {
      for (int day = 0; day < 5; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        _weeklyAvailability[dayName]![3] = true; // 12:00
        _weeklyAvailability[dayName]![4] = true; // 14:00
        _weeklyAvailability[dayName]![5] = true; // 16:00
      }
    });
  }

  void _setWeekend() {
    setState(() {
      for (int day = 5; day < 7; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        for (int i = 0; i < _weeklyAvailability[dayName]!.length; i++) {
          _weeklyAvailability[dayName]![i] = true;
        }
      }
    });
  }

  void _selectAll() {
    setState(() {
      for (String day in _weeklyAvailability.keys) {
        for (int i = 0; i < _weeklyAvailability[day]!.length; i++) {
          _weeklyAvailability[day]![i] = true;
        }
      }
    });
  }

  void _clearAll() {
    setState(() {
      for (String day in _weeklyAvailability.keys) {
        for (int i = 0; i < _weeklyAvailability[day]!.length; i++) {
          _weeklyAvailability[day]![i] = false;
        }
      }
    });
  }

  void _saveAvailability() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '가능 시간이 저장되었습니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.of(context).pop();
  }
}

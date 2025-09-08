import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/data/mock_jobs.dart';

/// 새로운 작업 요청 등록 페이지
///
/// 디자이너 가이드:
/// - 이 페이지는 사용자가 새로운 작업을 요청할 수 있는 폼입니다
/// - 작업 타입, 위치, 일정, 요구사항 등을 입력할 수 있습니다
/// - 단계별 입력 프로세스로 사용자 경험을 개선합니다
class JobRequestPage extends StatefulWidget {
  const JobRequestPage({super.key});

  @override
  State<JobRequestPage> createState() => _JobRequestPageState();
}

class _JobRequestPageState extends State<JobRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _cropController = TextEditingController();
  final _locationController = TextEditingController();
  final _areaController = TextEditingController();
  final _equipmentController = TextEditingController();
  final _descriptionController = TextEditingController();

  JobType _selectedJobType = JobType.fruitPicking;
  DateTime? _selectedDate;
  int _estimatedDuration = 1; // 시간 단위

  @override
  void dispose() {
    _titleController.dispose();
    _cropController.dispose();
    _locationController.dispose();
    _areaController.dispose();
    _equipmentController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '새 작업 요청',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.darkAccent,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.lg,
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text(
              '임시저장',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 안내 메시지
              _buildInfoCard(),

              const SizedBox(height: AppSpacing.xl),

              // 기본 정보 섹션
              _buildSection(
                title: '기본 정보',
                icon: AppIcons.infoOutline,
                children: [
                  _buildTextField(
                    controller: _titleController,
                    label: '작업 제목',
                    hint: '예: 포도 수확팀 모집',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '작업 제목을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTextField(
                    controller: _cropController,
                    label: '작물 종류',
                    hint: '예: 포도, 사과, 딸기',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '작물 종류를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildJobTypeDropdown(),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // 위치 및 규모 섹션
              _buildSection(
                title: '위치 및 규모',
                icon: AppIcons.locationOutline,
                children: [
                  _buildTextField(
                    controller: _locationController,
                    label: '작업 위치',
                    hint: '예: 김제시 금구면',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '작업 위치를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTextField(
                    controller: _areaController,
                    label: '면적 (헥타르)',
                    hint: '예: 3.2',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '면적을 입력해주세요';
                      }
                      if (double.tryParse(value) == null) {
                        return '올바른 숫자를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // 일정 및 요구사항 섹션
              _buildSection(
                title: '일정 및 요구사항',
                icon: AppIcons.scheduleOutline,
                children: [
                  _buildDatePicker(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildDurationSlider(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTextField(
                    controller: _equipmentController,
                    label: '필요 장비',
                    hint: '예: 수확 바구니, 가위, 사다리',
                    maxLines: 2,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // 상세 설명 섹션
              _buildSection(
                title: '상세 설명',
                icon: AppIcons.description,
                children: [
                  _buildTextField(
                    controller: _descriptionController,
                    label: '작업 상세 설명',
                    hint: '작업에 대한 자세한 설명을 입력해주세요',
                    maxLines: 4,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // 제출 버튼
              _buildSubmitButton(),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLighter,
            AppColors.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryLighter,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            AppIcons.lightbulbOutline,
            color: AppColors.primary,
            size: AppSpacing.iconLarge,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              '작업 요청을 등록하면 근로자들이 지원할 수 있습니다. 정확한 정보를 입력해주세요.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.darkAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
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
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: AppSpacing.iconMedium,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkAccent,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }

  Widget _buildJobTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '작업 타입',
          style: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkAccent,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<JobType>(
          value: _selectedJobType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
          items: JobType.values.map((type) {
            return DropdownMenuItem<JobType>(
              value: type,
              child: Text(jobTypeLabel(type)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedJobType = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '작업 일정',
          style: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkAccent,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Row(
              children: [
                const Icon(
                  AppIcons.calendarToday,
                  color: AppColors.primary,
                  size: AppSpacing.iconMedium,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.year}년 ${_selectedDate!.month}월 ${_selectedDate!.day}일'
                      : '작업 일정을 선택하세요',
                  style: AppTypography.bodyMedium.copyWith(
                    color: _selectedDate != null
                        ? AppColors.darkAccent
                        : AppColors.grey,
                  ),
                ),
                const Spacer(),
                const Icon(
                  AppIcons.chevronRight,
                  color: AppColors.grey,
                  size: AppSpacing.iconSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '예상 소요 시간: $_estimatedDuration시간',
          style: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkAccent,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Slider(
          value: _estimatedDuration.toDouble(),
          min: 1,
          max: 12,
          divisions: 11,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.primaryLightest,
          onChanged: (value) {
            setState(() {
              _estimatedDuration = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitJobRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
        ),
        child: Text(
          '작업 요청 등록',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.darkAccent,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '임시저장되었습니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _submitJobRequest() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      // TODO::LUKA - Firebase에 작업 요청 저장
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '작업 요청이 등록되었습니다',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pop();
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '작업 일정을 선택해주세요',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

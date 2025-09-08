import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';

class VerificationPage extends StatefulWidget {
  final bool isVerified;
  final Function(bool) onVerificationUpdated;

  const VerificationPage({
    super.key,
    required this.isVerified,
    required this.onVerificationUpdated,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool _idVerified = false;
  bool _phoneVerified = false;
  bool _skillVerified = false;
  bool _backgroundCheckVerified = false;

  @override
  void initState() {
    super.initState();
    _idVerified = widget.isVerified;
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '인증 관리',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkAccent,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // 인증 상태 요약
            _buildVerificationSummary(primary),

            const SizedBox(height: AppSpacing.xl),

            // 신분증 인증
            _buildVerificationCard(
              title: '신분증 인증',
              description: '주민등록증, 운전면허증, 여권 등',
              icon: Icons.credit_card_outlined,
              isVerified: _idVerified,
              onTap: () => _showIdVerificationDialog(),
            ),

            const SizedBox(height: AppSpacing.md),

            // 전화번호 인증
            _buildVerificationCard(
              title: '전화번호 인증',
              description: 'SMS 인증을 통한 전화번호 확인',
              icon: Icons.phone_outlined,
              isVerified: _phoneVerified,
              onTap: () => _showPhoneVerificationDialog(),
            ),

            const SizedBox(height: AppSpacing.md),

            // 기술 인증
            _buildVerificationCard(
              title: '기술 인증',
              description: '농업 기술 자격증, 경력 증명서',
              icon: Icons.verified_outlined,
              isVerified: _skillVerified,
              onTap: () => _showSkillVerificationDialog(),
            ),

            const SizedBox(height: AppSpacing.md),

            // 신원 조회
            _buildVerificationCard(
              title: '신원 조회',
              description: '범죄 경력 조회 및 신원 확인',
              icon: Icons.security_outlined,
              isVerified: _backgroundCheckVerified,
              onTap: () => _showBackgroundCheckDialog(),
            ),

            const SizedBox(height: 32),

            // 인증 혜택 안내
            _buildBenefitsCard(primary),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationSummary(Color primary) {
    const int totalCount = 4;
    final int verifiedCount = [
      _idVerified,
      _phoneVerified,
      _skillVerified,
      _backgroundCheckVerified
    ].where((verified) => verified).length;
    final double progress = verifiedCount / totalCount;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLighter,
            AppColors.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryLighter,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: primary,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증 진행률',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkAccent,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$verifiedCount/$totalCount 완료',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 진행률 바
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation<Color>(primary),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isVerified,
    required VoidCallback onTap,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isVerified
                        ? AppColors.successLight
                        : AppColors.primaryLighter,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isVerified ? Icons.check_circle : icon,
                    color: isVerified ? AppColors.success : primary,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkAccent,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),

                // 상태 표시
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isVerified
                        ? AppColors.successLight
                        : AppColors.warningLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isVerified
                          ? AppColors.successMuted
                          : AppColors.warningMuted,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    isVerified ? '완료' : '필요',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isVerified
                              ? AppColors.success
                              : AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.chevron_right,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsCard(Color primary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
                Icons.star_outline,
                color: primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '인증 혜택',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkAccent,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBenefitItem(
            icon: Icons.visibility_outlined,
            title: '프로필 우선 노출',
            description: '인증된 사용자가 검색 결과 상단에 표시됩니다',
          ),
          const SizedBox(height: 12),
          _buildBenefitItem(
            icon: Icons.verified_user_outlined,
            title: '신뢰도 향상',
            description: '고용주가 더 신뢰할 수 있는 프로필이 됩니다',
          ),
          const SizedBox(height: 12),
          _buildBenefitItem(
            icon: Icons.work_outline,
            title: '더 많은 작업 기회',
            description: '인증된 사용자만 접근 가능한 프리미엄 작업',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Icon(
          icon,
          color: primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkAccent,
                    ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.secondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showIdVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('신분증 인증'),
        content: const Text('신분증 사진을 업로드하여 인증을 진행하세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _idVerified = true;
              });
              _updateVerificationStatus();
              _showSuccessMessage('신분증 인증이 완료되었습니다');
            },
            child: const Text('인증하기'),
          ),
        ],
      ),
    );
  }

  void _showPhoneVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('전화번호 인증'),
        content: const Text('등록된 전화번호로 인증번호를 발송했습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _phoneVerified = true;
              });
              _updateVerificationStatus();
              _showSuccessMessage('전화번호 인증이 완료되었습니다');
            },
            child: const Text('인증하기'),
          ),
        ],
      ),
    );
  }

  void _showSkillVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기술 인증'),
        content: const Text('농업 기술 자격증이나 경력 증명서를 업로드하세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _skillVerified = true;
              });
              _updateVerificationStatus();
              _showSuccessMessage('기술 인증이 완료되었습니다');
            },
            child: const Text('인증하기'),
          ),
        ],
      ),
    );
  }

  void _showBackgroundCheckDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('신원 조회'),
        content: const Text('범죄 경력 조회를 통해 신원을 확인합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _backgroundCheckVerified = true;
              });
              _updateVerificationStatus();
              _showSuccessMessage('신원 조회가 완료되었습니다');
            },
            child: const Text('조회하기'),
          ),
        ],
      ),
    );
  }

  void _updateVerificationStatus() {
    final bool allVerified = _idVerified &&
        _phoneVerified &&
        _skillVerified &&
        _backgroundCheckVerified;
    widget.onVerificationUpdated(allVerified);
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

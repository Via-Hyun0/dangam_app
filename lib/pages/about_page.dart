import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_theme.dart';

/// 앱 정보 페이지
///
/// 디자이너 가이드:
/// - 이 페이지는 앱에 대한 정보를 표시합니다
/// - 앱 로고, 버전, 개발자 정보, 라이선스 등을 포함합니다
/// - 일관된 디자인을 위해 테마 시스템을 사용합니다
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 정보'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // 앱 로고 및 정보
            _buildAppInfo(),

            const SizedBox(height: AppSpacing.xl),

            // 앱 기능 소개
            _buildAppFeatures(),

            const SizedBox(height: AppSpacing.xl),

            // 개발자 정보
            _buildDeveloperInfo(),

            const SizedBox(height: AppSpacing.xl),

            // 라이선스 및 법적 정보
            _buildLegalInfo(),

            const SizedBox(height: AppSpacing.xl),

            // 연락처
            _buildContactInfo(),
          ],
        ),
      ),
    );
  }

  /// 앱 로고 및 기본 정보 위젯
  ///
  /// 디자이너 가이드:
  /// - 이 위젯은 앱의 로고와 기본 정보를 표시합니다
  /// - 앱 이름, 버전, 설명을 포함합니다
  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
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
      child: Column(
        children: [
          // 앱 로고
          Container(
            width: AppSpacing.iconHuge * 2,
            height: AppSpacing.iconHuge * 2,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.agriculture,
              size: AppTheme.iconThemeHuge.size,
              color: AppTheme.iconThemeHuge.color,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 앱 이름
          Text(
            '단감',
            style: AppTypography.headlineLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.darkAccent,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // 앱 설명
          Text(
            '농업 근로자와 농장주를 연결하는 플랫폼',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.lg),

          // 버전 정보
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            ),
            child: Text(
              '버전 1.0.0',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 앱 기능 소개 위젯
  ///
  /// 디자이너 가이드:
  /// - 이 위젯은 앱의 주요 기능들을 소개합니다
  /// - 아이콘과 설명을 함께 표시합니다
  Widget _buildAppFeatures() {
    return const _InfoSection(
      title: '주요 기능',
      items: [
        _FeatureItem(
          icon: Icons.work_outline,
          title: '작업 매칭',
          description: '농업 근로자와 농장주를 연결하여 작업을 매칭합니다',
        ),
        _FeatureItem(
          icon: Icons.location_on_outlined,
          title: '위치 기반 검색',
          description: '근처의 작업 기회를 쉽게 찾을 수 있습니다',
        ),
        _FeatureItem(
          icon: Icons.chat_bubble_outline,
          title: '실시간 채팅',
          description: '작업자와 농장주가 직접 소통할 수 있습니다',
        ),
        _FeatureItem(
          icon: Icons.verified_user_outlined,
          title: '신뢰성 검증',
          description: '검증된 사용자들만 참여할 수 있습니다',
        ),
      ],
    );
  }

  /// 개발자 정보 위젯
  ///
  /// 디자이너 가이드:
  /// - 이 위젯은 개발팀 정보를 표시합니다
  /// - 개발자 이름, 연락처, 소셜 미디어를 포함합니다
  Widget _buildDeveloperInfo() {
    return const _InfoSection(
      title: '개발팀',
      items: [
        _InfoItem(
          icon: Icons.person_outline,
          title: '개발자',
          value: '단감 개발팀',
        ),
        _InfoItem(
          icon: Icons.email_outlined,
          title: '이메일',
          value: 'contact@dangam.app',
        ),
        _InfoItem(
          icon: Icons.language,
          title: '웹사이트',
          value: 'www.dangam.app',
        ),
        _InfoItem(
          icon: Icons.calendar_today_outlined,
          title: '개발 시작일',
          value: '2024년 1월',
        ),
      ],
    );
  }

  /// 법적 정보 위젯
  ///
  /// 디자이너 가이드:
  /// - 이 위젯은 라이선스 및 법적 정보를 표시합니다
  /// - 이용약관, 개인정보처리방침, 라이선스를 포함합니다
  Widget _buildLegalInfo() {
    return const _InfoSection(
      title: '법적 정보',
      items: [
        _InfoItem(
          icon: Icons.description_outlined,
          title: '이용약관',
          value: '최신 버전',
        ),
        _InfoItem(
          icon: Icons.privacy_tip_outlined,
          title: '개인정보처리방침',
          value: '최신 버전',
        ),
        _InfoItem(
          icon: Icons.copyright_outlined,
          title: '라이선스',
          value: 'MIT License',
        ),
        _InfoItem(
          icon: Icons.security_outlined,
          title: '보안 정책',
          value: '최신 버전',
        ),
      ],
    );
  }

  /// 연락처 정보 위젯
  ///
  /// 디자이너 가이드:
  /// - 이 위젯은 고객 지원 연락처를 표시합니다
  /// - 이메일, 전화번호, 운영시간을 포함합니다
  Widget _buildContactInfo() {
    return const _InfoSection(
      title: '고객 지원',
      items: [
        _InfoItem(
          icon: Icons.support_agent,
          title: '고객센터',
          value: '1588-0000',
        ),
        _InfoItem(
          icon: Icons.schedule,
          title: '운영시간',
          value: '평일 09:00 - 18:00',
        ),
        _InfoItem(
          icon: Icons.email,
          title: '이메일 지원',
          value: 'support@dangam.app',
        ),
        _InfoItem(
          icon: Icons.chat,
          title: '실시간 채팅',
          value: '앱 내 채팅 지원',
        ),
      ],
    );
  }
}

/// 정보 섹션 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 관련된 정보들을 그룹화하여 표시합니다
/// - 섹션 제목과 정보 항목들을 포함합니다
class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _InfoSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkAccent,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

/// 기능 아이템 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 개별 기능을 표시합니다
/// - 아이콘, 제목, 설명을 포함합니다
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: AppSpacing.iconLarge + AppSpacing.md,
            height: AppSpacing.iconLarge + AppSpacing.md,
            decoration: BoxDecoration(
              color: AppColors.primaryLighter,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppTheme.iconTheme.size,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkAccent,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
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

/// 정보 아이템 위젯
///
/// 디자이너 가이드:
/// - 이 위젯은 개별 정보를 표시합니다
/// - 아이콘, 제목, 값을 포함합니다
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: AppTheme.iconTheme.size,
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: AppTypography.titleMedium.copyWith(
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

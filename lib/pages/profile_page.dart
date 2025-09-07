import 'package:flutter/material.dart';
import 'package:dangam_app/pages/profile_edit_page.dart';
import 'package:dangam_app/pages/verification_page.dart';
import 'package:dangam_app/pages/location_settings_page.dart';
import 'package:dangam_app/pages/my_jobs_page.dart';
import 'package:dangam_app/pages/availability_page.dart';
import 'package:dangam_app/pages/reviews_page.dart';
import 'package:dangam_app/pages/help_center_page.dart';
import 'package:dangam_app/pages/contact_us_page.dart';
import 'package:dangam_app/pages/about_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';

/// 프로필 페이지
/// 
/// 디자이너 가이드:
/// - 이 페이지는 사용자의 프로필 정보와 설정을 표시합니다
/// - 사용자 정보, 통계, 메뉴 항목을 포함합니다
/// - 일관된 디자인을 위해 테마 시스템을 사용합니다
class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  // 사용자 데이터 (실제 앱에서는 API에서 가져옴)
  String _userName = '김농부';
  String _userTitle = '농업 근로자 • 5년 경력';
  String _userLocation = '김제시 금구면';
  int _completedJobs = 47;
  double _rating = 4.8;
  int _responseRate = 98;
  bool _isVerified = false;
  String _profileImage = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // 프로필 헤더
          _ProfileHeader(
            userName: _userName,
            userTitle: _userTitle,
            userLocation: _userLocation,
            isVerified: _isVerified,
            profileImage: _profileImage,
            onEditTap: () => _navigateToProfileEdit(),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          // 통계 카드
          _StatsSection(
            completedJobs: _completedJobs,
            rating: _rating,
            responseRate: _responseRate,
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          // 메뉴 섹션
          _MenuSection(
            isVerified: _isVerified,
            onLogout: _showLogoutDialog,
          ),
        ],
      ),
    );
  }

  void _navigateToProfileEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfileEditPage()),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '로그아웃',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkAccent,
          ),
        ),
        content: Text(
          '정말 로그아웃하시겠습니까?',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              '취소',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performLogout();
            },
            child: Text(
              '로그아웃',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // 로그아웃 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '로그아웃되었습니다',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

/// 프로필 헤더 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 사용자의 기본 정보를 표시합니다
/// - 프로필 이미지, 이름, 인증 상태를 포함합니다
class _ProfileHeader extends StatelessWidget {
  final String userName;
  final String userTitle;
  final String userLocation;
  final bool isVerified;
  final String profileImage;
  final VoidCallback onEditTap;

  const _ProfileHeader({
    required this.userName,
    required this.userTitle,
    required this.userLocation,
    required this.isVerified,
    required this.profileImage,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
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
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLighter,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 프로필 이미지
          Container(
            width: AppSpacing.iconHuge * 2,
            height: AppSpacing.iconHuge * 2,
            decoration: BoxDecoration(
              color: AppColors.primaryLighter,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
              border: Border.all(
                color: AppColors.primaryLightest,
                width: 2,
              ),
            ),
            child: profileImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                    child: Image.network(
                      profileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: AppSpacing.iconHuge,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: AppSpacing.iconHuge,
                    color: AppColors.primary,
                  ),
          ),
          const SizedBox(width: AppSpacing.lg),
          // 이름과 인증 상태
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName,
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkAccent,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    if (isVerified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              color: AppColors.white,
                              size: AppSpacing.iconSmall,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '인증됨',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  userTitle,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: AppSpacing.iconSmall,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      userLocation,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 편집 버튼
          IconButton(
            onPressed: onEditTap,
            icon: Icon(
              Icons.edit,
              color: AppColors.primary,
              size: AppSpacing.iconMedium,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 통계 섹션 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 사용자의 작업 통계를 표시합니다
/// - 완료된 작업, 평점, 응답률을 포함합니다
class _StatsSection extends StatelessWidget {
  final int completedJobs;
  final double rating;
  final int responseRate;

  const _StatsSection({
    required this.completedJobs,
    required this.rating,
    required this.responseRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.work_outline,
            label: '완료된 작업',
            value: completedJobs.toString(),
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            icon: Icons.star_outline,
            label: '평점',
            value: rating.toString(),
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            icon: Icons.schedule,
            label: '응답률',
            value: '$responseRate%',
            color: AppColors.info,
          ),
        ),
      ],
    );
  }
}

/// 통계 카드 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 개별 통계를 카드 형태로 표시합니다
/// - 아이콘, 라벨, 값을 포함합니다
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.successMuted,
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
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.darkAccent,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 메뉴 섹션 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 프로필 관련 메뉴 항목들을 표시합니다
/// - 설정, 도움말, 로그아웃 등을 포함합니다
class _MenuSection extends StatelessWidget {
  final bool isVerified;
  final VoidCallback onLogout;

  const _MenuSection({
    required this.isVerified,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuGroup(
          title: '계정',
          items: [
            _MenuItem(
              icon: Icons.person_outline,
              title: '프로필 편집',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileEditPage(userName: '김농부')),
              ),
            ),
            _MenuItem(
              icon: Icons.verified_user_outlined,
              title: '인증 관리',
              subtitle: isVerified ? '완료' : '필요',
              badge: isVerified ? '완료' : '필요',
              badgeColor: isVerified ? AppColors.success : AppColors.warning,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const VerificationPage(isVerified: false)),
              ),
            ),
            _MenuItem(
              icon: Icons.location_on_outlined,
              title: '위치 설정',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LocationSettingsPage(currentLocation: '김제시 금구면')),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.lg),
        
        _MenuGroup(
          title: '작업',
          items: [
            _MenuItem(
              icon: Icons.work_outline,
              title: '내 작업',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyJobsPage(completedJobs: 47)),
              ),
            ),
            _MenuItem(
              icon: Icons.schedule_outlined,
              title: '가능 시간',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AvailabilityPage()),
              ),
            ),
            _MenuItem(
              icon: Icons.star_outline,
              title: '리뷰',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ReviewsPage(rating: 4.8)),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.lg),
        
        _MenuGroup(
          title: '지원',
          items: [
            _MenuItem(
              icon: Icons.help_outline,
              title: '도움말',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HelpCenterPage()),
              ),
            ),
            _MenuItem(
              icon: Icons.contact_support_outlined,
              title: '문의하기',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              ),
            ),
            _MenuItem(
              icon: Icons.info_outline,
              title: '앱 정보',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutPage()),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.xl),
        
        // 로그아웃 버튼
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onLogout,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              side: const BorderSide(color: AppColors.error),
              foregroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
            child: Text(
              '로그아웃',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 메뉴 그룹 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 관련된 메뉴 항목들을 그룹화합니다
/// - 그룹 제목과 메뉴 항목들을 포함합니다
class _MenuGroup extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuGroup({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.md),
          child: Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.grey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.map((item) => _MenuItemWidget(item: item)).toList(),
          ),
        ),
      ],
    );
  }
}

/// 메뉴 항목 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 개별 메뉴 항목을 표시합니다
/// - 아이콘, 제목, 부제목, 배지를 포함할 수 있습니다
class _MenuItemWidget extends StatelessWidget {
  final _MenuItem item;

  const _MenuItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: Padding(
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
                  item.icon,
                  color: AppColors.primary,
                  size: AppSpacing.iconMedium,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkAccent,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        item.subtitle!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (item.badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: (item.badgeColor ?? AppColors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                    border: Border.all(
                      color: (item.badgeColor ?? AppColors.primary).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    item.badge!,
                    style: AppTypography.labelSmall.copyWith(
                      color: item.badgeColor ?? AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Icon(
                Icons.chevron_right,
                color: AppColors.grey,
                size: AppSpacing.iconMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 메뉴 항목 데이터 클래스
class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.badge,
    this.badgeColor,
    required this.onTap,
  });
}
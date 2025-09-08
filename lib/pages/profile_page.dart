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
import 'package:dangam_app/data/mock_profile.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

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
  late UserProfile _userProfile;
  late UserStats _userStats;
  late UserSettings _userSettings;

  @override
  void initState() {
    super.initState();
    // 목업데이터 초기화 (실제 앱에서는 API 호출)
    _userProfile = MockProfileData.defaultProfile;
    _userStats = MockProfileData.userStats;
    _userSettings = MockProfileData.userSettings;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // 프로필 헤더
          _ProfileHeader(
            userProfile: _userProfile,
            onEditTap: () => _navigateToProfileEdit(),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 통계 카드
          _StatsSection(
            userStats: _userStats,
          ),

          const SizedBox(height: AppSpacing.xl),

          // 메뉴 섹션
          _MenuSection(
            userProfile: _userProfile,
            userStats: _userStats,
            onLogout: _showLogoutDialog,
            onProfileUpdated: _updateProfile,
            onLocationUpdated: _updateLocation,
          ),
        ],
      ),
    );
  }

  void _navigateToProfileEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProfileEditPage(
                userName: _userProfile.userName,
                userTitle: _userProfile.userTitle,
                userLocation: _userProfile.userLocation,
                onProfileUpdated: _updateProfile,
              )),
    );
  }

  void _updateProfile(String name, String title, String location, String bio) {
    setState(() {
      _userProfile = UserProfile(
        userName: name,
        userTitle: title,
        userLocation: location,
        profileImage: _userProfile.profileImage,
        isVerified: _userProfile.isVerified,
        completedJobs: _userProfile.completedJobs,
        rating: _userProfile.rating,
        responseRate: _userProfile.responseRate,
        bio: bio,
        joinDate: _userProfile.joinDate,
        skills: _userProfile.skills,
        certifications: _userProfile.certifications,
      );
    });
  }

  void _updateLocation(String location) {
    setState(() {
      _userProfile = UserProfile(
        userName: _userProfile.userName,
        userTitle: _userProfile.userTitle,
        userLocation: location,
        profileImage: _userProfile.profileImage,
        isVerified: _userProfile.isVerified,
        completedJobs: _userProfile.completedJobs,
        rating: _userProfile.rating,
        responseRate: _userProfile.responseRate,
        bio: _userProfile.bio,
        joinDate: _userProfile.joinDate,
        skills: _userProfile.skills,
        certifications: _userProfile.certifications,
      );
    });
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
  final UserProfile userProfile;
  final VoidCallback onEditTap;

  const _ProfileHeader({
    required this.userProfile,
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
            child: userProfile.profileImage.isNotEmpty
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusCircular),
                    child: Image.network(
                      userProfile.profileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        AppIcons.user,
                        size: AppSpacing.iconHuge,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : const Icon(
                    AppIcons.user,
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
                      userProfile.userName,
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkAccent,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    if (userProfile.isVerified)
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
                            const Icon(
                              AppIcons.verified,
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
                  userProfile.userTitle,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      AppIcons.location,
                      color: AppColors.primary,
                      size: AppSpacing.iconSmall,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      userProfile.userLocation,
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
            icon: const Icon(
              AppIcons.edit,
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
  final UserStats userStats;

  const _StatsSection({
    required this.userStats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: AppIcons.workOutline,
            label: '완료된 작업',
            value: userStats.completedJobs.toString(),
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            icon: AppIcons.starOutline,
            label: '평점',
            value: userStats.rating.toString(),
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            icon: AppIcons.schedule,
            label: '응답률',
            value: '${userStats.responseRate}%',
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
  final UserProfile userProfile;
  final UserStats userStats;
  final VoidCallback onLogout;
  final Function(String, String, String, String) onProfileUpdated;
  final Function(String) onLocationUpdated;

  const _MenuSection({
    required this.userProfile,
    required this.userStats,
    required this.onLogout,
    required this.onProfileUpdated,
    required this.onLocationUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuGroup(
          title: '계정',
          items: [
            _MenuItem(
              icon: AppIcons.userOutline,
              title: '프로필 편집',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProfileEditPage(
                          userName: userProfile.userName,
                          userTitle: userProfile.userTitle,
                          userLocation: userProfile.userLocation,
                          onProfileUpdated: onProfileUpdated,
                        )),
              ),
            ),
            _MenuItem(
              icon: AppIcons.verifiedOutline,
              title: '인증 관리',
              subtitle: userProfile.isVerified ? '완료' : '필요',
              badge: userProfile.isVerified ? '완료' : '필요',
              badgeColor: userProfile.isVerified
                  ? AppColors.success
                  : AppColors.warning,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => VerificationPage(
                          isVerified: userProfile.isVerified,
                          onVerificationUpdated: (bool value) {},
                        )),
              ),
            ),
            _MenuItem(
              icon: AppIcons.locationOutline,
              title: '위치 설정',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => LocationSettingsPage(
                          currentLocation: userProfile.userLocation,
                          onLocationUpdated: onLocationUpdated,
                        )),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        _MenuGroup(
          title: '작업',
          items: [
            _MenuItem(
              icon: AppIcons.workOutline,
              title: '내 작업',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MyJobsPage(
                          completedJobs: userStats.completedJobs,
                          rating: userStats.rating,
                        )),
              ),
            ),
            _MenuItem(
              icon: AppIcons.scheduleOutline,
              title: '가능 시간',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AvailabilityPage()),
              ),
            ),
            _MenuItem(
              icon: AppIcons.starOutline,
              title: '리뷰',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ReviewsPage(
                          rating: userStats.rating,
                        )),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        _MenuGroup(
          title: '지원',
          items: [
            _MenuItem(
              icon: AppIcons.helpOutline,
              title: '도움말',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HelpCenterPage()),
              ),
            ),
            _MenuItem(
              icon: AppIcons.contactSupport,
              title: '문의하기',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              ),
            ),
            _MenuItem(
              icon: AppIcons.infoOutline,
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
          padding:
              const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.md),
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
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                offset: Offset(0, 2),
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
                    color: (item.badgeColor ?? AppColors.primary)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                    border: Border.all(
                      color: (item.badgeColor ?? AppColors.primary)
                          .withValues(alpha: 0.3),
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
              const Icon(
                AppIcons.chevronRight,
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

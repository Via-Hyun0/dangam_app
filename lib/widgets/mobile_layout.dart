import 'package:flutter/material.dart';
import 'package:dangam_app/pages/dashboard_body.dart';
import 'package:dangam_app/pages/jobs_page.dart';
import 'package:dangam_app/pages/messages_page.dart';
import 'package:dangam_app/pages/profile_page.dart';
import 'package:dangam_app/pages/work_map_page.dart';
import 'package:dangam_app/pages/notifications_page.dart';
import 'package:dangam_app/pages/settings_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

class MobileLayout extends StatefulWidget {
  final String title;
  final Widget body;

  const MobileLayout({super.key, required this.title, required this.body});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    DashboardBody(),
    JobsBody(),
    WorkMapPage(),
    MessagesBody(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return '내 업무';
      case 1:
        return '작업 찾기';
      case 2:
        return '지도';
      case 3:
        return '메시지';
      default:
        return '단감';
    }
  }

  void _showNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotificationsPage(),
      ),
    );
  }

  void _showDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DrawerContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(_selectedIndex),
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
          // 알림 버튼
          IconButton(
            onPressed: () => _showNotifications(context),
            icon: Stack(
              children: [
                const Icon(
                  AppIcons.notifications,
                  color: AppColors.darkAccent,
                  size: AppSpacing.iconMedium,
                ),
                // 알림 배지
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 햄버거 메뉴
          IconButton(
            onPressed: () => _showDrawer(context),
            icon: const Icon(
              AppIcons.menu,
              color: AppColors.darkAccent,
              size: AppSpacing.iconMedium,
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary, // 단감 오렌지
        unselectedItemColor: theme.colorScheme.secondary, // 보조 브라운
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '대시보드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: '작업',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '메시지',
          ),
        ],
      ),
    );
  }
}

/// 햄버거 메뉴 콘텐츠
class _DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLarge),
          topRight: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      child: Column(
        children: [
          // 핸들 바
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 메뉴 헤더
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  '메뉴',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkAccent,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    AppIcons.close,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),

          // 메뉴 항목들
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              children: [
                _DrawerMenuItem(
                  icon: AppIcons.user,
                  title: '프로필',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
                _DrawerMenuItem(
                  icon: AppIcons.settings,
                  title: '설정',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                _DrawerMenuItem(
                  icon: AppIcons.helpOutline,
                  title: '도움말',
                  onTap: () {
                    Navigator.of(context).pop();
                    // 도움말 페이지로 이동
                  },
                ),
                _DrawerMenuItem(
                  icon: AppIcons.infoOutline,
                  title: '앱 정보',
                  onTap: () {
                    Navigator.of(context).pop();
                    // 앱 정보 페이지로 이동
                  },
                ),
                const Divider(height: AppSpacing.xl),
                _DrawerMenuItem(
                  icon: AppIcons.logout,
                  title: '로그아웃',
                  isDestructive: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
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
            fontWeight: FontWeight.w500,
          ),
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
              // 로그아웃 로직
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            child: Text(
              '로그아웃',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 드로어 메뉴 항목
class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.primary,
        size: AppSpacing.iconMedium,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: isDestructive ? AppColors.error : AppColors.darkAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    );
  }
}

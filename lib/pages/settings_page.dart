import 'package:flutter/material.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';
import 'package:dangam_app/theme/app_icons.dart';

/// 설정 페이지
///
/// 디자이너 가이드:
/// - 이 페이지는 앱의 모든 설정을 관리합니다
/// - 카테고리별로 그룹화되어 있습니다
/// - 사용자 친화적인 인터페이스를 제공합니다
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = '한국어';
  String _selectedRadius = '10km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '설정',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkAccent,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // 알림 설정
            _SettingsSection(
              title: '알림',
              children: [
                _SwitchSettingItem(
                  icon: AppIcons.notifications,
                  title: '푸시 알림',
                  subtitle: '새로운 작업과 메시지 알림을 받습니다',
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value),
                ),
                _SwitchSettingItem(
                  icon: AppIcons.vibration,
                  title: '진동',
                  subtitle: '알림 수신 시 진동을 울립니다',
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // 위치 설정
            _SettingsSection(
              title: '위치',
              children: [
                _SwitchSettingItem(
                  icon: AppIcons.location,
                  title: '위치 서비스',
                  subtitle: '근처 작업을 찾기 위해 위치를 사용합니다',
                  value: _locationEnabled,
                  onChanged: (value) =>
                      setState(() => _locationEnabled = value),
                ),
                _DropdownSettingItem(
                  icon: AppIcons.radius,
                  title: '검색 반경',
                  subtitle: '작업 검색 시 고려할 거리 범위',
                  value: _selectedRadius,
                  options: ['5km', '10km', '20km', '50km'],
                  onChanged: (value) =>
                      setState(() => _selectedRadius = value!),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // 앱 설정
            _SettingsSection(
              title: '앱',
              children: [
                _SwitchSettingItem(
                  icon: AppIcons.darkMode,
                  title: '다크 모드',
                  subtitle: '어두운 테마를 사용합니다',
                  value: _darkModeEnabled,
                  onChanged: (value) =>
                      setState(() => _darkModeEnabled = value),
                ),
                _DropdownSettingItem(
                  icon: AppIcons.language,
                  title: '언어',
                  subtitle: '앱에서 사용할 언어를 선택하세요',
                  value: _selectedLanguage,
                  options: ['한국어', 'English', '日本語'],
                  onChanged: (value) =>
                      setState(() => _selectedLanguage = value!),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // 계정 설정
            _SettingsSection(
              title: '계정',
              children: [
                _ActionSettingItem(
                  icon: AppIcons.user,
                  title: '프로필 편집',
                  subtitle: '개인정보를 수정합니다',
                  onTap: () {
                    // 프로필 편집 페이지로 이동
                  },
                ),
                _ActionSettingItem(
                  icon: AppIcons.privacy,
                  title: '개인정보 보호',
                  subtitle: '개인정보 처리방침을 확인합니다',
                  onTap: () {
                    // 개인정보 보호 페이지로 이동
                  },
                ),
                _ActionSettingItem(
                  icon: AppIcons.security,
                  title: '보안',
                  subtitle: '비밀번호 및 보안 설정',
                  onTap: () {
                    // 보안 설정 페이지로 이동
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // 지원
            _SettingsSection(
              title: '지원',
              children: [
                _ActionSettingItem(
                  icon: AppIcons.helpOutline,
                  title: '도움말',
                  subtitle: '자주 묻는 질문과 사용법',
                  onTap: () {
                    // 도움말 페이지로 이동
                  },
                ),
                _ActionSettingItem(
                  icon: AppIcons.contactSupport,
                  title: '문의하기',
                  subtitle: '고객지원팀에 문의합니다',
                  onTap: () {
                    // 문의하기 페이지로 이동
                  },
                ),
                _ActionSettingItem(
                  icon: AppIcons.infoOutline,
                  title: '앱 정보',
                  subtitle: '버전 정보 및 라이선스',
                  onTap: () {
                    // 앱 정보 페이지로 이동
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl * 2),

            // 로그아웃 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showLogoutDialog,
                icon: const Icon(AppIcons.logout),
                label: const Text('로그아웃'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
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

/// 설정 섹션 위젯
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              title,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.darkAccent,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

/// 스위치 설정 항목
class _SwitchSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchSettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: AppSpacing.iconMedium,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkAccent,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
    );
  }
}

/// 드롭다운 설정 항목
class _DropdownSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _DropdownSettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: AppSpacing.iconMedium,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkAccent,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: const SizedBox(),
        items: options.map<DropdownMenuItem<String>>((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.darkAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
    );
  }
}

/// 액션 설정 항목
class _ActionSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionSettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: AppSpacing.iconMedium,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkAccent,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        AppIcons.chevronRight,
        color: AppColors.grey,
        size: AppSpacing.iconSmall,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
    );
  }
}

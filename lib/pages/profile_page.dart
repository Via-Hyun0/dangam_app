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
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 프로필 헤더
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary.withOpacity(0.1),
                  primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // 아바타와 편집 버튼
                Row(
                  children: [
                    // 아바타
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: _profileImage.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 40,
                              color: primary,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                _profileImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: 40,
                                    color: primary,
                                  );
                                },
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    // 이름과 인증 상태
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _userName,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF503123),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_isVerified)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '인증됨',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _userTitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFa48e7b),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: primary,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _userLocation,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: primary,
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
                      onPressed: () => _navigateToProfileEdit(),
                      icon: Icon(
                        Icons.edit_outlined,
                        color: primary,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: primary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // 통계
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.work_outline,
                        label: '완료된 작업',
                        value: _completedJobs.toString(),
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.star_outline,
                        label: '평점',
                        value: _rating.toString(),
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.schedule_outline,
                        label: '응답률',
                        value: '$_responseRate%',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 메뉴 섹션들
          _MenuSection(
            title: '계정',
            items: [
              _MenuItem(
                icon: Icons.person_outline,
                title: '프로필 편집',
                subtitle: '개인정보 업데이트',
                onTap: () => _navigateToProfileEdit(),
              ),
              _MenuItem(
                icon: Icons.verified_outlined,
                title: '인증 관리',
                subtitle: '신분증 및 기술 인증',
                onTap: () => _navigateToVerification(),
                badge: _isVerified ? '완료' : '필요',
                badgeColor: _isVerified ? Colors.green : Colors.orange,
              ),
              _MenuItem(
                icon: Icons.location_on_outlined,
                title: '위치 설정',
                subtitle: '작업 지역 관리',
                onTap: () => _navigateToLocationSettings(),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _MenuSection(
            title: '작업',
            items: [
              _MenuItem(
                icon: Icons.work_outline,
                title: '내 작업',
                subtitle: '작업 이력 보기',
                onTap: () => _navigateToMyJobs(),
                badge: _completedJobs.toString(),
                badgeColor: primary,
              ),
              _MenuItem(
                icon: Icons.schedule_outlined,
                title: '가능 시간',
                subtitle: '근무 시간 설정',
                onTap: () => _navigateToAvailability(),
              ),
              _MenuItem(
                icon: Icons.star_outline,
                title: '리뷰',
                subtitle: '고용주 평가 보기',
                onTap: () => _navigateToReviews(),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _MenuSection(
            title: '지원',
            items: [
              _MenuItem(
                icon: Icons.help_outline,
                title: '도움말',
                subtitle: '도움말 및 지원',
                onTap: () => _navigateToHelpCenter(),
              ),
              _MenuItem(
                icon: Icons.chat_bubble_outline,
                title: '문의하기',
                subtitle: '메시지 보내기',
                onTap: () => _navigateToContactUs(),
              ),
              _MenuItem(
                icon: Icons.info_outline,
                title: '앱 정보',
                subtitle: '버전 및 정보',
                onTap: () => _navigateToAbout(),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // 로그아웃 버튼
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(),
              icon: const Icon(Icons.logout),
              label: const Text('로그아웃'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.red.shade300),
                foregroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 네비게이션 메서드들
  void _navigateToProfileEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileEditPage(
          userName: _userName,
          userTitle: _userTitle,
          userLocation: _userLocation,
          onProfileUpdated: (name, title, location, image) {
            setState(() {
              _userName = name;
              _userTitle = title;
              _userLocation = location;
              _profileImage = image;
            });
          },
        ),
      ),
    );
  }

  void _navigateToVerification() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationPage(
          isVerified: _isVerified,
          onVerificationUpdated: (verified) {
            setState(() {
              _isVerified = verified;
            });
          },
        ),
      ),
    );
  }

  void _navigateToLocationSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationSettingsPage(
          currentLocation: _userLocation,
          onLocationUpdated: (location) {
            setState(() {
              _userLocation = location;
            });
          },
        ),
      ),
    );
  }

  void _navigateToMyJobs() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyJobsPage(
          completedJobs: _completedJobs,
          rating: _rating,
        ),
      ),
    );
  }

  void _navigateToAvailability() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AvailabilityPage(),
      ),
    );
  }

  void _navigateToReviews() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewsPage(
          rating: _rating,
        ),
      ),
    );
  }

  void _navigateToHelpCenter() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HelpCenterPage(),
      ),
    );
  }

  void _navigateToContactUs() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactUsPage(),
      ),
    );
  }

  void _navigateToAbout() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AboutPage(),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 실제 앱에서는 로그아웃 로직 실행
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('로그아웃되었습니다'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF503123),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFFa48e7b),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children:
                items.map((item) => _buildMenuItem(context, item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.icon,
                color: primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF503123),
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFa48e7b),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 배지
            if (item.badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: (item.badgeColor ?? primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (item.badgeColor ?? primary).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  item.badge!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: item.badgeColor ?? primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final String? badge;
  final Color? badgeColor;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.badge,
    this.badgeColor,
  });
}

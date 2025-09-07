import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 정보'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFfdfdfd),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 앱 로고 및 정보
            _buildAppInfo(primary),
            
            const SizedBox(height: 24),
            
            // 앱 정보
            _buildAppDetails(primary),
            
            const SizedBox(height: 24),
            
            // 개발팀 정보
            _buildTeamInfo(primary),
            
            const SizedBox(height: 24),
            
            // 라이선스 및 약관
            _buildLegalInfo(primary),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfo(Color primary) {
    return Container(
      padding: const EdgeInsets.all(32),
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
          // 앱 로고
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.agriculture,
              color: Colors.white,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 앱 이름
          Text(
            '단감',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 앱 설명
          Text(
            '농작업 연결 플랫폼',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFFa48e7b),
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 버전 정보
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '버전 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppDetails(Color primary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '앱 정보',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoItem(
            context,
            icon: Icons.description_outlined,
            title: '앱 설명',
            content: '농업 근로자와 농장주를 연결하는 플랫폼입니다. 효율적인 농작업 매칭을 통해 농업 생산성을 높이고, 근로자에게 안정적인 일자리를 제공합니다.',
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoItem(
            context,
            icon: Icons.update_outlined,
            title: '최근 업데이트',
            content: '• 프로필 관리 기능 개선\n• 실시간 채팅 시스템 추가\n• 지도 기반 작업 검색 기능\n• 결제 시스템 통합',
          ),
          
          const SizedBox(height: 16),
          
          _buildInfoItem(
            context,
            icon: Icons.security_outlined,
            title: '보안 및 개인정보',
            content: '모든 개인정보는 암호화되어 안전하게 보호됩니다. 사용자 인증 시스템을 통해 신뢰할 수 있는 플랫폼을 제공합니다.',
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(Color primary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '개발팀',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildTeamMember(
            context,
            name: '김개발',
            role: '개발팀장',
            email: 'dev@dangam.com',
          ),
          
          const SizedBox(height: 12),
          
          _buildTeamMember(
            context,
            name: '이디자인',
            role: 'UI/UX 디자이너',
            email: 'design@dangam.com',
          ),
          
          const SizedBox(height: 12),
          
          _buildTeamMember(
            context,
            name: '박마케팅',
            role: '마케팅 매니저',
            email: 'marketing@dangam.com',
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(BuildContext context, {
    required String name,
    required String role,
    required String email,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.person,
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
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF503123),
                ),
              ),
              Text(
                role,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFa48e7b),
                ),
              ),
            ],
          ),
        ),
        Text(
          email,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLegalInfo(Color primary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '법적 정보',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildLegalItem(
            context,
            title: '이용약관',
            onTap: () => _showLegalDialog(context, '이용약관', '이용약관 내용입니다...'),
          ),
          
          const SizedBox(height: 12),
          
          _buildLegalItem(
            context,
            title: '개인정보처리방침',
            onTap: () => _showLegalDialog(context, '개인정보처리방침', '개인정보처리방침 내용입니다...'),
          ),
          
          const SizedBox(height: 12),
          
          _buildLegalItem(
            context,
            title: '서비스 약관',
            onTap: () => _showLegalDialog(context, '서비스 약관', '서비스 약관 내용입니다...'),
          ),
          
          const SizedBox(height: 16),
          
          const Divider(),
          
          const SizedBox(height: 16),
          
          Text(
            '© 2024 단감. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: const Color(0xFF503123),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFa48e7b),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegalItem(BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLegalDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

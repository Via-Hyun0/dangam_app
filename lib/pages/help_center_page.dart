import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    final List<Map<String, dynamic>> faqItems = [
      {
        'category': '계정 관리',
        'questions': [
          {
            'question': '프로필을 어떻게 수정하나요?',
            'answer': '프로필 탭에서 "프로필 편집"을 선택하여 개인정보를 수정할 수 있습니다.',
          },
          {
            'question': '비밀번호를 잊어버렸어요',
            'answer': '로그인 화면에서 "비밀번호 찾기"를 클릭하여 이메일로 재설정 링크를 받을 수 있습니다.',
          },
        ],
      },
      {
        'category': '작업 관련',
        'questions': [
          {
            'question': '작업에 어떻게 지원하나요?',
            'answer': '작업 목록에서 원하는 작업을 선택하고 "지원하기" 버튼을 클릭하세요.',
          },
          {
            'question': '작업 취소는 어떻게 하나요?',
            'answer': '내 작업 탭에서 취소하고 싶은 작업을 선택하고 "취소하기"를 클릭하세요.',
          },
        ],
      },
      {
        'category': '결제 관련',
        'questions': [
          {
            'question': '급여는 언제 받나요?',
            'answer': '작업 완료 후 24시간 내에 계좌로 입금됩니다.',
          },
          {
            'question': '세금 계산서는 어떻게 받나요?',
            'answer': '마이페이지의 "세금 계산서" 메뉴에서 다운로드할 수 있습니다.',
          },
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('도움말'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFfdfdfd),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 검색 바
            _buildSearchBar(primary),
            
            const SizedBox(height: 24),
            
            // 빠른 도움말
            _buildQuickHelp(primary),
            
            const SizedBox(height: 24),
            
            // FAQ
            _buildFAQ(faqItems, primary),
            
            const SizedBox(height: 24),
            
            // 문의하기
            _buildContactSection(primary),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(Color primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '도움말 검색',
          prefixIcon: Icon(Icons.search, color: primary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildQuickHelp(Color primary) {
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
            '빠른 도움말',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildQuickHelpItem(
            icon: Icons.phone_outlined,
            title: '전화 문의',
            subtitle: '평일 09:00-18:00',
            onTap: () => _showContactDialog('전화 문의', '1588-1234'),
          ),
          
          const SizedBox(height: 12),
          
          _buildQuickHelpItem(
            icon: Icons.chat_bubble_outline,
            title: '채팅 문의',
            subtitle: '실시간 상담',
            onTap: () => _showContactDialog('채팅 문의', '실시간 채팅을 시작합니다'),
          ),
          
          const SizedBox(height: 12),
          
          _buildQuickHelpItem(
            icon: Icons.email_outlined,
            title: '이메일 문의',
            subtitle: 'support@dangam.com',
            onTap: () => _showContactDialog('이메일 문의', 'support@dangam.com'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelpItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
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
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF503123),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFa48e7b),
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget _buildFAQ(List<Map<String, dynamic>> faqItems, Color primary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '자주 묻는 질문',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF503123),
          ),
        ),
        
        const SizedBox(height: 16),
        
        ...faqItems.map((category) => _buildFAQCategory(category, primary)),
      ],
    );
  }

  Widget _buildFAQCategory(Map<String, dynamic> category, Color primary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          // 카테고리 헤더
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  category['category'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF503123),
                  ),
                ),
              ],
            ),
          ),
          
          // 질문 목록
          ...category['questions'].map<Widget>((question) => _buildFAQItem(question, primary)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> question, Color primary) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: ExpansionTile(
        title: Text(
          question['question'],
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF503123),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              question['answer'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFa48e7b),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(Color primary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.support_agent,
            color: primary,
            size: 32,
          ),
          
          const SizedBox(height: 12),
          
          Text(
            '더 도움이 필요하신가요?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            '문의하기를 통해 직접 상담받으실 수 있습니다.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFa48e7b),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showContactDialog('문의하기', '문의하기 페이지로 이동합니다'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '문의하기',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
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

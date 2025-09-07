import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  
  String _selectedCategory = '일반 문의';
  final List<String> _categories = [
    '일반 문의',
    '기술 지원',
    '계정 문제',
    '결제 문의',
    '버그 신고',
    '기능 제안',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              '전송',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFfdfdfd),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 문의 유형
              _buildCategorySection(primary),
              
              const SizedBox(height: 24),
              
              // 문의 양식
              _buildFormSection(primary),
              
              const SizedBox(height: 24),
              
              // 연락처 정보
              _buildContactInfo(primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(Color primary) {
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
            '문의 유형',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((category) => _buildCategoryChip(category, primary)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, Color primary) {
    final bool isSelected = category == _selectedCategory;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          category,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isSelected ? Colors.white : primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(Color primary) {
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
            '문의 내용',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _nameController,
            label: '이름',
            hint: '이름을 입력하세요',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '이름을 입력해주세요';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _emailController,
            label: '이메일',
            hint: 'example@email.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '이메일을 입력해주세요';
              }
              if (!value.contains('@')) {
                return '올바른 이메일 형식을 입력해주세요';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _subjectController,
            label: '제목',
            hint: '문의 제목을 입력하세요',
            icon: Icons.title,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '제목을 입력해주세요';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _messageController,
            label: '내용',
            hint: '문의 내용을 자세히 입력해주세요',
            icon: Icons.message_outlined,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '내용을 입력해주세요';
              }
              if (value.length < 10) {
                return '10자 이상 입력해주세요';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildContactInfo(Color primary) {
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
            Icons.contact_support_outlined,
            color: primary,
            size: 32,
          ),
          
          const SizedBox(height: 12),
          
          Text(
            '다른 연락 방법',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildContactMethod(
            icon: Icons.phone_outlined,
            title: '전화 문의',
            subtitle: '1588-1234',
            onTap: () => _showContactDialog('전화 문의', '1588-1234로 전화주세요'),
          ),
          
          const SizedBox(height: 12),
          
          _buildContactMethod(
            icon: Icons.chat_bubble_outline,
            title: '실시간 채팅',
            subtitle: '평일 09:00-18:00',
            onTap: () => _showContactDialog('실시간 채팅', '채팅 상담을 시작합니다'),
          ),
          
          const SizedBox(height: 12),
          
          _buildContactMethod(
            icon: Icons.email_outlined,
            title: '이메일',
            subtitle: 'support@dangam.com',
            onTap: () => _showContactDialog('이메일', 'support@dangam.com으로 문의하세요'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethod({
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 실제 앱에서는 서버로 문의 내용 전송
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('문의가 전송되었습니다. 빠른 시일 내에 답변드리겠습니다.'),
          backgroundColor: Colors.green,
        ),
      );
      
      // 폼 초기화
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      setState(() {
        _selectedCategory = '일반 문의';
      });
    }
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

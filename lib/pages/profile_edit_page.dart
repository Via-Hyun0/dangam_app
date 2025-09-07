import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final String userName;
  final String userTitle;
  final String userLocation;
  final Function(String, String, String, String) onProfileUpdated;

  const ProfileEditPage({
    super.key,
    required this.userName,
    required this.userTitle,
    required this.userLocation,
    required this.onProfileUpdated,
  });

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  
  final _formKey = GlobalKey<FormState>();
  String _selectedGender = '남성';
  String _selectedExperience = '5년';
  String _profileImage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _titleController = TextEditingController(text: widget.userTitle);
    _locationController = TextEditingController(text: widget.userLocation);
    _phoneController = TextEditingController(text: '010-1234-5678');
    _emailController = TextEditingController(text: 'kimfarmer@example.com');
    _bioController = TextEditingController(text: '5년간 다양한 농작물 재배 경험을 가지고 있습니다. 포도, 딸기, 토마토 재배에 특화되어 있으며, 정확하고 신뢰할 수 있는 작업을 제공합니다.');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 편집'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              '저장',
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 프로필 이미지
              _buildProfileImageSection(primary),
              
              const SizedBox(height: 24),
              
              // 기본 정보
              _buildSection(
                title: '기본 정보',
                children: [
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
                    controller: _titleController,
                    label: '직업/경력',
                    hint: '예: 농업 근로자 • 5년 경력',
                    icon: Icons.work_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '직업/경력을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: '성별',
                    value: _selectedGender,
                    items: ['남성', '여성'],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: '경력',
                    value: _selectedExperience,
                    items: ['1년 미만', '1-2년', '3-5년', '5-10년', '10년 이상'],
                    onChanged: (value) {
                      setState(() {
                        _selectedExperience = value!;
                      });
                    },
                    icon: Icons.trending_up_outlined,
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // 연락처 정보
              _buildSection(
                title: '연락처 정보',
                children: [
                  _buildTextField(
                    controller: _phoneController,
                    label: '전화번호',
                    hint: '010-1234-5678',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '전화번호를 입력해주세요';
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
                ],
              ),
              
              const SizedBox(height: 24),
              
              // 위치 정보
              _buildSection(
                title: '위치 정보',
                children: [
                  _buildTextField(
                    controller: _locationController,
                    label: '주요 작업 지역',
                    hint: '김제시 금구면',
                    icon: Icons.location_on_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '작업 지역을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // 자기소개
              _buildSection(
                title: '자기소개',
                children: [
                  _buildTextField(
                    controller: _bioController,
                    label: '자기소개',
                    hint: '자신을 소개해주세요',
                    icon: Icons.description_outlined,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '자기소개를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // 저장 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '프로필 저장',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(Color primary) {
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
        children: [
          // 프로필 이미지
          GestureDetector(
            onTap: _selectProfileImage,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: _profileImage.isEmpty
                  ? Icon(
                      Icons.camera_alt_outlined,
                      color: primary,
                      size: 40,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        _profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.camera_alt_outlined,
                            color: primary,
                            size: 40,
                          );
                        },
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '프로필 사진 변경',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
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
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
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
    final Color primary = Theme.of(context).colorScheme.primary;
    
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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
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
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  void _selectProfileImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('프로필 사진'),
        content: const Text('프로필 사진을 선택하세요'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 실제 앱에서는 갤러리에서 이미지 선택
              setState(() {
                _profileImage = 'https://via.placeholder.com/150';
              });
            },
            child: const Text('갤러리에서 선택'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 실제 앱에서는 카메라로 촬영
              setState(() {
                _profileImage = 'https://via.placeholder.com/150';
              });
            },
            child: const Text('카메라로 촬영'),
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      widget.onProfileUpdated(
        _nameController.text,
        _titleController.text,
        _locationController.text,
        _profileImage,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('프로필이 저장되었습니다'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }
}

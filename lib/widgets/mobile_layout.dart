import 'package:flutter/material.dart';
import 'package:dangam_app/pages/dashboard_body.dart';
import 'package:dangam_app/pages/jobs_page.dart';
import 'package:dangam_app/pages/messages_page.dart';
import 'package:dangam_app/pages/profile_page.dart';
import 'package:dangam_app/pages/work_map_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';

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
    ProfileBody(),
  ];

  final List<String> _pageTitles = const [
    '단감',
    '작업',
    '지도',
    '메시지',
    '프로필',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        backgroundColor: AppColors.white,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}

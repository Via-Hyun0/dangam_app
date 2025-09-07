import 'package:flutter/material.dart';

class MyJobsPage extends StatefulWidget {
  final int completedJobs;
  final double rating;

  const MyJobsPage({
    super.key,
    required this.completedJobs,
    required this.rating,
  });

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = '전체';
  
  final List<String> _filters = ['전체', '진행중', '완료', '취소됨'];
  
  // 모의 작업 데이터
  final List<Map<String, dynamic>> _jobs = [
    {
      'id': '1',
      'title': '포도 수확 작업',
      'employer': '김농장',
      'location': '김제시 금구면',
      'date': '2024-01-15',
      'status': '완료',
      'rating': 5.0,
      'payment': 150000,
      'duration': '8시간',
    },
    {
      'id': '2',
      'title': '딸기 정리 작업',
      'employer': '이농장',
      'location': '김제시 봉남면',
      'date': '2024-01-20',
      'status': '완료',
      'rating': 4.8,
      'payment': 120000,
      'duration': '6시간',
    },
    {
      'id': '3',
      'title': '토마토 심기',
      'employer': '박농장',
      'location': '김제시 부량면',
      'date': '2024-01-25',
      'status': '진행중',
      'rating': null,
      'payment': 200000,
      'duration': '10시간',
    },
    {
      'id': '4',
      'title': '오이 수확',
      'employer': '최농장',
      'location': '전주시 완산구',
      'date': '2024-01-10',
      'status': '취소됨',
      'rating': null,
      'payment': 100000,
      'duration': '5시간',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 작업'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: primary,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: primary,
          tabs: const [
            Tab(text: '전체'),
            Tab(text: '진행중'),
            Tab(text: '완료'),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFfdfdfd),
      body: Column(
        children: [
          // 통계 카드
          _buildStatsCard(primary),
          
          // 필터
          _buildFilterBar(),
          
          // 작업 목록
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildJobList('전체'),
                _buildJobList('진행중'),
                _buildJobList('완료'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(Color primary) {
    return Container(
      margin: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.work_outline,
              label: '완료된 작업',
              value: widget.completedJobs.toString(),
              color: Colors.green,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: primary.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.star_outline,
              label: '평균 평점',
              value: widget.rating.toString(),
              color: Colors.amber,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: primary.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.attach_money_outlined,
              label: '총 수입',
              value: '₩2,400,000',
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
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
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFFa48e7b),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          final Color primary = Theme.of(context).colorScheme.primary;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              selectedColor: primary.withOpacity(0.2),
              checkmarkColor: primary,
              labelStyle: TextStyle(
                color: isSelected ? primary : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildJobList(String status) {
    final filteredJobs = status == '전체' 
        ? _jobs 
        : _jobs.where((job) => job['status'] == status).toList();
    
    if (filteredJobs.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        final job = filteredJobs[index];
        return _buildJobCard(job);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '작업이 없습니다',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '새로운 작업을 찾아보세요',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final String status = job['status'];
    final Color statusColor = _getStatusColor(status);
    
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showJobDetails(job),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 헤더
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        job['title'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF503123),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        status,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // 고용주 정보
                Row(
                  children: [
                    Icon(
                      Icons.business_outlined,
                      color: primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      job['employer'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFa48e7b),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.location_on_outlined,
                      color: primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      job['location'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFa48e7b),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // 작업 정보
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.calendar_today_outlined,
                      label: job['date'],
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      icon: Icons.access_time_outlined,
                      label: job['duration'],
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      icon: Icons.attach_money_outlined,
                      label: '₩${job['payment']}',
                      color: Colors.orange,
                    ),
                  ],
                ),
                
                // 평점
                if (job['rating'] != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job['rating'].toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.amber.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '완료':
        return Colors.green;
      case '진행중':
        return Colors.blue;
      case '취소됨':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showJobDetails(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(job['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('고용주: ${job['employer']}'),
            Text('위치: ${job['location']}'),
            Text('날짜: ${job['date']}'),
            Text('소요시간: ${job['duration']}'),
            Text('급여: ₩${job['payment']}'),
            if (job['rating'] != null)
              Text('평점: ${job['rating']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}

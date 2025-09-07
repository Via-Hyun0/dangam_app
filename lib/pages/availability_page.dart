import 'package:flutter/material.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({super.key});

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  Map<String, List<bool>> _weeklyAvailability = {
    '월': [false, false, false, false, false, false, false, false],
    '화': [false, false, false, false, false, false, false, false],
    '수': [false, false, false, false, false, false, false, false],
    '목': [false, false, false, false, false, false, false, false],
    '금': [false, false, false, false, false, false, false, false],
    '토': [false, false, false, false, false, false, false, false],
    '일': [false, false, false, false, false, false, false, false],
  };

  final List<String> _timeSlots = [
    '06:00', '08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00'
  ];

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('가능 시간'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveAvailability,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 안내 메시지
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '근무 가능한 시간을 선택하세요. 고용주가 이 정보를 보고 작업을 제안할 수 있습니다.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF503123),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 시간표
            _buildAvailabilityTable(),
            
            const SizedBox(height: 24),
            
            // 빠른 설정
            _buildQuickSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  '요일',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF503123),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: _timeSlots.map((time) => Expanded(
                    child: Text(
                      time,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF503123),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 요일별 시간 선택
          ..._weeklyAvailability.entries.map((entry) => _buildDayRow(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildDayRow(String day, List<bool> availability) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              day,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF503123),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: availability.asMap().entries.map((entry) {
                final index = entry.key;
                final isAvailable = entry.value;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleAvailability(day, index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 32,
                      decoration: BoxDecoration(
                        color: isAvailable ? primary : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isAvailable ? primary : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isAvailable ? Icons.check : Icons.close,
                        color: isAvailable ? Colors.white : Colors.grey.shade400,
                        size: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSettings() {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '빠른 설정',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF503123),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildQuickSettingButton(
            title: '평일 오전 (08:00-12:00)',
            onTap: () => _setWeekdayMorning(),
          ),
          
          const SizedBox(height: 8),
          
          _buildQuickSettingButton(
            title: '평일 오후 (14:00-18:00)',
            onTap: () => _setWeekdayAfternoon(),
          ),
          
          const SizedBox(height: 8),
          
          _buildQuickSettingButton(
            title: '주말 전체',
            onTap: () => _setWeekend(),
          ),
          
          const SizedBox(height: 8),
          
          _buildQuickSettingButton(
            title: '전체 선택',
            onTap: () => _selectAll(),
          ),
          
          const SizedBox(height: 8),
          
          _buildQuickSettingButton(
            title: '전체 해제',
            onTap: () => _clearAll(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSettingButton({
    required String title,
    required VoidCallback onTap,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _toggleAvailability(String day, int timeIndex) {
    setState(() {
      _weeklyAvailability[day]![timeIndex] = !_weeklyAvailability[day]![timeIndex];
    });
  }

  void _setWeekdayMorning() {
    setState(() {
      for (int day = 0; day < 5; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        _weeklyAvailability[dayName]![1] = true; // 08:00
        _weeklyAvailability[dayName]![2] = true; // 10:00
      }
    });
  }

  void _setWeekdayAfternoon() {
    setState(() {
      for (int day = 0; day < 5; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        _weeklyAvailability[dayName]![3] = true; // 12:00
        _weeklyAvailability[dayName]![4] = true; // 14:00
        _weeklyAvailability[dayName]![5] = true; // 16:00
      }
    });
  }

  void _setWeekend() {
    setState(() {
      for (int day = 5; day < 7; day++) {
        final dayName = _weeklyAvailability.keys.elementAt(day);
        for (int i = 0; i < _weeklyAvailability[dayName]!.length; i++) {
          _weeklyAvailability[dayName]![i] = true;
        }
      }
    });
  }

  void _selectAll() {
    setState(() {
      for (String day in _weeklyAvailability.keys) {
        for (int i = 0; i < _weeklyAvailability[day]!.length; i++) {
          _weeklyAvailability[day]![i] = true;
        }
      }
    });
  }

  void _clearAll() {
    setState(() {
      for (String day in _weeklyAvailability.keys) {
        for (int i = 0; i < _weeklyAvailability[day]!.length; i++) {
          _weeklyAvailability[day]![i] = false;
        }
      }
    });
  }

  void _saveAvailability() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('가능 시간이 저장되었습니다'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }
}

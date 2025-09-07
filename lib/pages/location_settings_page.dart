import 'package:flutter/material.dart';

class LocationSettingsPage extends StatefulWidget {
  final String currentLocation;
  final Function(String) onLocationUpdated;

  const LocationSettingsPage({
    super.key,
    required this.currentLocation,
    required this.onLocationUpdated,
  });

  @override
  State<LocationSettingsPage> createState() => _LocationSettingsPageState();
}

class _LocationSettingsPageState extends State<LocationSettingsPage> {
  String _selectedLocation = '';
  List<String> _savedLocations = [];
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.currentLocation;
    _savedLocations = [
      '김제시 금구면',
      '김제시 봉남면',
      '김제시 부량면',
      '전주시 완산구',
      '익산시 망성면',
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('위치 설정'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF503123),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveLocation,
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
      body: Column(
        children: [
          // 검색 바
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: '지역을 검색하세요',
                prefixIcon: Icon(Icons.search, color: primary),
                suffixIcon: IconButton(
                  icon: Icon(Icons.my_location, color: primary),
                  onPressed: _getCurrentLocation,
                ),
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
            ),
          ),
          
          // 현재 위치
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: Colors.white,
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  '현재 위치: $_selectedLocation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF503123),
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // 검색 결과 또는 저장된 위치
          Expanded(
            child: _searchController.text.isNotEmpty
                ? _buildSearchResults()
                : _buildSavedLocations(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final location = _searchResults[index];
        return _buildLocationItem(
          location: location,
          isSelected: location == _selectedLocation,
          onTap: () => _selectLocation(location),
        );
      },
    );
  }

  Widget _buildSavedLocations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 저장된 위치 헤더
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                '저장된 위치',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF503123),
                ),
              ),
            ],
          ),
        ),
        
        // 저장된 위치 목록
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _savedLocations.length,
            itemBuilder: (context, index) {
              final location = _savedLocations[index];
              return _buildLocationItem(
                location: location,
                isSelected: location == _selectedLocation,
                onTap: () => _selectLocation(location),
                onDelete: () => _deleteLocation(location),
              );
            },
          ),
        ),
        
        // 인기 지역
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '인기 지역',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF503123),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  '김제시',
                  '전주시',
                  '익산시',
                  '군산시',
                  '정읍시',
                  '남원시',
                ].map((location) => _buildLocationChip(location)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationItem({
    required String location,
    required bool isSelected,
    required VoidCallback onTap,
    VoidCallback? onDelete,
  }) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(26, 199, 93, 49) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? primary : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? primary : Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF503123),
                    ),
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade400,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationChip(String location) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return GestureDetector(
      onTap: () => _selectLocation(location),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color.fromARGB(26, 199, 93, 49),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(77, 199, 93, 49),
            width: 1,
          ),
        ),
        child: Text(
          location,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _savedLocations
            .where((location) => location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectLocation(String location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _deleteLocation(String location) {
    setState(() {
      _savedLocations.remove(location);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$location이 삭제되었습니다'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _getCurrentLocation() {
    // 실제 앱에서는 GPS를 사용하여 현재 위치를 가져옴
    setState(() {
      _selectedLocation = '김제시 금구면';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('현재 위치를 가져왔습니다'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _saveLocation() {
    if (_selectedLocation.isNotEmpty) {
      widget.onLocationUpdated(_selectedLocation);
      
      if (!_savedLocations.contains(_selectedLocation)) {
        setState(() {
          _savedLocations.insert(0, _selectedLocation);
        });
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치가 저장되었습니다'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }
}

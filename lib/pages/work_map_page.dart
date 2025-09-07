import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dangam_app/data/mock_jobs.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/pages/job_detail_page.dart';

class WorkMapPage extends StatefulWidget {
  const WorkMapPage({super.key});

  @override
  State<WorkMapPage> createState() => _WorkMapPageState();
}

class _WorkMapPageState extends State<WorkMapPage> {
  Set<Marker> _markers = {};
  String _selectedFilter = 'all';
  double _searchRadius = 10.0; // km

  // 김제 중심 위치
  static const LatLng _userLocation = LatLng(35.8019, 126.8888);

  @override
  void initState() {
    super.initState();
    _loadJobMarkers();
  }

  void _loadJobMarkers() {
    Set<Marker> markers = {};

    for (int i = 0; i < mockJobs.length; i++) {
      final job = mockJobs[i];

      // Filter jobs based on selected filter
      if (_selectedFilter != 'all' &&
          job.type.toString().split('.').last != _selectedFilter) {
        continue;
      }

      // Mock coordinates around user location
      final lat = _userLocation.latitude + (i * 0.01 - 0.05);
      final lng = _userLocation.longitude + (i * 0.01 - 0.05);

      markers.add(
        Marker(
          markerId: MarkerId(job.id),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: job.title,
            snippet:
                '${jobTypeLabel(job.type)} • ${job.distanceKm.toStringAsFixed(1)} km',
          ),
          onTap: () => _showJobDetails(job),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  void _showJobDetails(Job job) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => JobDetailPage(job: job),
      ),
    );
  }

  void _onFilterChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedFilter = value;
        _loadJobMarkers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _userLocation,
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              // Map controller is available if needed for future features
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),

          // Top search and filter bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search radius
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '검색 반경',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF503123),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: primary,
                            inactiveTrackColor: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.2),
                            thumbColor: primary,
                            overlayColor: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                          ),
                          child: Slider(
                            value: _searchRadius,
                            min: 1.0,
                            max: 50.0,
                            divisions: 49,
                            label: '${_searchRadius.round()}km',
                            onChanged: (value) {
                              setState(() {
                                _searchRadius = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_searchRadius.round()}km',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChip(
                          label: '전체',
                          isSelected: _selectedFilter == 'all',
                          onTap: () => _onFilterChanged('all'),
                        ),
                        const SizedBox(width: 8),
                        ...JobType.values.take(5).map((type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _FilterChip(
                            label: jobTypeLabel(type),
                            isSelected: _selectedFilter == type.toString().split('.').last,
                            onTap: () => _onFilterChanged(type.toString().split('.').last),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom job list
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -8),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '근처 작업',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF503123),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_markers.length}개',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Job list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _markers.length,
                      itemBuilder: (context, index) {
                        final job = mockJobs[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: () => _showJobDetails(job),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.04),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.work_outline,
                                        color: primary,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            job.title,
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF503123),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(jobStatusColor(job.status).red, jobStatusColor(job.status).green, jobStatusColor(job.status).blue, 0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  jobStatusLabel(job.status),
                                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                    color: jobStatusColor(job.status),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${job.distanceKm.toStringAsFixed(1)}km',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: const Color(0xFFa48e7b),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.6),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary : Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : Color.fromRGBO(primary.red, primary.green, primary.blue, 0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected ? Colors.white : primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

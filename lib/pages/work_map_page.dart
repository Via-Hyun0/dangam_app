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

  // Mock user location (Sydney, Australia)
  static const LatLng _userLocation = LatLng(-33.8688, 151.2093);

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
    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _userLocation,
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              // Map controller is available if needed for future features
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),

          // Top controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search radius slider
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 8),
                      const Text('Search radius:'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Slider(
                          value: _searchRadius,
                          min: 1.0,
                          max: 50.0,
                          divisions: 49,
                          label: '${_searchRadius.round()} km',
                          onChanged: (value) {
                            setState(() {
                              _searchRadius = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Filter dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedFilter,
                    decoration: const InputDecoration(
                      labelText: 'Filter by job type',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'all',
                        child: Text('All types'),
                      ),
                      ...JobType.values.map((type) => DropdownMenuItem(
                            value: type.toString().split('.').last,
                            child: Text(jobTypeLabel(type)),
                          )),
                    ],
                    onChanged: _onFilterChanged,
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
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Job list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _markers.length,
                      itemBuilder: (context, index) {
                        final job = mockJobs[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () => _showJobDetails(job),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.work_outline,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${jobTypeLabel(job.type)} • ${job.distanceKm.toStringAsFixed(1)} km',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right,
                                      color: Colors.grey),
                                ],
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

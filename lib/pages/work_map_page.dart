import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dangam_app/data/mock_jobs.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/pages/job_detail_page.dart';
import 'package:dangam_app/theme/app_colors.dart';
import 'package:dangam_app/theme/app_typography.dart';
import 'package:dangam_app/theme/app_spacing.dart';

/// 작업 지도 페이지
/// 
/// 디자이너 가이드:
/// - 이 페이지는 지도에서 작업 위치를 표시합니다
/// - 필터링과 검색 기능을 제공합니다
/// - 작업 목록을 하단에서 확인할 수 있습니다
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
      
      // 필터링
      if (_selectedFilter != 'all' && 
          job.type.toString().split('.').last != _selectedFilter) {
        continue;
      }

      // 거리 필터링 (실제로는 지리적 계산이 필요하지만 여기서는 간단히 처리)
      if (job.distanceKm > _searchRadius) {
        continue;
      }

      markers.add(
        Marker(
          markerId: MarkerId('job_$i'),
          position: LatLng(
            _userLocation.latitude + (job.distanceKm * 0.01),
            _userLocation.longitude + (job.distanceKm * 0.01),
          ),
          infoWindow: InfoWindow(
            title: job.title,
            snippet: '${job.distanceKm.toStringAsFixed(1)}km',
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
        builder: (context) => JobDetailPage(job: job),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 지도
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _userLocation,
              zoom: 12.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              // 지도 생성 완료
            },
          ),
          
          // 상단 필터 바
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.lg,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: _FilterBar(
              selectedFilter: _selectedFilter,
              searchRadius: _searchRadius,
              onFilterChanged: (filter) {
                setState(() {
                  _selectedFilter = filter;
                  _loadJobMarkers();
                });
              },
              onRadiusChanged: (radius) {
                setState(() {
                  _searchRadius = radius;
                  _loadJobMarkers();
                });
              },
            ),
          ),
          
          // 하단 작업 목록
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _JobListBottomSheet(
              jobs: _getFilteredJobs(),
              onJobTap: _showJobDetails,
            ),
          ),
        ],
      ),
    );
  }

  List<Job> _getFilteredJobs() {
    return mockJobs.where((job) {
      final matchesFilter = _selectedFilter == 'all' || 
          job.type.toString().split('.').last == _selectedFilter;
      final matchesRadius = job.distanceKm <= _searchRadius;
      return matchesFilter && matchesRadius;
    }).toList();
  }
}

/// 필터 바 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 지도의 필터링 옵션을 제공합니다
/// - 작업 유형과 검색 반경을 설정할 수 있습니다
class _FilterBar extends StatelessWidget {
  final String selectedFilter;
  final double searchRadius;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<double> onRadiusChanged;

  const _FilterBar({
    required this.selectedFilter,
    required this.searchRadius,
    required this.onFilterChanged,
    required this.onRadiusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 검색 반경 슬라이더
          Row(
            children: [
              Icon(
                Icons.location_searching,
                color: AppColors.primary,
                size: AppSpacing.iconMedium,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '검색 반경',
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkAccent,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Slider(
                  value: searchRadius,
                  min: 1.0,
                  max: 50.0,
                  divisions: 49,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primaryLightest,
                  onChanged: onRadiusChanged,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLighter,
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
                child: Text(
                  '${searchRadius.toInt()}km',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // 작업 유형 필터
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: '전체',
                  isSelected: selectedFilter == 'all',
                  onTap: () => onFilterChanged('all'),
                ),
                const SizedBox(width: AppSpacing.md),
                ...JobType.values.take(5).map((type) => Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: _FilterChip(
                    label: jobTypeLabel(type),
                    isSelected: selectedFilter == type.toString().split('.').last,
                    onTap: () => onFilterChanged(type.toString().split('.').last),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 필터 칩 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 필터 옵션을 칩 형태로 표시합니다
/// - 선택된 상태와 선택되지 않은 상태를 구분합니다
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.primaryLighter,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.primaryLightest,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 작업 목록 하단 시트 위젯
/// 
/// 디자이너 가이드:
/// - 이 위젯은 하단에서 작업 목록을 표시합니다
/// - 드래그하여 크기를 조절할 수 있습니다
class _JobListBottomSheet extends StatelessWidget {
  final List<Job> jobs;
  final Function(Job) onJobTap;

  const _JobListBottomSheet({
    required this.jobs,
    required this.onJobTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white,
            AppColors.background,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 드래그 핸들
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryMuted,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
          ),
          
          // 헤더
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  '근처 작업',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkAccent,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLighter,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                  child: Text(
                    '${jobs.length}개',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // 작업 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    child: InkWell(
                      onTap: () => onJobTap(job),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                          border: Border.all(
                            color: AppColors.primaryLighter,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 작업 유형 아이콘
                            Container(
                              width: AppSpacing.iconLarge + AppSpacing.md,
                              height: AppSpacing.iconLarge + AppSpacing.md,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLighter,
                                borderRadius: BorderRadius.circular(AppSpacing.sm),
                              ),
                              child: Icon(
                                Icons.work_outline,
                                color: AppColors.primary,
                                size: AppSpacing.iconMedium,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title,
                                    style: AppTypography.titleSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkAccent,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.md,
                                          vertical: AppSpacing.xs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.successLight,
                                          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                                        ),
                                        child: Text(
                                          jobStatusLabel(job.status),
                                          style: AppTypography.labelSmall.copyWith(
                                            color: jobStatusColor(job.status),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Text(
                                        jobTypeLabel(job.type),
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // 거리
                            Text(
                              '${job.distanceKm.toStringAsFixed(1)}km',
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
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
    );
  }
}
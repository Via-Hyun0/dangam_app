import 'package:flutter/material.dart';
import 'package:dangam_app/data/mock_jobs.dart';
import 'package:dangam_app/models/job.dart';
import 'package:dangam_app/pages/job_detail_page.dart';

class JobsBody extends StatefulWidget {
  const JobsBody({super.key});

  @override
  State<JobsBody> createState() => _JobsBodyState();
}

class _JobsBodyState extends State<JobsBody> {
  String _sortBy = 'distance'; // distance, date, type
  String _filterType = 'all'; // all, harvesting, planting, etc.

  List<Job> get _filteredJobs {
    List<Job> jobs = List.from(mockJobs);

    // Filter by type
    if (_filterType != 'all') {
      jobs = jobs
          .where((job) => job.type.toString().split('.').last == _filterType)
          .toList();
    }

    // Sort
    switch (_sortBy) {
      case 'distance':
        jobs.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case 'date':
        jobs.sort((a, b) {
          if (a.scheduledDate == null && b.scheduledDate == null) return 0;
          if (a.scheduledDate == null) return 1;
          if (b.scheduledDate == null) return -1;
          return a.scheduledDate!.compareTo(b.scheduledDate!);
        });
        break;
      case 'type':
        jobs.sort((a, b) => a.type.toString().compareTo(b.type.toString()));
        break;
    }

    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter and Sort Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: [
              // Filter dropdown
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _filterType,
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem(
                            value: 'all', child: Text('모든 유형')),
                        ...JobType.values.map((type) => DropdownMenuItem(
                              value: type.toString().split('.').last,
                              child: Text(jobTypeLabel(type)),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _filterType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sort dropdown
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sortBy,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: 'distance', child: Text('거리')),
                        DropdownMenuItem(value: 'date', child: Text('날짜')),
                        DropdownMenuItem(value: 'type', child: Text('유형')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _sortBy = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Jobs List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final Job job = _filteredJobs[index];
              final Color primary = Theme.of(context).colorScheme.primary;
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
                      );
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.grey.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: primary.withOpacity(0.1),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with icon and status
                            Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        primary,
                                        primary.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withOpacity(0.3),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.work_outline,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.title,
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF503123),
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(24),
                                          border: Border.all(
                                            color: primary.withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          jobTypeLabel(job.type),
                                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: primary.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: primary,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${job.distanceKm.toStringAsFixed(1)}km',
                                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Job details
                            Row(
                              children: [
                                Expanded(
                                  child: _DetailChip(
                                    icon: Icons.agriculture_outlined,
                                    label: job.crop,
                                    color: const Color(0xFFa48e7b),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _DetailChip(
                                    icon: Icons.straighten_outlined,
                                    label: '${job.areaHectares.toStringAsFixed(1)} ha',
                                    color: const Color(0xFFa48e7b),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _DetailChip(
                                    icon: Icons.calendar_today_outlined,
                                    label: job.scheduledDate != null 
                                        ? _formatDate(job.scheduledDate!)
                                        : 'TBD',
                                    color: const Color(0xFFa48e7b),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Location
                            Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: const Color(0xFFa48e7b),
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    job.location,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFFa48e7b),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Equipment tags
                            if (job.requiredEquipment.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              Text(
                                '필요 장비',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFF503123),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: job.requiredEquipment
                                    .map((equipment) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                primary.withOpacity(0.1),
                                                primary.withOpacity(0.05),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: primary.withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            equipment,
                                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                              color: primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                            
                            const SizedBox(height: 24),
                            
                            // Action button
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    primary,
                                    primary.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '자세히 보기',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: _filteredJobs.length,
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DetailChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

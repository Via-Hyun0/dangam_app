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
                margin: const EdgeInsets.only(bottom: 16),
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with title and status
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.title,
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF503123),
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            jobTypeLabel(job.type),
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(jobStatusColor(job.status).red, jobStatusColor(job.status).green, jobStatusColor(job.status).blue, 0.1),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Color.fromRGBO(jobStatusColor(job.status).red, jobStatusColor(job.status).green, jobStatusColor(job.status).blue, 0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              jobStatusLabel(job.status),
                                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: jobStatusColor(job.status),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: primary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${job.distanceKm.toStringAsFixed(1)}km',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Key information
                            Row(
                              children: [
                                Expanded(
                                  child: _InfoItem(
                                    icon: Icons.agriculture_outlined,
                                    label: '작물',
                                    value: job.crop,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _InfoItem(
                                    icon: Icons.straighten_outlined,
                                    label: '면적',
                                    value: '${job.areaHectares.toStringAsFixed(1)} ha',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _InfoItem(
                                    icon: Icons.calendar_today_outlined,
                                    label: '날짜',
                                    value: job.scheduledDate != null 
                                        ? _formatDate(job.scheduledDate!)
                                        : '미정',
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Location
                            Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: const Color(0xFFa48e7b),
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    job.location,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFa48e7b),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Equipment tags (only if not empty)
                            if (job.requiredEquipment.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: job.requiredEquipment
                                    .map((equipment) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(primary.red, primary.green, primary.blue, 0.1),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            equipment,
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFa48e7b),
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFFa48e7b),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF503123),
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

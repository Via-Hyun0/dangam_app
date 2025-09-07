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
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final Job job = _filteredJobs[index];
              final Color primary = Theme.of(context).colorScheme.primary;
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => JobDetailPage(job: job)),
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.work_outline, color: primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(job.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text(
                              '${jobTypeLabel(job.type)} • ${job.crop} • ${job.areaHectares.toStringAsFixed(1)} ha',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${job.location} • ${job.distanceKm.toStringAsFixed(1)} km',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            if (job.requiredEquipment.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: job.requiredEquipment
                                      .map((e) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: primary.withValues(
                                                  alpha: 0.08),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                color: primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (job.scheduledDate != null)
                            Text(
                              _formatDate(job.scheduledDate!),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
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

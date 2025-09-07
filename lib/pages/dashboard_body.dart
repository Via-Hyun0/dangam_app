import 'package:flutter/material.dart';
import 'package:farm_work_app/data/mock_notices.dart';
import 'package:farm_work_app/data/mock_jobs.dart';
import 'package:farm_work_app/models/job.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header with stats
          _WelcomeHeader(),
          const SizedBox(height: 24),

          const _SectionTitle('공지사항'),
          const SizedBox(height: 10),
          const _NoticesList(),
          const SizedBox(height: 24),

          const _SectionTitle('Ongoing contracts'),
          const SizedBox(height: 10),
          _OngoingContractsList(),
          const SizedBox(height: 24),

          const _SectionTitle('Nearby opportunities'),
          const SizedBox(height: 10),
          const _HorizontalChipsCarousel(kind: _CarouselKind.opportunity),
          const SizedBox(height: 24),

          const _SectionTitle('Nearby providers'),
          const SizedBox(height: 10),
          const _HorizontalChipsCarousel(kind: _CarouselKind.provider),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ready to find your next farm work opportunity?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _StatItem(
                icon: Icons.assignment_turned_in,
                label: 'Active Contracts',
                value: '2',
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              _StatItem(
                icon: Icons.work_outline,
                label: 'Available Jobs',
                value: '${mockJobs.length}',
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              _StatItem(
                icon: Icons.location_on,
                label: 'Nearby',
                value: '5',
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color.withValues(alpha: 0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }
}

enum _CarouselKind { opportunity, provider }

class _OngoingContractsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    // Mock ongoing contracts data
    final List<Map<String, dynamic>> contracts = [
      {
        'title': 'Wheat Harvesting - Greenfield Farm',
        'status': 'In Progress',
        'daysLeft': 3,
        'progress': 0.7,
        'employer': 'Greenfield Farm',
        'type': 'Harvesting',
      },
      {
        'title': 'Soil Preparation - Valley Agriculture',
        'status': 'Pending Start',
        'daysLeft': 7,
        'progress': 0.0,
        'employer': 'Valley Agriculture',
        'type': 'Soil Preparation',
      },
    ];

    return Column(
      children: contracts.map((contract) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.assignment_turned_in_outlined,
                        color: primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contract['title'],
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${contract['status']} • ${contract['daysLeft']} days left',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${contract['employer']} • ${contract['type']}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              if (contract['progress'] > 0) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: contract['progress'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(contract['progress'] * 100).round()}% complete',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _NoticesList extends StatelessWidget {
  const _NoticesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mockNotices.take(3).map((notice) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: noticeTypeColor(notice.type),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: noticeTypeColor(notice.type)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            noticeTypeLabel(notice.type),
                            style: TextStyle(
                              color: noticeTypeColor(notice.type),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(notice.publishedAt),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notice.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notice.content,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        );
      }).toList(),
    );
  }
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Yesterday';
  if (difference < 7) return '${difference}d ago';
  return '${date.month}/${date.day}';
}

class _HorizontalChipsCarousel extends StatelessWidget {
  final _CarouselKind kind;
  const _HorizontalChipsCarousel({required this.kind});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    // Get relevant jobs for opportunities, mock providers for providers
    final List<dynamic> items = kind == _CarouselKind.opportunity
        ? mockJobs.take(6).toList()
        : _getMockProviders();

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final bool alt = index.isOdd;

          return Container(
            width: 220,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: alt ? Colors.black : primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        kind == _CarouselKind.opportunity
                            ? Icons.work_outline
                            : Icons.person_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        kind == _CarouselKind.opportunity
                            ? jobTypeLabel(item.type)
                            : item['type'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  kind == _CarouselKind.opportunity ? item.title : item['name'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  kind == _CarouselKind.opportunity
                      ? '${item.location} • ${item.distanceKm.toStringAsFixed(1)} km'
                      : '${item['location']} • ${item['rating']}★',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (kind == _CarouselKind.opportunity &&
                    item.scheduledDate != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Due: ${_formatJobDate(item.scheduledDate!)}',
                    style: const TextStyle(color: Colors.white60, fontSize: 9),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getMockProviders() {
    return [
      {
        'name': 'Greenfield Farm Services',
        'type': 'Harvesting',
        'location': 'North Valley',
        'rating': '4.8',
      },
      {
        'name': 'Valley Agriculture Co.',
        'type': 'Soil Preparation',
        'location': 'East Hills',
        'rating': '4.6',
      },
      {
        'name': 'Mountain Crop Care',
        'type': 'Planting',
        'location': 'West Range',
        'rating': '4.9',
      },
      {
        'name': 'River Farm Solutions',
        'type': 'Irrigation',
        'location': 'South Plains',
        'rating': '4.7',
      },
      {
        'name': 'Hilltop Harvesting',
        'type': 'Harvesting',
        'location': 'Central Valley',
        'rating': '4.5',
      },
      {
        'name': 'Sunrise Agriculture',
        'type': 'Planting',
        'location': 'North Ridge',
        'rating': '4.8',
      },
    ];
  }
}

String _formatJobDate(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Tomorrow';
  if (difference < 7) return 'In $difference days';
  return '${date.month}/${date.day}';
}

// Removed _TrustPillarsRow (not used currently)

// Removed _PillarCard (not used)

// Removed _ActionCard (replaced by recommendations carousel)

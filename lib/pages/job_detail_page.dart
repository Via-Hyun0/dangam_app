import 'package:flutter/material.dart';
import 'package:dangam_app/models/job.dart';

class JobDetailPage extends StatelessWidget {
  final Job job;
  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: const Text('Job details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Row(
              children: [
                _InfoChip(
                    icon: Icons.category_outlined,
                    label: jobTypeLabel(job.type),
                    color: primary),
                const SizedBox(width: 8),
                _InfoChip(
                    icon: Icons.eco_outlined, label: job.crop, color: primary),
                const SizedBox(width: 8),
                _InfoChip(
                    icon: Icons.square_foot_outlined,
                    label: '${job.areaHectares.toStringAsFixed(1)} ha',
                    color: primary),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.place_outlined),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(
                        '${job.location} • ${job.distanceKm.toStringAsFixed(1)} km')),
              ],
            ),
            const SizedBox(height: 10),
            if (job.scheduledDate != null)
              Row(
                children: [
                  const Icon(Icons.event_outlined),
                  const SizedBox(width: 6),
                  Text(_formatDate(job.scheduledDate!)),
                ],
              ),
            const SizedBox(height: 16),
            const Text('Required equipment',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            if (job.requiredEquipment.isEmpty)
              const Text('None specified', style: TextStyle(color: Colors.grey))
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.requiredEquipment
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(e,
                              style: TextStyle(
                                  color: primary, fontWeight: FontWeight.w700)),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showContractDialog(context, job, false),
                    icon: const Icon(Icons.close),
                    label: const Text('Not interested'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showContractDialog(context, job, true),
                    icon: const Icon(Icons.check),
                    label: const Text('Express interest'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

String _formatDate(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

void _showContractDialog(BuildContext context, Job job, bool isInterested) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isInterested ? 'Express Interest' : 'Not Interested'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isInterested
                ? 'Send a message to ${job.employerName} about this job?'
                : 'Are you sure you\'re not interested in this job?',
          ),
          if (isInterested) ...[
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Message (optional)',
                border: OutlineInputBorder(),
                hintText: 'Tell them why you\'re interested...',
              ),
              maxLines: 3,
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _showSuccessMessage(context, isInterested);
          },
          child: Text(isInterested ? 'Send Interest' : 'Confirm'),
        ),
      ],
    ),
  );
}

void _showSuccessMessage(BuildContext context, bool isInterested) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isInterested
            ? 'Interest expressed! You\'ll be notified of updates.'
            : 'Noted. We\'ll show you similar opportunities.',
      ),
      backgroundColor: isInterested ? Colors.green : Colors.orange,
    ),
  );
}

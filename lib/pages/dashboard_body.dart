import 'package:flutter/material.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

// Removed legacy/unused widgets

// Removed _QuickActionButton (no longer used)

// Removed _StatsGrid (replaced by _TrustPillarsRow)

// Removed _StatCard (superseded by trust pillar cards)

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
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: index == 2 ? 0 : 12),
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
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Icon(Icons.assignment_turned_in_outlined, color: primary),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contract in progress',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('Awaiting update • Due in 3 days',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        );
      }),
    );
  }
}

class _HorizontalChipsCarousel extends StatelessWidget {
  final _CarouselKind kind;
  const _HorizontalChipsCarousel({required this.kind});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final bool alt = index.isOdd;
          return Container(
            width: 200,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: alt ? Colors.black : primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    kind == _CarouselKind.opportunity
                        ? Icons.work_outline
                        : Icons.person_outline,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kind == _CarouselKind.opportunity
                            ? 'Nearby job'
                            : 'Nearby provider',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '2 km • Good match',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Removed _TrustPillarsRow (not used currently)

// Removed _PillarCard (not used)

// Removed _ActionCard (replaced by recommendations carousel)

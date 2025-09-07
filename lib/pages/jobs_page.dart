import 'package:flutter/material.dart';

class JobsBody extends StatelessWidget {
  const JobsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            child: Icon(Icons.work_outline,
                color: Theme.of(context).colorScheme.primary),
          ),
          title: Text('Opportunity #${index + 1}'),
          subtitle: const Text('Nearby • Details on tap'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: 10,
    );
  }
}

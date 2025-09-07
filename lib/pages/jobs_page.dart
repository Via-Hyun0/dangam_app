import 'package:flutter/material.dart';

class JobsBody extends StatelessWidget {
  const JobsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.agriculture_outlined, color: Colors.green),
          title: Text('Farm Job #${index + 1}'),
          subtitle: const Text('Location: Nearby • Pay: Negotiable'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: 10,
    );
  }
}

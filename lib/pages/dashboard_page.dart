import 'package:flutter/material.dart';
import 'package:farm_work_app/widgets/mobile_layout.dart';
import 'package:farm_work_app/pages/dashboard_body.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileLayout(
      title: 'Dashboard',
      body: DashboardBody(),
    );
  }
}

import 'package:flutter/material.dart';

class MechanicDashboardPage extends StatefulWidget {
  const MechanicDashboardPage({Key? key}) : super(key: key);

  @override
  State<MechanicDashboardPage> createState() => _MechanicDashboardPageState();
}

class _MechanicDashboardPageState extends State<MechanicDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Mechanic Dashboard Page'),
      ),
    );
  }
}

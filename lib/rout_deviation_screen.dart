import 'package:flutter/material.dart';

class RouteDeviationScreen extends StatelessWidget {
  const RouteDeviationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Route Deviation Alert")),
      body: Center(
        child: Text("Route Monitoring Coming Soon!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FakeCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fake Call")),
      body: Center(
        child: Text("Fake Call Feature Coming Soon!", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
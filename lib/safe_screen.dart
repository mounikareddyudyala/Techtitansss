import 'package:flutter/material.dart';

class SafeScreen extends StatelessWidget {
  const SafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Make sure you're safe!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Return to HomeScreen
              },
              child: Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

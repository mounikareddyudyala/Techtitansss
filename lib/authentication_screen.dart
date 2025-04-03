import 'package:flutter/material.dart';
import 'dart:async';
import '../email_login_screen.dart';
import '../phone_login_screen.dart';
import 'contact_permission_screen.dart'; // ✅ Next screen after 30 seconds

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Navigate to Contact Selection after 30 sec
    Timer(Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ContactPermissionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLoginScreen()),
                );
              },
              child: Text('Login with Email/Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
                );
              },
              child: Text('Login with Phone Number'),
            ),
            SizedBox(height: 20),
            Text(
              "Auto redirecting in 30 seconds...",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

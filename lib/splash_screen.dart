import 'package:flutter/material.dart';
import 'dart:async';
import 'authentication_screen.dart'; // ✅ Ensure this file exists

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    print("🔹 Splash Screen Started");

    // ✅ Navigate to AuthenticationScreen after 20 seconds
    Timer(Duration(seconds: 20), () {
      print("✅ Navigating to AuthenticationScreen");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthenticationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background1"), // ✅ Ensure this file exists
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/logo.JPG", // Ensure this image exists
                width: 500,
                height: 500,
              ),
              SizedBox(height: 100),
              Text(
                "Welcome to The SafeWay!",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

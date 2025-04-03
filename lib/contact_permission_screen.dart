import 'package:flutter/material.dart';
import 'dart:async';
import '../home_screen.dart'; // ✅ Next screen
import 'package:permission_handler/permission_handler.dart';

class ContactPermissionScreen extends StatefulWidget {
  const ContactPermissionScreen({super.key});

  @override
  _ContactPermissionScreenState createState() => _ContactPermissionScreenState();
}

class _ContactPermissionScreenState extends State<ContactPermissionScreen> {
  @override
  void initState() {
    super.initState();
    _requestContactsPermission();

    // ✅ Navigate to Home Screen after 20 sec
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  Future<void> _requestContactsPermission() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      print("✅ Contacts permission granted!");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Contacts permission is required!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Allow Contacts")),
      body: Center(
        child: ElevatedButton(
          onPressed: _requestContactsPermission,
          child: Text("Allow Contacts Access"),
        ),
      ),
    );
  }
}

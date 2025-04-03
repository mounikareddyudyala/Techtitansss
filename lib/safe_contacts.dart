import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetyFeatures extends StatelessWidget {
  final List<Map<String, String>> emergencyContacts = [
    {'name': 'Emergency Hotline', 'number': '112'},
    {'name': 'Fire Department', 'number': '101'},
    {'name': 'Ambulance', 'number': '102'},
  ];

  final List<Map<String, String>> policeStations = [
    {'name': 'Central Police Station', 'number': '1001'},
    {'name': 'North Police Station', 'number': '1002'},
  ];

  final List<Map<String, String>> hospitals = [
    {'name': 'City Hospital', 'number': '2001'},
    {'name': 'General Hospital', 'number': '2002'},
  ];

  SafetyFeatures({super.key});

  Future<void> _makeCall(BuildContext context, String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Features'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          _buildSection(context, '🚨 Emergency Contacts', emergencyContacts, Colors.redAccent),
          _buildSection(context, '🚔 Police Stations', policeStations, Colors.blue),
          _buildSection(context, '🏥 Hospitals', hospitals, Colors.green),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Map<String, String>> contacts, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            const Divider(),
            ...contacts.map((contact) => ListTile(
                  leading: Icon(Icons.phone, color: color),
                  title: Text(contact['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(contact['number']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.black),
                    onPressed: () => _makeCall(context, contact['number']!),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

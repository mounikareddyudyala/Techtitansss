import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class SOSButton extends StatelessWidget {
  final String phoneNumber = "+1234567890"; // Replace with actual emergency contact
  final String emergencyMessage =
      "🚨 I am in DANGER! Please help me. My last known location: https://maps.google.com/?q=37.7749,-122.4194";

  const SOSButton({super.key});

  // Request necessary permissions
  Future<void> _requestPermissions() async {
    await [
      Permission.sms,
      Permission.phone,
    ].request();
  }

  // Send SOS SMS
  Future<void> _sendSOS(BuildContext context) async {
    await _requestPermissions();
    final Telephony telephony = Telephony.instance;

    bool? isPermissionGranted = await telephony.requestSmsPermissions;

    if (isPermissionGranted == true) {
      try {
        telephony.sendSms(
          to: phoneNumber,
          message: emergencyMessage,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ SOS message sent successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Failed to send SOS message: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ SMS permission denied")),
      );
    }
  }

  // Make an emergency call
  Future<void> _makeCall(BuildContext context) async {
    await _requestPermissions();

    final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Could not make a call")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _sendSOS(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.sms, size: 24),
          label: const Text("Send SOS SMS", style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => _makeCall(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          icon: const Icon(Icons.call, size: 24),
          label: const Text("Call Emergency Contact", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}

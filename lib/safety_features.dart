import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'live_location_screen.dart';
import 'panic_alarm_screen.dart';
import 'fake_call_screen.dart';
import 'emergency_contacts_screen.dart';


class SafetyFeaturesScreen extends StatelessWidget {
  const SafetyFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Safety Features",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFeatureButton(
                context,
                title: "📍 Live Location Sharing",
                color: Colors.green,
                screen: LiveLocationScreen(),
              ),
              _buildFeatureButton(
                context,
                title: "📢 Panic Alarm",
                color: Colors.red,
                screen: PanicAlarmScreen(),
              ),
              _buildFeatureButton(
                context,
                title: "📞 Fake Call",
                color: Colors.orange,
                screen: FakeCallScreen(),
              ),
              _buildFeatureButton(
                context,
                title: "👥 Emergency Contacts",
                color: Colors.purple,
                screen: EmergencyContactsScreen(),
              ),
              _buildFeatureButton(
                context,
                title: "🚔 Police & Hospital Contacts",
                color: Colors.blueGrey,
                screen: SafeContacts(), // Ensure SafeContacts is correctly implemented
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable button widget
  Widget _buildFeatureButton(BuildContext context, {required String title, required Color color, required Widget screen}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class SafeContacts extends StatelessWidget {
  const SafeContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Police & Hospital Contacts",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text(
          "Safe Contacts Screen Content",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
    );
  }
}

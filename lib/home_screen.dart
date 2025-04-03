import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import '../sos_button.dart';
import '../safety_features.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _locationMessage = "Fetching location...";
  StreamSubscription<Position>? _positionStream; // Stream for live location updates

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get location when screen loads
  }

  // ✅ Function to get current location once
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateLocationMessage("Location services are disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _updateLocationMessage("Location permission denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _updateLocationMessage("Location permission permanently denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _updateLocationMessage("Lat: ${position.latitude}, Lng: ${position.longitude}");
    } catch (e) {
      _updateLocationMessage("Error getting location: $e");
    }
  }

  // ✅ Start Live Location Tracking
  void _startLiveLocationUpdates() {
    _positionStream?.cancel(); // Stop previous stream if exists

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Updates when user moves 10 meters
    );

    _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        _updateLocationMessage("Lat: ${position.latitude}, Lng: ${position.longitude}");
      },
      onError: (e) {
        _updateLocationMessage("Error getting location: $e");
      },
    );
  }

  // ✅ Stop Live Location Updates
  void _stopLiveLocationUpdates() {
    _positionStream?.cancel();
    _updateLocationMessage("Live tracking stopped.");
  }

  void _updateLocationMessage(String message) {
    setState(() {
      _locationMessage = message;
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // Cancel live updates when screen closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildMainContent(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startLiveLocationUpdates,
        label: Text("Live Location"),
        icon: Icon(Icons.my_location),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  // ✅ Background Image
  Widget _buildBackground() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ✅ Main Content
  Widget _buildMainContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SOSButton(),
            SizedBox(height: 40),
            _buildLiveLocationPreview(),
            SizedBox(height: 40),
            _buildSafetyFeaturesButton(),
            SizedBox(height: 20),
            _buildStopTrackingButton(), // Button to stop tracking
          ],
        ),
      ),
    );
  }

  // ✅ Live Location Preview
  Widget _buildLiveLocationPreview() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Live Location Preview",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Icon(Icons.location_on, color: Colors.redAccent, size: 50),
          SizedBox(height: 8),
          Text(
            _locationMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ✅ Navigation Button to Safety Features
  Widget _buildSafetyFeaturesButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SafetyFeaturesScreen()),
        );
      },
      icon: Icon(Icons.shield, color: Colors.white, size: 24),
      label: Text("Go to Safety Features"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ✅ Stop Live Location Tracking Button
  Widget _buildStopTrackingButton() {
    return ElevatedButton.icon(
      onPressed: _stopLiveLocationUpdates,
      icon: Icon(Icons.stop_circle, color: Colors.white, size: 24),
      label: Text("Stop Live Tracking"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

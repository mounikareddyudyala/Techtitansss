import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PanicAlarmScreen extends StatefulWidget {
  const PanicAlarmScreen({super.key});

  @override
  _PanicAlarmScreenState createState() => _PanicAlarmScreenState();
}

class _PanicAlarmScreenState extends State<PanicAlarmScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playAlarm() async {
    await _audioPlayer.play(AssetSource('assets/alarm.mp3')); // Ensure alarm.mp3 is in assets folder
  }

  void _stopAlarm() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panic Alarm"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _playAlarm,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text("Play Alarm"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopAlarm,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text("Stop Alarm"),
            ),
          ],
        ),
      ),
    );
  }
}

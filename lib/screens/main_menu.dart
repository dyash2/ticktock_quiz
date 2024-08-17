import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'clock_game.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late AudioPlayer _audioPlayer;
  double _volume = 1.0; // Default volume

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set the audio to loop
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.play(AssetSource('game_music.mp3'), volume: _volume); // Play your audio file
  }

  void _setVolume(double volume) {
    setState(() {
      _volume = volume;
      _audioPlayer.setVolume(volume); // Update the volume
    });
  }

  void _toggleMute() {
    setState(() {
      if (_volume > 0) {
        _setVolume(0);
      } else {
        _setVolume(1.0); // Restore volume to full if muted
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when the screen is removed
    super.dispose();
  }

  void _openSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Volume', style: GoogleFonts.poppins(color: Colors.black)),
              Slider(
                value: _volume,
                onChanged: _setVolume,
                min: 0,
                max: 1,
                divisions: 10,
                label: '${(_volume * 100).round()}%',
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleMute,
                child: Text(
                  _volume > 0 ? 'Mute' : 'Unmute',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/game_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/main_icon.png", scale: 1),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.settings, color: Colors.white),
                        onPressed: _openSettingsDialog,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: PushableButton(
                        height: 60,
                        elevation: 8,
                        hslColor: const HSLColor.fromAHSL(1.0, 356, 1.0, 0.43),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          'Quit'.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 80),
                    SizedBox(
                      width: 180,
                      child: PushableButton(
                        height: 60,
                        elevation: 8,
                        hslColor: const HSLColor.fromAHSL(1.0, 120, 1.0, 0.37),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ClockGame()),
                          );
                        },
                        child: Text(
                          'Play'.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

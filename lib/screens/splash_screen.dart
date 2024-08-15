
import 'package:clock_game/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
    _playLoadingAudio();
    _navigateToHome();
  }

  void _playLoadingAudio() async {
    // Play the loading audio file
    await _audioPlayer.play(AssetSource('splash_audio.mp3'));
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainMenu()), 
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when the splash screen is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_bg.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animation.json', 
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

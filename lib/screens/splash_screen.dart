import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clock_game/screens/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final AudioPlayer _audioPlayer = AudioPlayer(); // Global AudioPlayer

  @override
  void initState() {
    super.initState();
    _playLoadingAudio();
    _navigateToHome();
  }

  void _playLoadingAudio() async {
    // Stop any currently playing audio before starting new playback
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
    _audioPlayer.stop(); // Stop audio when disposing the splash screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_bg.png'),
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

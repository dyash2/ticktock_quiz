import 'dart:async'; // Import Timer class
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/clock_face.dart';
import '../models/mcq_options.dart'; // Import the unified file
import 'result_screen.dart';

class ClockGame extends StatefulWidget {
  const ClockGame({super.key});

  @override
  _ClockGameState createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  late Timer _timer;
  int _remainingTime = 120; // Countdown time in seconds

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _questions = generateRandomQuestions(10);
    _currentQuestionIndex = 0;
    _score = 0;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        _showFinalScore();
      }
    });
  }

  void _checkAnswer(String selectedOption) {
    String correctAnswer = _questions[_currentQuestionIndex].correctAnswer;

    if (selectedOption == correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    _timer.cancel();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FinalScoreScreen(
          score: _score,
          totalQuestions: _questions.length,
          onPlayAgain: _playAgain,
        ),
      ),
    );
  }

  void _playAgain() {
    Navigator.of(context).pop();
    setState(() {
      _startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = _questions[_currentQuestionIndex];
    double progress =
        (_currentQuestionIndex + 1) / _questions.length; // Progress percentage

    // Determine the color based on remaining time
    Color timerColor;
    if (_remainingTime > 100) {
      timerColor = Colors.green;
    } else if (_remainingTime > 50) {
      timerColor = Colors.yellow;
    } else {
      timerColor = Colors.red;
    }

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/game_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClockFace(time: currentQuestion.time),
                  McqOptions(
                    question: currentQuestion,
                    onOptionSelected: _checkAnswer,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressIndicator(
                      title: "Progress",
                      value: progress,
                      color: Colors.blueAccent,
                      backgroundColor: Colors.blueGrey,
                    ),
                    _buildProgressIndicator(
                      title: "Time",
                      value: _remainingTime / 120,
                      color: timerColor,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator({
    required String title,
    required double value,
    required Color color,
    required Color backgroundColor,
  }) {
    // Calculate percentage
    String percentageText = (value * 100).toStringAsFixed(0) + '%';

    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: backgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              percentageText,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

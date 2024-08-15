import 'package:flutter/material.dart';
import '../models/clock_face.dart';
import '../models/mcq_options.dart'; // Import the unified file
import '../routes/routes.dart';
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

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _questions = generateRandomQuestions(10);
    _currentQuestionIndex = 0;
    _score = 0;
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
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/game_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClockFace(time: currentQuestion.time),
            Column(
              
              children: [
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.mainMenu);
                }, icon:Icon(Icons.close)),
                McqOptions(
                  question: currentQuestion,
                  onOptionSelected: _checkAnswer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

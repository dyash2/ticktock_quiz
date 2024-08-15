import 'dart:math';
import 'package:flutter/material.dart';

// Question class with a method to get the correct answer
class Question {
  final DateTime time;
  final List<String> options;

  Question(this.time, this.options);

  String get correctAnswer {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

// Function to generate random questions
List<Question> generateRandomQuestions(int count) {
  final random = Random();
  List<Question> questions = [];

  for (int i = 0; i < count; i++) {
    // Generate random time
    int hour = random.nextInt(12) + 1;  // Hours between 1 and 12
    int minute = random.nextInt(60);    // Minutes between 0 and 59
    DateTime time = DateTime(2024, 8, 15, hour, minute);

    // Create options, one of them is correct
    List<String> options = [
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      '${random.nextInt(12) + 1}:${random.nextInt(60).toString().padLeft(2, '0')}',
      '${random.nextInt(12) + 1}:${random.nextInt(60).toString().padLeft(2, '0')}',
      '${random.nextInt(12) + 1}:${random.nextInt(60).toString().padLeft(2, '0')}',
    ];

    // Shuffle options to randomize their order
    options.shuffle(random);

    // Add question to the list
    questions.add(Question(time, options));
  }

  return questions;
}

// Widget to display a list of multiple-choice options
class McqOptions extends StatelessWidget {
  final Question question;
  final Function(String) onOptionSelected;

  const McqOptions({
    required this.question,
    required this.onOptionSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: question.options
          .map((option) => GestureDetector(
                onTap: () => onOptionSelected(option),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.blueAccent,
                  child: Text(option, style: const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ))
          .toList(),
    );
  }
}

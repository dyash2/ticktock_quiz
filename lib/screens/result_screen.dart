import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/routes.dart'; // Ensure this import is correct

class FinalScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onPlayAgain;

  const FinalScoreScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.onPlayAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/game_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/result_board.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Level 1",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 52,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              Text('Score',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFCA811),
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 4.0, // Border width
                  ),
                  borderRadius:
                      BorderRadius.circular(42.0), // Optional: Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 60.0), // Optional: Add padding
                child: Text(
                  '$score/$totalQuestions',
                  style: GoogleFonts.poppins(
                    color: Color(0xff400B10),
                    fontSize: 45,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onPlayAgain,
                    child: Image.asset("assets/retry_button.png", scale: 5,),
                  ),
                  const SizedBox(width: 30,),
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset("assets/play_button.png", scale: 5,),
                  ),
                   const SizedBox(width: 30,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mainMenu);
                    },
                    child: Image.asset("assets/home_button.png", scale: 5,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

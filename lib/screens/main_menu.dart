
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';
import 'clock_game.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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
              Expanded(flex:7,child: Image.asset("assets/main_icon.png", scale: 1)),
              Expanded(
                flex:2,
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
                        child:  Text(
                          'Quit'.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width:80),
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
                        child:  Text(
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

import 'package:flutter/material.dart';

import '../screens/clock_game.dart';
import '../screens/main_menu.dart';
import '../screens/splash_screen.dart';
import '../screens/result_screen.dart';


class AppRoutes {
  static const String splash = '/';

  static const String mainMenu = '/main-menu';
  static const String clockGame = '/clock-game';
  static const String result = '/result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mainMenu:
        return MaterialPageRoute(builder: (_) => const MainMenu());  

      case clockGame:
        return MaterialPageRoute(builder: (_) => const ClockGame());
      case result:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FinalScoreScreen(
            score: args['score'],
            totalQuestions: args['totalQuestions'],
            onPlayAgain: args['onPlayAgain'],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

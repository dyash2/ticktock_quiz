import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ClockFace extends StatelessWidget {
  final DateTime time;

  const ClockFace({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: ClockPainter(time: time),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = const Color(0xffF6F3E5)
      ..style = PaintingStyle.fill;

    final paintOutline = Paint()
      ..color = const Color(0xffC8945C)
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke;

    final paintOutline2 = Paint()
      ..color = const Color(0xffF3DB8C)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw the clock circle
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintOutline);
    canvas.drawCircle(center, radius, paintOutline2);

    // Draw clock hands
    drawHand(canvas, center, radius * 0.6, time.hour * 30 + time.minute * 0.5, 8);
    drawHand(canvas, center, radius * 0.8, time.minute * 6, 5);
    drawHand(canvas, center, radius * 0.9, 0, 2, Colors.red); // No second hand

    // Draw the hour and minute numbers
    drawNumbers(canvas, center, radius);
  }

  void drawNumbers(Canvas canvas, Offset center, double radius) {
    final textStyle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: radius * 0.15,
      fontWeight: FontWeight.bold,
    );

    for (int i = 1; i <= 12; i++) {
      final angle = (pi / 180) * (i * 30 - 90);
      final position = Offset(
        center.dx + cos(angle) * radius * 0.8,
        center.dy + sin(angle) * radius * 0.8,
      );

      final textPainter = TextPainter(
        text: TextSpan(text: '$i', style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      final offset = Offset(
        position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  void drawHand(Canvas canvas, Offset center, double length, double angle, double thickness, [Color color = Colors.black]) {
    final angleRad = (pi / 180) * (angle - 90);
    final handOffset = Offset(cos(angleRad) * length, sin(angleRad) * length);
    final handPaint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, center + handOffset, handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
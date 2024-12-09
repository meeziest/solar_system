import 'package:flutter/material.dart';
import 'package:solar_system/models/cosmic_object.dart';

final class HyperTextPainter extends CustomPainter {
  final Planet target;
  final String text;

  HyperTextPainter(
    this.text, {
    super.repaint,
    required this.target,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 0.2,
        fontWeight: FontWeight.bold,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(canvas, target.position + Offset(target.radius, -target.radius));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

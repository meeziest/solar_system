import 'package:flutter/material.dart';

import '../controllers/solar_system_controller.dart';

class OrbitsPainter extends CustomPainter {
  final SolarSystemController _controller;
  final double opacity;

  OrbitsPainter({
    required SolarSystemController controller,
    this.opacity = 1.0,
  })  : _controller = controller,
        super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    for (var cosmicObject in _controller.planets) {
      canvas.drawCircle(
        _controller.star.position,
        cosmicObject.orbitalRadius,
        Paint()
          ..strokeWidth = 0.2
          ..color = Colors.blueGrey.withOpacity(opacity)
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(covariant OrbitsPainter oldDelegate) =>
      !identical(oldDelegate._controller, _controller) && oldDelegate.opacity != opacity;

  @override
  bool shouldRebuildSemantics(covariant OrbitsPainter oldDelegate) => false;
}

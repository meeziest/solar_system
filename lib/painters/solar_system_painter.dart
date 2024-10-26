import 'package:flutter/material.dart';

import '../controllers/solar_system_controller.dart';
import '../models/cosmic_object.dart';

class SolarSystemPainter extends CustomPainter {
  final SolarSystemController _controller;

  SolarSystemPainter({
    required SolarSystemController controller,
  })  : _controller = controller,
        super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    paintSun(canvas, size);

    for (var cosmicObject in _controller.planets) {
      final innerGlowPaint = Paint()
        ..color = cosmicObject.color.withOpacity(0.75)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(
        cosmicObject.position,
        cosmicObject.radius * 1.5,
        innerGlowPaint,
      );
      canvas.drawCircle(
        cosmicObject.position,
        cosmicObject.radius,
        Paint()
          ..color = cosmicObject.color
          ..style = PaintingStyle.fill,
      );
      if (cosmicObject case WithSatellites(satellites: var satellites)) {
        for (var satellite in satellites) {
          final innerGlowPaint = Paint()
            ..color = satellite.color.withOpacity(0.75)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

          canvas.drawCircle(
            satellite.position,
            satellite.radius * 1.25,
            innerGlowPaint,
          );
          canvas.drawCircle(
            satellite.position,
            satellite.radius,
            Paint()
              ..color = satellite.color
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
  }

  void paintSun(Canvas canvas, Size size) {
    final outerGlowPaint = Paint()
      ..color = _controller.star.color.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    final innerGlowPaint = Paint()
      ..color = _controller.star.color.withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // glow effect for the sun
    canvas.drawCircle(
      _controller.star.position,
      _controller.star.realRelativeRadius * 4.5,
      outerGlowPaint,
    );
    canvas.drawCircle(
      _controller.star.position,
      _controller.star.realRelativeRadius * 1.5,
      innerGlowPaint,
    );

    canvas.drawCircle(
      _controller.star.position,
      _controller.star.radius,
      Paint()
        ..color = _controller.star.color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant SolarSystemPainter oldDelegate) => !identical(
        oldDelegate._controller,
        _controller,
      );

  @override
  bool shouldRebuildSemantics(covariant SolarSystemPainter oldDelegate) => false;
}

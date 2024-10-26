import 'dart:math';
import 'dart:ui';

import 'cosmic_object.dart';

abstract interface class OrbitalMotionBehavior {
  abstract final double speedFactor;
  abstract final CosmicObject orbit;

  void updatePosition(CosmicObject planet);
}

class CircularOrbitBehavior implements OrbitalMotionBehavior {
  @override
  final CosmicObject orbit;

  @override
  final double speedFactor;

  CircularOrbitBehavior({required this.orbit, this.speedFactor = 1});

  @override
  void updatePosition(CosmicObject cosmicObject) {
    cosmicObject.angle += (orbit.speed + cosmicObject.speed) * speedFactor;
    cosmicObject.angle %= 2 * pi;

    final dx = orbit.position.dx + cosmicObject.orbitalRadius * cos(cosmicObject.angle);
    final dy = orbit.position.dy + cosmicObject.orbitalRadius * sin(cosmicObject.angle);

    cosmicObject.position = Offset(dx, dy);
  }
}

class EllipticalOrbitBehavior implements OrbitalMotionBehavior {
  @override
  final CosmicObject orbit;

  @override
  final double speedFactor;

  EllipticalOrbitBehavior({required this.orbit, this.speedFactor = 1});

  @override
  void updatePosition(CosmicObject planet) {
    /// TODO: Implement elliptical orbit behavior
    throw UnimplementedError();
  }
}

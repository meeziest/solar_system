import 'dart:math';
import 'dart:ui';

import 'cosmic_object.dart';

abstract interface class OrbitalMotionBehavior {
  abstract final double speedFactor;
  abstract final CosmicObject orbit;

  Offset updatePosition(CosmicObject planet);
}

class CircularOrbitBehavior implements OrbitalMotionBehavior {
  @override
  final CosmicObject orbit;

  @override
  final double speedFactor;

  CircularOrbitBehavior({required this.orbit, this.speedFactor = 1});

  @override
  Offset updatePosition(CosmicObject cosmicObject) {
    cosmicObject.angle += (orbit.speed + cosmicObject.speed) * speedFactor;
    cosmicObject.angle %= 2 * pi;

    final dx = orbit.position.dx + cosmicObject.orbitalRadius * cos(cosmicObject.angle);
    final dy = orbit.position.dy + cosmicObject.orbitalRadius * sin(cosmicObject.angle);

    cosmicObject.position = Offset(dx, dy);
    return cosmicObject.position;
  }
}

class EllipticalOrbitBehavior implements OrbitalMotionBehavior {
  @override
  final CosmicObject orbit;

  @override
  final double speedFactor;

  EllipticalOrbitBehavior({required this.orbit, this.speedFactor = 1});

  @override
  Offset updatePosition(CosmicObject planet) {
    /// TODO: Implement elliptical orbit behavior
    throw UnimplementedError();
  }
}

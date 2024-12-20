// Interfaces
import 'dart:ui';

import '../utils/utils.dart';
import 'behaviors.dart';

abstract interface class CosmicObject {
  abstract final String name;
  abstract final double realRelativeRadius;
  abstract final double showCaseRadius;
  abstract final Color color;
  abstract final double speed;
  abstract final double orbitalRadius;

  // Mutable motion fields
  abstract double angle;
  abstract Offset position;
  abstract double radius;
}

mixin WithOrbitalBehavior {
  void updatePosition(OrbitalMotionBehavior behavior);
}

mixin WithSatellites {
  List<Satellite> get satellites;
}

abstract class Star implements CosmicObject {
  @override
  final String name;
  @override
  final double realRelativeRadius;
  @override
  final double showCaseRadius;
  @override
  final Color color;
  @override
  final double speed;
  @override
  final double orbitalRadius;

  @override
  double angle;
  @override
  Offset position;
  @override
  double radius;

  Star({
    required this.name,
    required this.speed,
    required this.orbitalRadius,
    required this.color,
    required this.realRelativeRadius,
    this.position = const Offset(0, 0),
    this.angle = 0.0,
    double? showCaseRadius,
  })  : showCaseRadius = showCaseRadius ?? realRelativeRadius,
        radius = showCaseRadius ?? realRelativeRadius;
}

abstract class Planet with WithOrbitalBehavior implements CosmicObject {
  @override
  final String name;
  @override
  final double realRelativeRadius;
  @override
  final double showCaseRadius;
  @override
  final Color color;
  @override
  final double speed;
  @override
  final double orbitalRadius;
  final int maxTrailLength;
  final TiltAngle tiltAngle;

  @override
  double angle;
  @override
  Offset position;
  @override
  double radius;
  List<Offset> trailPositions = [];

  Planet({
    required this.name,
    required this.speed,
    required this.orbitalRadius,
    required this.color,
    required this.realRelativeRadius,
    this.position = const Offset(0, 0),
    this.angle = 0.0,
    this.tiltAngle = const TiltAngle(axis: TiltAxis.X, angle: 0),
    double? showCaseRadius,
  })  : showCaseRadius = showCaseRadius ?? realRelativeRadius,
        radius = showCaseRadius ?? realRelativeRadius,
        maxTrailLength = calculateMaxTrailLength(
          orbitalRadius: orbitalRadius,
          speed: speed,
        );

  @override
  Offset updatePosition(OrbitalMotionBehavior behavior) => behavior.updatePosition(this);
}

abstract class Satellite with WithOrbitalBehavior implements CosmicObject {
  @override
  final String name;
  @override
  final double realRelativeRadius;
  @override
  final double showCaseRadius;
  @override
  final Color color;
  @override
  final double speed;
  @override
  final double orbitalRadius;
  final TiltAngle tiltAngle;

  @override
  double angle;
  @override
  Offset position;
  @override
  double radius;

  Satellite({
    required this.name,
    required this.speed,
    required this.orbitalRadius,
    required this.color,
    required this.realRelativeRadius,
    this.position = const Offset(0, 0),
    this.angle = 0.0,
    this.tiltAngle = const TiltAngle(axis: TiltAxis.X, angle: 0),
    double? showCaseRadius,
  })  : showCaseRadius = showCaseRadius ?? realRelativeRadius,
        radius = showCaseRadius ?? realRelativeRadius;

  @override
  Offset updatePosition(OrbitalMotionBehavior behavior) => behavior.updatePosition(this);
}

enum TiltAxis { X, Y }

class TiltAngle {
  final TiltAxis axis;
  final double angle;

  const TiltAngle({required this.axis, required this.angle});
}

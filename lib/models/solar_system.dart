// Concrete Planet Classes
import 'dart:ui';

import 'cosmic_object.dart';

/// Sun
class Sun extends Star {
  Sun({
    required super.realRelativeRadius,
    required super.position,
    super.showCaseRadius,
  }) : super(
          name: 'Sun',
          speed: 0,
          orbitalRadius: 0,
          color: const Color(0xFFFFD700),
        );
}

/// Planets
class Mercury extends Planet {
  Mercury({
    super.speed = 0.03,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Mercury',
          tiltAngle: const TiltAngle(axis: TiltAxis.Y, angle: -7.0),
          color: const Color(0xFFB2B2B2),
        );
}

class Venus extends Planet {
  Venus({
    super.speed = 0.02,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Venus',
          tiltAngle: const TiltAngle(axis: TiltAxis.Y, angle: 3.4),
          color: const Color(0xFFEEDB00),
        );
}

class Earth extends Planet with WithSatellites {
  @override
  List<Satellite> satellites;

  Earth({
    super.speed = 0.01,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
    this.satellites = const [],
  }) : super(
          name: 'Earth',
          tiltAngle: const TiltAngle(axis: TiltAxis.X, angle: 0.0),
          color: const Color(0xFF0000FF),
        );
}

class Mars extends Planet with WithSatellites {
  @override
  List<Satellite> satellites;

  Mars({
    super.speed = 0.008,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
    this.satellites = const [],
  }) : super(
          name: 'Mars',
          tiltAngle: const TiltAngle(axis: TiltAxis.Y, angle: 1.9),
          color: const Color(0xFFFF0000),
        );
}

class Jupiter extends Planet {
  Jupiter({
    super.speed = 0.005,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Jupiter',
          tiltAngle: const TiltAngle(axis: TiltAxis.X, angle: 1.3),
          color: const Color(0xFFFFA500),
        );
}

class Saturn extends Planet {
  Saturn({
    super.speed = 0.004,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Saturn',
          tiltAngle: const TiltAngle(axis: TiltAxis.X, angle: -2.5),
          color: const Color(0xFFFFD700),
        );
}

class Uranus extends Planet {
  Uranus({
    super.speed = 0.003,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Uranus',
          tiltAngle: const TiltAngle(axis: TiltAxis.X, angle: 0.8),
          color: const Color(0xFF40E0D0),
        );
}

class Neptune extends Planet {
  Neptune({
    super.speed = 0.002,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle = 0,
    super.showCaseRadius,
  }) : super(
          name: 'Neptune',
          tiltAngle: const TiltAngle(axis: TiltAxis.Y, angle: -1.8),
          color: const Color(0xFF000080),
        );
}

/// Satellites
class Moon extends Satellite {
  Moon({
    super.speed = 0.01,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle,
    super.showCaseRadius,
  }) : super(
          name: 'Moon',
          color: const Color(0xFFFFFFFF),
        );
}

class Phobos extends Satellite {
  Phobos({
    super.speed = 0.03,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle,
    super.showCaseRadius,
  }) : super(
          name: 'Phobos',
          color: const Color(0xFF888888),
        );
}

class Deimos extends Satellite {
  Deimos({
    super.speed = 0.02,
    super.position,
    required super.orbitalRadius,
    required super.realRelativeRadius,
    super.angle,
    super.showCaseRadius,
  }) : super(
          name: 'Deimos',
          color: const Color(0xFFAAAAAA),
        );
}

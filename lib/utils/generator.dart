import 'dart:ui';

import '../controllers/solar_system_controller.dart';
import '../models/solar_system.dart';

abstract class PlanetarySystemGenerator {
  final double size;
  final Offset center;

  PlanetarySystemGenerator({required this.size, Offset? center}) //
      : center = center ?? Offset(size / 2, size / 2);
}

class SolarSystemGenerator extends PlanetarySystemGenerator {
  SolarSystemGenerator({required super.size});

  SolarSystemController generateSolarSystem() {
    double maxOrbitalRadius = size / 2;
    double maxCosmicObjectRadius = 0.02 * maxOrbitalRadius;
    double showCaseRadius = maxCosmicObjectRadius / 3;

    const double sunRealRadius = 696340.0;

    // Planets relative distances (as a fraction of the max radius)
    final List<double> relativeOrbitRadii = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0];

    // Planetary radii (as a fraction of the Sun's radius in reality)
    final double mercuryRadius = (2439.7 / sunRealRadius) * maxCosmicObjectRadius;
    final double venusRadius = (6051.8 / sunRealRadius) * maxCosmicObjectRadius;
    final double earthRadius = (6371.0 / sunRealRadius) * maxCosmicObjectRadius;
    final double moonRadius = (1737.4 / sunRealRadius) * maxCosmicObjectRadius;
    final double phobosRadius = (11.267 / sunRealRadius) * maxCosmicObjectRadius;
    final double deimosRadius = (6.2 / sunRealRadius) * maxCosmicObjectRadius;
    final double marsRadius = (3389.5 / sunRealRadius) * maxCosmicObjectRadius;
    final double jupiterRadius = (69911 / sunRealRadius) * maxCosmicObjectRadius;
    final double saturnRadius = (58232 / sunRealRadius) * maxCosmicObjectRadius;
    final double uranusRadius = (25362 / sunRealRadius) * maxCosmicObjectRadius;
    final double neptuneRadius = (24622 / sunRealRadius) * maxCosmicObjectRadius;

    return SolarSystemController(
      speedFactor: 0.25,

      /// Sun
      star: Sun(
        position: center,
        showCaseRadius: maxCosmicObjectRadius,
        realRelativeRadius: showCaseRadius,
      ),

      /// Planets
      planets: [
        Mercury(
          position: center,
          realRelativeRadius: mercuryRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[0],
          speed: 0.0717,
          angle: 0,
        ),
        Venus(
          position: center,
          realRelativeRadius: venusRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[1],
          speed: 0.0278,
          angle: 0,
        ),
        Earth(
          position: center,
          realRelativeRadius: earthRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[2],
          speed: 0.0172,
          angle: 0,
          satellites: [
            Moon(
              position: center,
              realRelativeRadius: moonRadius,
              showCaseRadius: showCaseRadius * 0.2,
              orbitalRadius: maxOrbitalRadius * 0.04,
              speed: 0.229,
              angle: 0,
            ),
          ],
        ),
        Mars(
          position: center,
          realRelativeRadius: marsRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[3],
          speed: 0.00914,
          angle: 0,
          satellites: [
            // Phobos(
            //   position: center,
            //   realRelativeRadius: phobosRadius,
            //   showCaseRadius: showCaseRadius * 0.2,
            //   orbitalRadius: maxOrbitalRadius * 0.03,
            //   angle: 0.3,
            // ),
            // Deimos(
            //   position: center,
            //   realRelativeRadius: deimosRadius,
            //   showCaseRadius: showCaseRadius * 0.2,
            //   orbitalRadius: maxOrbitalRadius * 0.04,
            //   angle: 0.6,
            // ),
          ],
        ),
        Jupiter(
          position: center,
          realRelativeRadius: jupiterRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[4],
          speed: 0.00145,
          angle: 0,
        ),
        Saturn(
          position: center,
          realRelativeRadius: saturnRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[5],
          speed: 0.000583,
          angle: 0,
        ),
        Uranus(
          position: center,
          realRelativeRadius: uranusRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[6],
          speed: 0.000205,
          angle: 0,
        ),
        Neptune(
          position: center,
          realRelativeRadius: neptuneRadius,
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[7],
          speed: 0.000104,
          angle: 0,
        ),
      ],
    );
  }
}

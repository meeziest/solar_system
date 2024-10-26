import 'package:flutter/material.dart';
import 'package:solar_system/controllers/solar_system_controller.dart';
import 'package:solar_system/models/cosmic_object.dart';
import 'package:solar_system/utils/generator.dart';
import 'package:solar_system/widgets/solart_system.dart';

class SolarSystemApp extends StatelessWidget {
  final double solarSystemSize = 500;
  late final SolarSystemGenerator generator = SolarSystemGenerator(size: solarSystemSize);
  late final SolarSystemController controller = generator.generateSolarSystem();

  SolarSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff030035),
        body: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.planets.length,
                  (index) {
                    final planet = controller.planets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              if (controller.zoom) {
                                controller.zoomOut();
                              } else {
                                controller.zoomPlanet(500, planet: planet);
                              }
                            },
                            child: Text(planet.name),
                          ),
                          if (planet case WithSatellites(satellites: var satellites))
                            ...List.generate(
                              satellites.length,
                              (index) {
                                final satellite = satellites[index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: FilledButton.tonal(
                                    onPressed: () {
                                      if (controller.zoom) {
                                        controller.zoomOut();
                                      } else {
                                        controller.zoomPlanet(500, planet: satellite);
                                      }
                                    },
                                    child: Text(satellite.name),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: RepaintBoundary(
                  child: SolarSystemWidget(
                    controller: controller,
                    size: solarSystemSize,
                    zoomInDuration: const Duration(seconds: 3),
                    zoomOutDuration: const Duration(seconds: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

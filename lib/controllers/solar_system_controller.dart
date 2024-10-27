import 'package:flutter/cupertino.dart';
import 'package:solar_system/controllers/zoom_controller.dart';
import 'package:solar_system/utils/utils.dart';

import '../models/cosmic_object.dart';

final class SolarSystemController extends ChangeNotifier {
  final Star star;
  final List<Planet> planets;
  final ZoomController zoomController;
  final double maxSpeedFactor;
  double speedFactor;
  double zoomScale;

  SolarSystemController({
    required this.planets,
    required this.star,
    double? speedFactor,
    this.zoomScale = 100,
  })  : maxSpeedFactor = speedFactor ?? 0.2,
        speedFactor = speedFactor ?? 0.2,
        zoomController = ZoomController();

  CosmicObject? selectedPlanet;

  bool get zoom => zoomController.zoom;

  void zoomPlanet<T extends CosmicObject>(double zoomScale, {T? planet}) {
    if (planet != null) {
      selectedPlanet = planet;
    } else {
      selectedPlanet = planets.firstWhereOrNull((planet) => planet is T);
    }
    if (selectedPlanet != null) {
      this.zoomScale = zoomScale;
      zoomController.zoomIn();
    }
  }

  void zoomOut() => zoomController.zoomOut();

  void stop() {
    if (zoom) return;
    if (speedFactor == 0) {
      speedFactor = maxSpeedFactor;
    } else {
      speedFactor = 0;
    }
    notifyListeners();
  }

  void repaint() => notifyListeners();
}

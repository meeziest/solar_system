import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:solar_system/painters/orbits_painter.dart';
import 'package:solar_system/painters/solar_system_painter.dart';
import 'package:solar_system/utils/generator.dart';
import 'package:solar_system/utils/utils.dart';
import 'package:solar_system/widgets/zoom_widget.dart';

import '../controllers/solar_system_controller.dart';
import '../models/behaviors.dart';
import '../models/cosmic_object.dart';

class SolarSystemWidget extends StatefulWidget {
  SolarSystemWidget({
    super.key,
    required this.size,
    SolarSystemController? controller,
    this.zoomInDuration = const Duration(seconds: 3),
    this.zoomOutDuration = const Duration(seconds: 1),
  }) : solarSystemController = controller ?? SolarSystemGenerator(size: size).generateSolarSystem();

  final double size;
  final SolarSystemController solarSystemController;
  final Duration zoomInDuration;
  final Duration zoomOutDuration;

  @override
  State<SolarSystemWidget> createState() => _SolarSystemWidgetState();
}

class _SolarSystemWidgetState extends State<SolarSystemWidget> with TickerProviderStateMixin {
  late final Ticker _ticker;

  SolarSystemController get controller => widget.solarSystemController;

  double _rotateX = -1.0;
  double _orbitOpacity = 1.0;

  Matrix4 get _perspectiveMatrix => Matrix4.identity()
    ..setEntry(3, 2, 0.00124)
    ..rotateX(_rotateX);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(onTick);
    _ticker.start();
    controller.addListener(checkSpeedFactor);
  }

  OrbitalMotionBehavior get _sunOrbitBehavior => CircularOrbitBehavior(
        orbit: controller.star,
        speedFactor: controller.speedFactor,
      );

  OrbitalMotionBehavior _planetOrbitBehavior(Planet planet) => CircularOrbitBehavior(
        orbit: planet,
        speedFactor: controller.speedFactor,
      );

  Duration prevElapsed = Duration.zero;
  void onTick(Duration elapsed) {
    prevElapsed = elapsed - prevElapsed;
    for (var planet in controller.planets) {
      planet.updatePosition(_sunOrbitBehavior);
      planet.trailPositions.add(planet.position);

      if (planet.trailPositions.length > planet.maxTrailLength) {
        planet.trailPositions.removeAt(0);
      }

      if (planet case WithSatellites(satellites: var satellites)) {
        for (var satellite in satellites) {
          satellite.updatePosition(_planetOrbitBehavior(planet));
        }
      }
    }
    if (controller.speedFactor != 0.0) controller.repaint();
  }

  void onZoomInTick(double delta) {
    scalePlanets(t: delta, zoom: true);
    _rotateX = $lerpDouble(-1.0, 0.0, Curves.easeOutQuart.transform(delta));
    _orbitOpacity = $lerpDouble(1.0, 0.0, Curves.easeOutExpo.transform(delta));
    controller.speedFactor = $lerpDouble(
      controller.maxSpeedFactor,
      0.0,
      Curves.linear.transform(delta),
    );
    setState(() {});
  }

  void onZoomOutTick(double delta) {
    scalePlanets(t: delta, zoom: false);
    _rotateX = $lerpDouble(0.0, -1.0, Curves.easeInBack.transform(delta));
    _orbitOpacity = $lerpDouble(0.0, 1.0, Curves.easeInExpo.transform(delta));
    controller.speedFactor = $lerpDouble(
      0.0,
      controller.maxSpeedFactor,
      Curves.easeInExpo.transform(delta),
    );
    setState(() {});
  }

  void scalePlanets({required double t, required bool zoom}) {
    controller.star.radius = $lerpDouble(
      zoom ? controller.star.showCaseRadius : controller.star.realRelativeRadius,
      zoom ? controller.star.realRelativeRadius : controller.star.showCaseRadius,
      zoom ? Curves.easeOutCubic.transform(t) : Curves.easeInExpo.transform(t),
    );
    for (var planet in controller.planets) {
      planet.radius = $lerpDouble(
        zoom ? planet.showCaseRadius : planet.realRelativeRadius,
        zoom ? planet.realRelativeRadius : planet.showCaseRadius,
        zoom ? Curves.easeOutCubic.transform(t) : Curves.easeInExpo.transform(t),
      );
      if (planet case WithSatellites(satellites: var satellites)) {
        for (var satellite in satellites) {
          satellite.radius = $lerpDouble(
            zoom ? satellite.showCaseRadius : satellite.realRelativeRadius,
            zoom ? satellite.realRelativeRadius : satellite.showCaseRadius,
            zoom ? Curves.easeOutCubic.transform(t) : Curves.easeInExpo.transform(t),
          );
        }
      }
    }
  }

  void checkSpeedFactor() {
    if (controller.zoom) return;
    if (controller.speedFactor == 0) {
      _ticker.stop();
      prevElapsed = Duration.zero;
      controller.speedFactor = 0;
    }
    if (controller.speedFactor == controller.maxSpeedFactor) {
      if (!_ticker.isTicking) {
        _ticker.start();
      }
    }
  }

  Offset get zoomTarget {
    if (controller.selectedPlanet case var planet?) {
      return Offset(
        widget.size / 2 - planet.position.dx,
        widget.size / 2 - planet.position.dy,
      );
    } else {
      return Offset.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      child: Transform(
        transform: _perspectiveMatrix,
        alignment: FractionalOffset.center,
        child: ZoomWidget(
          zoomController: controller.zoomController,
          zoomInDuration: widget.zoomInDuration,
          zoomOutDuration: widget.zoomOutDuration,
          zoomScale: controller.zoomScale,
          zoomTarget: zoomTarget,
          onZoomStart: () => !controller.zoom && !_ticker.isActive ? _ticker.start() : null,
          onZoomInTick: onZoomInTick,
          onZoomOutTick: onZoomOutTick,
          onZoomEnd: () => controller.zoom ? _ticker.stop() : null,
          child: SizedBox.square(
            dimension: widget.size,
            child: CustomPaint(
              painter: OrbitsPainter(controller: controller, opacity: _orbitOpacity),
              foregroundPainter: SolarSystemPainter(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(checkSpeedFactor);
    _ticker.dispose();
    super.dispose();
  }
}

import 'dart:math';

import 'package:flutter/animation.dart';

abstract class CustomCurves {
  static const Curve zoomIn = _ZoomInCurve();
  static const Curve zoomOut = _ZoomOutCurve();
  static const Curve quadratic = _QuadraticSymmetricCurve();
  static const Curve stopTime = _StopTimeCurve();
}

class _ZoomInCurve extends Curve {
  const _ZoomInCurve();

  @override
  double transformInternal(double t) {
    return const Cubic(0.6, -0.0045, 0.735, 0.045).transform(t);
  }
}

class _ZoomOutCurve extends Curve {
  const _ZoomOutCurve();

  @override
  double transformInternal(double t) {
    return const Cubic(0.77, 0.0, 0.175, 1.0).transform(t);
  }
}

class _QuadraticSymmetricCurve extends Curve {
  const _QuadraticSymmetricCurve();

  @override
  double transformInternal(double t) {
    return 0.5 + 0.5 * pow(2 * t - 1, 2);
  }
}

class _StopTimeCurve extends Curve {
  const _StopTimeCurve();

  @override
  double transformInternal(double t) {
    if (t <= 0.5) {
      return const Cubic(0.77, 0.0, 0.175, 1.0).transform(t * 2);
    } else {
      return 1.0;
    }
  }
}

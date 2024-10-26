import 'package:flutter/animation.dart';

abstract class ZoomCurves {
  static const Curve zoomIn = _ZoomInCurve();
  static const Curve zoomOut = _ZoomOutCurve();
}

class _ZoomInCurve extends Curve {
  const _ZoomInCurve();

  @override
  double transformInternal(double t) {
    return const Cubic(0.6, 0.0, 0.735, 0.045).transform(t);
  }
}

class _ZoomOutCurve extends Curve {
  const _ZoomOutCurve();

  @override
  double transformInternal(double t) {
    return const Cubic(0.77, 0.0, 0.175, 1.0).transform(t);
  }
}

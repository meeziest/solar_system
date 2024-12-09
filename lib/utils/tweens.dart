import 'package:flutter/animation.dart';
import 'package:solar_system/utils/curves.dart';
import 'package:solar_system/utils/utils.dart';

class ZoomData {
  final Offset focalPoint;
  final double zoomScale;

  ZoomData({required this.focalPoint, required this.zoomScale});
}

class ZoomInTween extends Tween<ZoomData> {
  ZoomInTween({required ZoomData super.begin, required ZoomData super.end});

  @override
  ZoomData lerp(double t) {
    assert(begin != null);
    assert(end != null);

    final newT = CustomCurves.zoomIn.transform(t);
    return ZoomData(
      focalPoint: $lerpOffset(begin!.focalPoint, end!.focalPoint, newT),
      zoomScale: $lerpDouble(begin!.zoomScale, end!.zoomScale, newT),
    );
  }
}

class ZoomOutTween extends Tween<ZoomData> {
  ZoomOutTween({required ZoomData super.begin, required ZoomData super.end});

  @override
  ZoomData lerp(double t) {
    assert(begin != null);
    assert(end != null);

    final newT = CustomCurves.zoomOut.transform(t);
    return ZoomData(
      focalPoint: $lerpOffset(begin!.focalPoint, end!.focalPoint, newT),
      zoomScale: $lerpDouble(begin!.zoomScale, end!.zoomScale, newT),
    );
  }
}

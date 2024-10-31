import 'dart:math';

import 'package:flutter/cupertino.dart';

double $lerpDouble(double a, double b, double t) => a * (1.0 - t) + b * t;

Offset $lerpOffset(Offset a, Offset b, double t) => Offset(
      $lerpDouble(a.dx, b.dx, t),
      $lerpDouble(a.dy, b.dy, t),
    );

int calculateMaxTrailLength({
  required double orbitalRadius,
  required double speed,
  double trailPercentage = 35,
}) {
  double circumference = 2 * pi * orbitalRadius;
  double trailLength = circumference * (trailPercentage / 100);
  return (trailLength / (1 - speed)).round();
}

extension IterableExt<E> on Iterable {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

Matrix4 createOrbitTransform(double tiltAngle) {
  Matrix4 matrix = Matrix4.identity();
  matrix.setEntry(3, 2, 1e-3);
  matrix.rotateX(tiltAngle);
  matrix.rotateY(tiltAngle);
  return matrix;
}

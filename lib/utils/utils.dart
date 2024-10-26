import 'dart:ui';

double $lerpDouble(double a, double b, double t) => a * (1.0 - t) + b * t;

Offset $lerpOffset(Offset a, Offset b, double t) => Offset(
      $lerpDouble(a.dx, b.dx, t),
      $lerpDouble(a.dy, b.dy, t),
    );

extension IterableExt<E> on Iterable {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

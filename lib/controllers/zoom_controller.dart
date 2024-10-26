import 'package:flutter/material.dart';

class ZoomController extends ChangeNotifier {
  bool _zoom = false;
  bool get zoom => _zoom;

  void zoomIn() {
    _zoom = true;
    notifyListeners();
  }

  void zoomOut() {
    _zoom = false;
    notifyListeners();
  }
}

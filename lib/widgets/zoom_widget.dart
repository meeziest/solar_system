import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../controllers/zoom_controller.dart';
import '../utils/curves.dart';
import '../utils/utils.dart';

class ZoomWidget extends StatefulWidget {
  const ZoomWidget({
    super.key,
    required this.zoomController,
    required this.zoomTarget,
    required this.zoomScale,
    required this.child,
    this.onZoomStart,
    this.onZoomInTick,
    this.onZoomOutTick,
    this.onZoomEnd,
    this.zoomInDuration = const Duration(seconds: 3),
    this.zoomOutDuration = const Duration(seconds: 1),
  });

  final ZoomController zoomController;
  final VoidCallback? onZoomStart;
  final void Function(double delta)? onZoomInTick;
  final void Function(double delta)? onZoomOutTick;
  final Offset zoomTarget;
  final double zoomScale;
  final Duration zoomInDuration;
  final Duration zoomOutDuration;
  final VoidCallback? onZoomEnd;
  final Widget child;

  @override
  State<ZoomWidget> createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget> with SingleTickerProviderStateMixin {
  late final Ticker _zoomTicker;
  ZoomController get _controller => widget.zoomController;

  @override
  void initState() {
    super.initState();
    _zoomTicker = createTicker(onTick);
    _controller.addListener(onZoom);
  }

  void onZoom() {
    if (!_zoomTicker.isActive) _zoomTicker.start();
  }

  double delta = 0;

  final double _startScale = 1;
  final Offset _startPosition = Offset.zero;

  double scale = 1.0;
  Offset offset = Offset.zero;

  Duration zoomElapsed = Duration.zero;
  void onTick(Duration elapsed) {
    zoomElapsed = elapsed - zoomElapsed;
    final zoomDuration = _controller.zoom ? widget.zoomInDuration : widget.zoomOutDuration;
    delta = (zoomElapsed.inMicroseconds / zoomDuration.inMicroseconds).clamp(0, 1);

    if (delta == 0) widget.onZoomStart?.call();

    if (_controller.zoom) {
      widget.onZoomInTick?.call(delta);
      scale = $lerpDouble(
        _startScale,
        widget.zoomScale,
        CustomCurves.zoomIn.transform(delta),
      );
      offset = $lerpOffset(
        _startPosition,
        widget.zoomTarget,
        Curves.easeOutExpo.transform(delta),
      );
    } else {
      widget.onZoomOutTick?.call(delta);
      scale = $lerpDouble(
        widget.zoomScale,
        _startScale,
        CustomCurves.zoomOut.transform(delta),
      );
      offset = $lerpOffset(
        widget.zoomTarget,
        _startPosition,
        Curves.easeInExpo.transform(delta),
      );
    }

    if (delta == 1) {
      widget.onZoomEnd?.call();
      zoomElapsed = Duration.zero;
      _zoomTicker.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(scale)
        ..translate(offset.dx, offset.dy),
      alignment: FractionalOffset.center,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(onZoom);
    super.dispose();
  }
}

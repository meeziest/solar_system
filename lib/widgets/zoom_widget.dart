import 'package:flutter/material.dart';
import 'package:solar_system/utils/tweens.dart';

import '../controllers/zoom_controller.dart';

class ZoomAnimationWidget extends StatefulWidget {
  const ZoomAnimationWidget({
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
  State<ZoomAnimationWidget> createState() => _ZoomAnimationWidgetState();
}

class _ZoomAnimationWidgetState extends State<ZoomAnimationWidget> with SingleTickerProviderStateMixin {
  ZoomController get _controller => widget.zoomController;

  Offset _startPosition = Offset.zero;
  Offset _endPosition = Offset.zero;

  double _startScale = 1;
  double _endScale = 1;

  late final AnimationController _animationController;
  late Animation<ZoomData> _animation;

  @override
  void initState() {
    super.initState();

    _startScale = 1;
    _endScale = widget.zoomScale;

    _startPosition = Offset.zero;
    _endPosition = widget.zoomTarget;

    _animationController = AnimationController(
      duration: widget.zoomInDuration,
      reverseDuration: widget.zoomOutDuration,
      vsync: this,
    );

    _animation = _animationController.drive(
      ZoomInTween(
        begin: ZoomData(
          focalPoint: _startPosition,
          zoomScale: _startScale,
        ),
        end: ZoomData(
          focalPoint: _endPosition,
          zoomScale: _endScale,
        ),
      ),
    );

    _controller.addListener(onZoom);
  }

  @override
  void didUpdateWidget(covariant ZoomAnimationWidget oldWidget) {
    if (oldWidget.zoomController != widget.zoomController) {
      oldWidget.zoomController.removeListener(onZoom);
      widget.zoomController.addListener(onZoom);
    }
    _endPosition = widget.zoomTarget;
    _animation = _animationController.drive(
      ZoomInTween(
        begin: ZoomData(
          focalPoint: _startPosition,
          zoomScale: _startScale,
        ),
        end: ZoomData(
          focalPoint: _endPosition,
          zoomScale: _endScale,
        ),
      ),
    );
    super.didUpdateWidget(oldWidget);
  }

  void onZoom() {
    if (_controller.zoom) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (context, child) {
          return Transform(
              transform: Matrix4.identity()
                ..translate(
                  _animation.value.focalPoint.dx,
                  _animation.value.focalPoint.dy,
                )
                ..scale(_animation.value.zoomScale),
              child: child ?? const SizedBox());
        },
      );

  @override
  void dispose() {
    _controller.removeListener(onZoom);
    super.dispose();
  }
}

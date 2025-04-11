import 'package:flutter/material.dart';

class DoubleClickZoomableView extends StatefulWidget {
  final Widget child;
  final double zoomAmount;
  final double minScale;
  final double maxScale;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  const DoubleClickZoomableView({
    super.key,
    required this.child,
    this.zoomAmount = 2.0,
    this.minScale = 1.0,
    this.maxScale = 4.0,
    this.onZoomIn,
    this.onZoomOut,
  });

  @override
  State<DoubleClickZoomableView> createState() =>
      _DoubleClickZoomableViewState();
}

class _DoubleClickZoomableViewState extends State<DoubleClickZoomableView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  late TransformationController _transformationController;
  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    final newValue =
        _transformationController.value.isIdentity()
            ? _applyZoom()
            : _revertZoom();

    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: newValue,
    ).animate(
      CurveTween(
        curve: Curves.fastLinearToSlowEaseIn,
      ).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  Matrix4 _applyZoom() {
    final tapPosition = _doubleTapDetails!.localPosition;
    final zoomed =
        Matrix4.identity()
          ..translate(-tapPosition.dx, -tapPosition.dy)
          ..scale(widget.zoomAmount);
    if (widget.onZoomIn != null) widget.onZoomIn!.call();
    return zoomed;
  }

  Matrix4 _revertZoom() {
    if (widget.onZoomOut != null) widget.onZoomOut!.call();
    return Matrix4.identity();
  }

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
      _transformationController.value = _zoomAnimation!.value;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      onDoubleTapDown: _handleDoubleTapDown,
      child: InteractiveViewer(
        maxScale: widget.maxScale,
        minScale: widget.minScale,
        transformationController: _transformationController,
        child: widget.child,
      ),
    );
  }
}

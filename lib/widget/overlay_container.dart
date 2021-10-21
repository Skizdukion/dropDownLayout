import 'package:flutter/material.dart';

class OverlayContainer extends StatefulWidget {
  /// The child to render inside the container.
  final Widget child;

  /// By default, the child will be rendered right below (if the parent is `Column`)
  /// the widget which is defined alongside the OverlayContainer.
  /// It would appear as though the Overlay is inside its parent
  /// but in reality it would be outside and above
  /// the original widget hierarchy.
  /// It's position can be altered and the overlay can
  /// be moved to any part of the screen by supplying a `position`
  /// argument.
  final OverlayContainerPosition position;

  /// Controlling whether the overlay is current showing or not.
  final bool show;

  /// Whether the overlay is wide as its enclosing parent.
  final bool asWideAsParent;

  /// `color` attribute for the `Material` component that wraps `child`.
  final Color materialColor;

  final Duration duraion;

  const OverlayContainer({
    Key? key,
    required this.show,
    required this.child,
    this.duraion = const Duration(milliseconds: 300),
    this.asWideAsParent = false,
    this.position = const OverlayContainerPosition(0.0, 0.0),
    this.materialColor = Colors.transparent,
  }) : super(key: key);

  @override
  _OverlayContainerState createState() => _OverlayContainerState();
}

class _OverlayContainerState extends State<OverlayContainer>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  bool _opened = false;

  late final AnimationController _animationController = AnimationController(
    duration: widget.duraion,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.ease,
  );

  Widget _animated(Widget child) {
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1,
      sizeFactor: _animation,
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      _show();
    }
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    // We would want to re render the overlay if any metrics
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We would want to re render the overlay if any of the dependencies
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didUpdateWidget(OverlayContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void dispose() {
    if (widget.show) {
      _overlayEntry.remove();
      _opened = false;
    }
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _show() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // await Future.delayed(Duration(milliseconds: 280));
      if (_opened) {
        _overlayEntry.remove();
      }
      _overlayEntry = _buildOverlayEntry();
      _animationController.forward();
      Overlay.of(context)?.insert(_overlayEntry);
      _opened = true;
    });
  }

  void _hide() {
    if (_opened) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _animationController.reverse().whenComplete(() {
          _overlayEntry.remove();
          _opened = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in media query such as when a device orientation changes
    // or when the keyboard is toggled.
    MediaQuery.of(context);
    return Container();
  }

  OverlayEntry _buildOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: widget.position.left,
          top: offset.dy - widget.position.bottom + 13,
          width: MediaQuery.of(context).size.width,
          // width: widget.asWideAsParent ? size.width : null,
          child: Material(
            child: _animated(widget.child),
            color: Colors.black.withOpacity(0.5),
          ),
        );
      },
    );
  }
}

class OverlayContainerPosition {
  final double left;
  final double bottom;

  const OverlayContainerPosition(this.left, this.bottom);
}

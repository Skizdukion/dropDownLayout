import 'package:flutter/material.dart';

class AnimatedDropdown extends StatefulWidget {
  const AnimatedDropdown({ Key? key, this.duration = const Duration(milliseconds: 300), required this.children, required this.display}) : super(key: key);

  final Duration duration;

  final List<Widget> children;

  final bool display;

  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown> with SingleTickerProviderStateMixin,WidgetsBindingObserver {

  late final AnimationController _animationController = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.ease,
  );

  @override
  void initState() {
    if (widget.display) {
      _animationController.forward();    
    }
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.display) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didChangeMetrics() {
    // We would want to re render the overlay if any metrics
    // ever change.
    if (widget.display) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(AnimatedDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.display) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1,
      sizeFactor: _animation,
      child: Container(
        child: Column(
          children: widget.children,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }
}
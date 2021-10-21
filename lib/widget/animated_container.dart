import 'package:flutter/material.dart';

class AnimatedContainer extends StatefulWidget {
  const AnimatedContainer({ Key? key, this.duration = const Duration(milliseconds: 300) }) : super(key: key);

  final Duration duration;

  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer> with SingleTickerProviderStateMixin {

  late final AnimationController _animationController = AnimationController(
    duration: widget.duration,
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
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
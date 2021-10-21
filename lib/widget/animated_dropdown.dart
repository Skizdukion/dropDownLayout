import 'package:flutter/material.dart';

class AnimatedDropdown extends StatefulWidget {
  const AnimatedDropdown({ Key? key, this.opacity = 0.2 , this.duration = const Duration(milliseconds: 300), required this.children, required this.display, this.onClose}) : super(key: key);

  final Duration duration;

  final List<Widget> children;

  final bool display;

  final double opacity;

  final Function(bool)? onClose;

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
    curve: Curves.easeOut,
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
          children: [
            for (var item in widget.children) item,
            Expanded(child:
            InkWell(
              onTap: (){
                _animationController.reverse();
                if (widget.onClose != null) widget.onClose!.call(!widget.display);
              }
            )),
          ]
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ((widget.opacity > 1) && (widget.opacity < 0)) ? Colors.black.withOpacity(0.3) :  Colors.black.withOpacity(widget.opacity),
      ),
    );
  }
}
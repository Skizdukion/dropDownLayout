import 'package:flutter/material.dart';

class CustomDropDownBtn extends StatefulWidget {
  const CustomDropDownBtn({ Key? key, 
    required this.text, 
    required this.onPress, 
    this.height = 30, 
    this.width = 100,
    this.color = Colors.white,
    this.isDropDown = true,
  }) : super(key: key);

  final String text;
  final Function(bool) onPress;
  final double width;
  final double height;
  final Color color;
  final bool isDropDown;

  @override
  _CustomDropDownBtnState createState() => _CustomDropDownBtnState();
}

class _CustomDropDownBtnState extends State<CustomDropDownBtn> {

  @override
  void didUpdateWidget(CustomDropDownBtn oldWidget) {
    super.didUpdateWidget(oldWidget);

  }

  void toggle(){
    widget.onPress.call(!widget.isDropDown);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggle,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        width: widget.width,
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.text, style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),),
            Icon(
              widget.isDropDown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
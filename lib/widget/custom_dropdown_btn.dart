import 'package:flutter/material.dart';

class CustomDropDownBtn extends StatefulWidget {
  const CustomDropDownBtn({ Key? key, 
    required this.text, 
    required this.onPress, 
    this.height = 30, 
    this.width = 100,
    this.color = Colors.white,
  }) : super(key: key);

  final String text;
  final Function(bool) onPress;
  final double width;
  final double height;
  final Color color;

  @override
  _CustomDropDownBtnState createState() => _CustomDropDownBtnState();
}

class _CustomDropDownBtnState extends State<CustomDropDownBtn> {

  bool isDropDown = false;

  void toggle(){
    setState(() {
      isDropDown = !isDropDown;
    });
    widget.onPress.call(isDropDown);
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
              isDropDown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}